/*
 * Implementation of a simple cache simulator
 *
 * Created By He, Hao in 2019-04-27
 */

#include <cstdio>
#include <cstdlib>

#include "Cache.h"

std::deque<uint32_t> traceList; //用来记录optinal替换算法中的访问

Cache::Cache(MemoryManager *manager, Policy policy, Cache *lowerCache,
             bool writeBack, bool writeAllocate,inclusivePolicy clusStrategy) {
  this->referenceCounter = 0;
  this->memory = manager;
  this->policy = policy;
  this->lowerCache = lowerCache;
  this->repStrategy=repStrategy;
  this->clusStrategy=clusStrategy;
  if (!this->isPolicyValid()) {
    fprintf(stderr, "Policy invalid!\n");
    exit(-1);
  }
  this->initCache();
  this->statistics.numRead = 0;
  this->statistics.numWrite = 0;
  this->statistics.numHit = 0;
  this->statistics.numMiss = 0;
  this->statistics.totalCycles = 0;
  this->writeBack = writeBack;
  this->writeAllocate = writeAllocate;
}

bool Cache::inCache(uint32_t addr) {
  return getBlockId(addr) != -1 ? true : false;
}

uint32_t Cache::getBlockId(uint32_t addr) {
  uint32_t tag = this->getTag(addr);
  uint32_t id = this->getId(addr);
  // printf("0x%x 0x%x 0x%x\n", addr, tag, id);
  // iterate over the given set
  for (uint32_t i = id * policy.associativity;
       i < (id + 1) * policy.associativity; ++i) {
    if (this->blocks[i].id != id) {
      fprintf(stderr, "Inconsistent ID in block %d\n", i);
      exit(-1);
    }
    if (this->blocks[i].valid && this->blocks[i].tag == tag) {
      return i;
    }
  }
  return -1;
}

uint8_t Cache::getByte(uint32_t addr, uint32_t *cycles) {
  this->referenceCounter++;
  this->statistics.numRead++;

  // If in cache, return directly
  int blockId;
  if ((blockId = this->getBlockId(addr)) != -1) {
    uint32_t offset = this->getOffset(addr);
    this->statistics.numHit++;
    this->statistics.totalCycles += this->policy.hitLatency;
    this->blocks[blockId].lastReference = this->referenceCounter;
    this->blocks[blockId].rrpv = 0;
    if (cycles) *cycles = this->policy.hitLatency;
    return this->blocks[blockId].data[offset];
  }

  // Else, find the data in memory or other level of cache
  this->statistics.numMiss++;
  bool flag=this->loadBlockFromVictim(addr,cycles);
  if(!flag){
    this->loadBlockFromLowerLevel(addr, cycles);
    this->statistics.totalCycles += this->policy.missLatency;
  }
  else{
    this->statistics.totalCycles += 1;
  }

  // The block is in top level cache now, return directly
  if ((blockId = this->getBlockId(addr)) != -1) {
    uint32_t offset = this->getOffset(addr);
    this->blocks[blockId].lastReference = this->referenceCounter;
    return this->blocks[blockId].data[offset];
  } else {
    fprintf(stderr, "Error: data not in top level cache!\n");
    exit(-1);
  }
}

void Cache::setByte(uint32_t addr, uint8_t val, uint32_t *cycles) {
  this->referenceCounter++;
  this->statistics.numWrite++;
  // If in cache, write to it directly
  int blockId;
  if ((blockId = this->getBlockId(addr)) != -1) {
    uint32_t offset = this->getOffset(addr);
    this->statistics.numHit++;
    this->statistics.totalCycles += this->policy.hitLatency;
    this->blocks[blockId].modified = true;
    this->blocks[blockId].lastReference = this->referenceCounter;
    this->blocks[blockId].rrpv = 0;
    this->blocks[blockId].data[offset] = val;
    if (!this->writeBack) {
      this->writeBlockToLowerLevel(this->blocks[blockId]);
      this->statistics.totalCycles += this->policy.missLatency;
    }
    if (cycles) *cycles = this->policy.hitLatency;
    return;
  }
  // Else, load the data from cache
  // TODO: implement bypassing
  this->statistics.numMiss++;
  this->statistics.totalCycles += this->policy.missLatency;

  if (this->writeAllocate) {
    if(!this->loadBlockFromVictim(addr,cycles))
      this->loadBlockFromLowerLevel(addr, cycles);
    if ((blockId = this->getBlockId(addr)) != -1) {
      uint32_t offset = this->getOffset(addr);
      this->blocks[blockId].modified = true;
      this->blocks[blockId].lastReference = this->referenceCounter;
      this->blocks[blockId].data[offset] = val;
      return;
    } else {
      fprintf(stderr, "Error: data not in top level cache!\n");
      exit(-1);
    }
  } else {
    if (this->lowerCache == nullptr) {
      this->memory->setByteNoCache(addr, val);
    } else {
      this->lowerCache->setByte(addr, val);
    }
  }
}

void Cache::printInfo(bool verbose) {
  printf("---------- Cache Info -----------\n");
  printf("Cache Size: %d bytes\n", this->policy.cacheSize);
  printf("Block Size: %d bytes\n", this->policy.blockSize);
  printf("Block Num: %d\n", this->policy.blockNum);
  printf("Associativiy: %d\n", this->policy.associativity);
  printf("Hit Latency: %d\n", this->policy.hitLatency);
  printf("Miss Latency: %d\n", this->policy.missLatency);

  if (verbose) {
    for (int j = 0; j < this->blocks.size(); ++j) {
      const Block &b = this->blocks[j];
      printf("Block %d: tag 0x%x id %d %s %s (last ref %d)\n", j, b.tag, b.id,
             b.valid ? "valid" : "invalid",
             b.modified ? "modified" : "unmodified", b.lastReference);
      // printf("Data: ");
      // for (uint8_t d : b.data)
      // printf("%d ", d);
      // printf("\n");
    }
  }
}

void Cache::printStatistics() {
  printf("-------- STATISTICS ----------\n");
  printf("Num Read: %d\n", this->statistics.numRead);
  printf("Num Write: %d\n", this->statistics.numWrite);
  printf("Num Hit: %d\n", this->statistics.numHit);
  printf("Num Miss: %d\n", this->statistics.numMiss);
  printf("Total Cycles: %llu\n", this->statistics.totalCycles);
  if (this->lowerCache != nullptr) {
    printf("---------- LOWER CACHE ----------\n");
    this->lowerCache->printStatistics();
  }
}

bool Cache::isPolicyValid() {
  if (!this->isPowerOfTwo(policy.cacheSize)) {
    fprintf(stderr, "Invalid Cache Size %d\n", policy.cacheSize);
    return false;
  }
  if (!this->isPowerOfTwo(policy.blockSize)) {
    fprintf(stderr, "Invalid Block Size %d\n", policy.blockSize);
    return false;
  }
  if (policy.cacheSize % policy.blockSize != 0) {
    fprintf(stderr, "cacheSize %% blockSize != 0\n");
    return false;
  }
  if (policy.blockNum * policy.blockSize != policy.cacheSize) {
    fprintf(stderr, "blockNum * blockSize != cacheSize\n");
    return false;
  }
  if (policy.blockNum % policy.associativity != 0) {
    fprintf(stderr, "blockNum %% associativity != 0\n");
    return false;
  }
  return true;
}

void Cache::initCache() {
  this->blocks = std::vector<Block>(policy.blockNum);
  for (uint32_t i = 0; i < this->blocks.size(); ++i) {
    Block &b = this->blocks[i];
    b.valid = false;
    b.modified = false;
    b.size = policy.blockSize;
    b.tag = 0;
    b.id = i / policy.associativity;
    b.lastReference = 0;
    b.data = std::vector<uint8_t>(b.size);
  }
}

void Cache::loadBlockFromLowerLevel(uint32_t addr, uint32_t *cycles) {
  uint32_t blockSize = this->policy.blockSize;

  // Initialize new block from memory
  Block b;
  b.valid = true;
  b.modified = false;
  b.tag = this->getTag(addr);
  b.id = this->getId(addr);
  b.size = blockSize;
  b.data = std::vector<uint8_t>(b.size);
  b.rrpv = (1<<this->M)-2;
  uint32_t bits = this->log2i(blockSize);
  uint32_t mask = ~((1 << bits) - 1);
  uint32_t blockAddrBegin = addr & mask;
  for (uint32_t i = blockAddrBegin; i < blockAddrBegin + blockSize; ++i) {
    if (this->lowerCache == nullptr) {
      b.data[i - blockAddrBegin] = this->memory->getByteNoCache(i);
      if (cycles) *cycles = 100;
    } else 
      b.data[i - blockAddrBegin] = this->lowerCache->getByte(i, cycles);
  }

  // Find replace block
  uint32_t id = this->getId(addr);
  uint32_t blockIdBegin = id * this->policy.associativity;
  uint32_t blockIdEnd = (id + 1) * this->policy.associativity;
  uint32_t replaceId = this->getReplacementBlockId(blockIdBegin, blockIdEnd);
  Block replaceBlock = this->blocks[replaceId];
  //处理包含策略
  if(this->clusStrategy==EXCLUSIVE)
    this->expelSameBlockInLowerCache(addr);
  if(this->clusStrategy==INCLUSIVE&&this->higherCache!=nullptr){
    int blockId;
    if ((blockId = this->higherCache->getBlockId(addr)) != -1){
      replaceBlock = this->higherCache->blocks[blockId];
      uint32_t temaddr=this->higherCache->getAddr(replaceBlock);
      replaceBlock.tag=this->getTag(temaddr);
      replaceBlock.id=this->getId(temaddr);
      this->higherCache->blocks[blockId].valid=false;
    }
  }

  if (this->writeBack && replaceBlock.valid &&
      replaceBlock.modified) { // write back to memory
    this->writeBlockToLowerLevel(replaceBlock);
    if(this->victimCache!=nullptr){
      this->writeBlockToVictim(replaceBlock);
    }
    this->statistics.totalCycles += this->policy.missLatency;
  }

  this->blocks[replaceId] = b;
}

uint32_t Cache::getReplacementBlockId(uint32_t begin, uint32_t end,replacePolicy strategy) {
  // Find invalid block first
  uint32_t id=begin/this->policy.associativity;
  for (uint32_t i = begin; i < end; ++i) {
    if (!this->blocks[i].valid){
      return i;
    }
  }
  uint32_t resultId = begin;
  uint32_t min = this->blocks[begin].lastReference;
  uint32_t max = getNext(getAddr(this->blocks[begin]));
  switch (strategy)
  {
  case LRU:
    for (uint32_t i = begin; i < end; ++i) {
      if (this->blocks[i].lastReference < min) {
        resultId = i;
        min = this->blocks[i].lastReference;
      }
    }
    return resultId;
    break;
  case RRIP:
    while(true){
      for(uint32_t i = begin; i<end;i++){
        if(this->blocks[i].rrpv == (uint32_t)((1 << this->M)-1)){
          resultId = i;
          return resultId;
        }
      }
      for(uint32_t i = begin; i<end;i++){
        this->blocks[i].rrpv++;
      }
    }
  break;
    case OPTIMAL:
    for (uint32_t i = begin; i < end; ++i){
      if(getNext(getAddr(this->blocks[i]))>max){
        resultId=i;
        max=getNext(getAddr(this->blocks[i]));
      }
    }
    break;
  default:
    fprintf(stderr, "Error: Invalid replacement strategy!\n");
    break;
  }
  return resultId;
}

void Cache::writeBlockToLowerLevel(Cache::Block &b) {
  uint32_t addrBegin = this->getAddr(b);
  if (this->lowerCache == nullptr) {
    for (uint32_t i = 0; i < b.size; ++i) {
      this->memory->setByteNoCache(addrBegin + i, b.data[i]);
    }
  } else {
    for (uint32_t i = 0; i < b.size; ++i) {
      this->lowerCache->setByte(addrBegin + i, b.data[i]);
    }
  }
}

bool Cache::isPowerOfTwo(uint32_t n) { return n > 0 && (n & (n - 1)) == 0; }

uint32_t Cache::log2i(uint32_t val) {
  if (val == 0)
    return uint32_t(-1);
  if (val == 1)
    return 0;
  uint32_t ret = 0;
  while (val > 1) {
    val >>= 1;
    ret++;
  }
  return ret;
}

uint32_t Cache::getTag(uint32_t addr) {
  uint32_t offsetBits = log2i(policy.blockSize);
  uint32_t idBits = log2i(policy.blockNum / policy.associativity);
  uint32_t mask = (1 << (32 - offsetBits - idBits)) - 1;
  return (addr >> (offsetBits + idBits)) & mask;
}

uint32_t Cache::getId(uint32_t addr) {
  uint32_t offsetBits = log2i(policy.blockSize);
  uint32_t idBits = log2i(policy.blockNum / policy.associativity);
  uint32_t mask = (1 << idBits) - 1;
  return (addr >> offsetBits) & mask;
}

uint32_t Cache::getOffset(uint32_t addr) {
  uint32_t bits = log2i(policy.blockSize);
  uint32_t mask = (1 << bits) - 1;
  return addr & mask;
}

uint32_t Cache::getAddr(Cache::Block &b) {
  uint32_t offsetBits = log2i(policy.blockSize);
  uint32_t idBits = log2i(policy.blockNum / policy.associativity);
  return (b.tag << (offsetBits + idBits)) | (b.id << offsetBits);
}
uint32_t Cache::getTagId(uint32_t addr){
  uint32_t bits = log2i(policy.blockSize);
  addr=addr>>bits;
  return addr<<bits;
}
uint32_t Cache::getNext(uint32_t addr){
  for(uint32_t i=0;i<traceList.size();i++){
    if(getTagId(addr)==getTagId(traceList[i]))
      return i;
  }
  return UINT32_MAX;
}

//以下方法用于处理包含策略
void Cache::setHigherCache(Cache* higherCache){
  this->higherCache=higherCache;
}
//用于维护exclusive策略下的Cache关系
void Cache::expelSameBlockInLowerCache(uint32_t addr){
  if(this->lowerCache!=nullptr){
    int blockId;
    if ((blockId = this->lowerCache->getBlockId(addr)) != -1){
      this->lowerCache->blocks[blockId].valid=false;
    }
  }
}

//用于victim cache的处理

//添加victim cache
void Cache::setVictimCache(uint32_t size){
  Cache::Policy victimPolicy;
  victimPolicy.cacheSize=size;
  victimPolicy.blockSize=this->policy.blockSize;
  victimPolicy.blockNum=victimPolicy.cacheSize/victimPolicy.blockSize;
  victimPolicy.associativity=victimPolicy.cacheSize/victimPolicy.blockSize;
  victimPolicy.hitLatency=9;
  victimPolicy.missLatency=9;
  Cache *victimCache=new Cache(nullptr,victimPolicy);
  if(this->higherCache==nullptr&&this->lowerCache!=nullptr){
    this->victimCache=victimCache;
  }
  else{
    fprintf(stderr, "Only for L1 cache add victim cache\n");
  }
}
void Cache::setReplacePolicy(replacePolicy rep){
  this->repStrategy=rep;
}
void Cache::setInclusionPolicy(inclusivePolicy clu){
  this->clusStrategy=clu;
}
bool Cache::loadBlockFromVictim(uint32_t addr,uint32_t *cycles ){
  if(this->victimCache==nullptr){
    return false;
  }
  // Initialize new block from memory
  uint32_t blockSize = this->policy.blockSize;
  Block b;
  b.valid = true;
  b.modified = false;
  b.tag = this->getTag(addr);
  b.id = this->getId(addr);
  b.size = blockSize;
  b.data = std::vector<uint8_t>(b.size);
  uint32_t bits = this->log2i(blockSize);
  uint32_t mask = ~((1 << bits) - 1);
  uint32_t blockAddrBegin = addr & mask;
  if(this->victimCache->inCache(addr)){
    b.data=this->victimCache->blocks[this->victimCache->getBlockId(addr)].data;
    //在victim中命中将其剔除
    int blockId=this->victimCache->getBlockId(addr);
    this->victimCache->blocks[blockId].valid=false;
    for(uint32_t i=0;i<this->victimCache->FIFOQUEUE.size();i++){
      if(this->victimCache->FIFOQUEUE[i]==blockId){
        this->victimCache->FIFOQUEUE.erase(this->victimCache->FIFOQUEUE.begin()+i);
        break;
      }
    }
    if(this->clusStrategy==INCLUSIVE&&!this->lowerCache->inCache(addr)){
      this->keepInclusiveFromVictim(addr,this->victimCache->blocks[blockId],cycles);
    }
    if(this->clusStrategy==EXCLUSIVE&&this->lowerCache->inCache(addr)){
      this->keepExclusiveFromVictim(addr);
    }
    // Find replace block
  uint32_t id = this->getId(addr);
  uint32_t blockIdBegin = id * this->policy.associativity;
  uint32_t blockIdEnd = (id + 1) * this->policy.associativity;
  uint32_t replaceId = this->getReplacementBlockId(blockIdBegin, blockIdEnd);
  Block replaceBlock = this->blocks[replaceId];


  if (this->writeBack && replaceBlock.valid &&
      replaceBlock.modified) { // write back to memory
    this->writeBlockToLowerLevel(replaceBlock);
    if(this->victimCache!=nullptr){
      this->writeBlockToVictim(replaceBlock);
    }
    this->statistics.totalCycles += this->policy.missLatency;
  }
  this->blocks[replaceId] = b;
    return true;
  }
  else{
    return false;
  }
}

void Cache::writeBlockToVictim(Block &b){
  uint32_t addrBegin = this->getAddr(b);
  uint32_t replaceId = this->victimCache->deleteReplacementBlockIdVictim();
  this->victimCache->blocks[replaceId]=b;
  this->victimCache->blocks[replaceId].tag=this->victimCache->getTag(addrBegin);
  this->victimCache->blocks[replaceId].id=this->victimCache->getId(addrBegin);
  this->victimCache->blocks[replaceId].modified=true;
  this->victimCache->blocks[replaceId].valid=true;
  this->victimCache->FIFOQUEUE.push_back(replaceId);
}
uint32_t Cache::deleteReplacementBlockIdVictim(){
  for(uint32_t i=0;i<this->policy.blockNum;i++){
    if(!this->blocks[i].valid){
      this->FIFOQUEUE.push_back(i);
      return i;
    }
  }
  uint32_t out=this->FIFOQUEUE.front();
  this->FIFOQUEUE.erase(this->FIFOQUEUE.begin());
  return out;
}
void Cache::keepInclusiveFromVictim(uint32_t addr,Block victimBlock,uint32_t *cycles){
  this->writeBlockToLowerLevel(victimBlock);
}

void Cache::keepExclusiveFromVictim(uint32_t addr,uint32_t *cycles){
    if(this->lowerCache!=nullptr){
    int blockId;
    if ((blockId = this->lowerCache->getBlockId(addr)) != -1){
      this->lowerCache->blocks[blockId].valid=false;
    }
  }
}