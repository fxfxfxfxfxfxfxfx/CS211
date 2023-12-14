/*
 * Implementation of a simple cache simulator
 *
 * Created By He, Hao in 2019-04-27
 */
#include <cstdio>
#include <cstdlib>
#include "Cache.h"
std::deque<uint32_t> traceList;
Cache::Cache(MemoryManager *manager, Policy policy, Cache *lowerCache,
             Cache *higherCache,bool writeBack, bool writeAllocate,
             replacePolicy repStrategy,inclusivePolicy clusStrategy,
             Cache *victimCache) {
  this->referenceCounter = 0;
  this->memory = manager;
  this->policy = policy;
  this->lowerCache = lowerCache;
  this->higherCache = higherCache;
  this->clusStrategy = clusStrategy;
  this->repStrategy = repStrategy;
  std::vector<std::vector<uint32_t>> tem(this->policy.blockNum/this->policy.associativity);
  this->FIFOQUEUE=tem;
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
  this->statistics.totalCycles += this->policy.missLatency;
  if (!this->loadBlockFromVictim(addr,cycles)) {
    this->loadBlockFromLowerLevel(addr, cycles);
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
  if(this->clusStrategy==EXCLUSIVE)
    this->expelSameBlockInLowerCache(addr);
  if(this->clusStrategy==INCLUSIVE&&this->higherCache!=nullptr){
    int blockId;
    if ((blockId = this->higherCache->getBlockId(addr)) != -1){
      replaceBlock = this->higherCache->blocks[blockId];
      this->higherCache->blocks[blockId].valid=false;
    }
  }
  if (this->writeBack && replaceBlock.valid &&
      replaceBlock.modified) { // write back to memory
    if(this->clusStrategy==INCLUSIVE&&this->higherCache==nullptr){
      this->writeBlockToVictim(replaceBlock);
    }
    this->writeBlockToLowerLevel(replaceBlock);
    this->statistics.totalCycles += this->policy.missLatency;
  }

  this->blocks[replaceId] = b;
}
bool Cache::loadBlockFromVictim(uint32_t addr,uint32_t* cycles){
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
    if (this->victimCache != nullptr) {
      // b.data[i - blockAddrBegin] = this->lowerCache->getByte(i, cycles);
      this->referenceCounter++;
      this->statistics.numRead++;
      // If in cache, return directly
      int blockId;
      if ((blockId = this->victimCache->getBlockId(addr)) != -1) {
        uint32_t offset = this->victimCache->getOffset(addr);
        this->victimCache->statistics.numHit++;
        this->victimCache->statistics.totalCycles += this->victimCache->policy.hitLatency;
        this->victimCache->blocks[blockId].lastReference = this->referenceCounter;
        this->victimCache->blocks[blockId].rrpv = 0;
        if (cycles) *cycles = this->victimCache->policy.hitLatency;
        b.data[i - blockAddrBegin]=this->victimCache->blocks[blockId].data[offset];
        this->victimCache->blocks[blockId].valid=false;
        uint32_t id = this->victimCache->getId(addr);
        uint32_t begin = id * this->victimCache->policy.associativity;
        uint32_t end = (id + 1) * this->victimCache->policy.associativity;
        for(uint32_t i = begin; i < end; ++i){
          if(this->victimCache->FIFOQUEUE[id][i]==blockId)
            this->FIFOQUEUE[id].erase(this->FIFOQUEUE[id].begin()+i);
        }
      }
      else{
        return false;
      }
      if(this->clusStrategy==EXCLUSIVE){
        this->expeBlockFromVictim(addr);
      }
      if(this->clusStrategy==INCLUSIVE){
        // this->loadBlockFromVictimToLowerCache
        this->loadBlockFromVictimToLowerCache(addr,this->victimCache->blocks[blockId],cycles);
      }
      return true;
    } 
  }
}
void Cache::loadBlockFromVictimToLowerCache(uint32_t addr,Block victimBlock,uint32_t *cycles){
  int blockId;
  if ((blockId = this->lowerCache->getBlockId(addr)) == -1){
    uint32_t blockSize = this->lowerCache->policy.blockSize;
    Block b;
    b.valid = true;
    b.modified = false;
    b.tag = this->lowerCache->getTag(addr);
    b.id = this->lowerCache->getId(addr);
    b.size = blockSize;
    b.data = std::vector<uint8_t>(b.size);
    b.rrpv = (1<<this->M)-2;
    uint32_t bits = this->log2i(blockSize);
    uint32_t mask = ~((1 << bits) - 1);
    uint32_t blockAddrBegin = addr & mask;
    for (uint32_t i = blockAddrBegin; i < blockAddrBegin + blockSize; ++i) {
      b.data[i - blockAddrBegin] = this->lowerCache->getByteFromVictim(i, cycles);
    }
  }
}
uint8_t Cache::getByteFromVictim(uint32_t addr,uint32_t *cycles ){
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
}

void Cache::expeBlockFromVictim(uint32_t addr){
  int blockId;
  if ((blockId = this->lowerCache->getBlockId(addr)) != -1){
    this->lowerCache->blocks[blockId].valid=false;
  }
}
uint32_t Cache::getReplacementBlockId(uint32_t begin, uint32_t end,replacePolicy strategy) {
  // Find invalid block first
  uint32_t id=begin/this->policy.associativity;
  auto it=this->FIFOQUEUE[id].begin();
  for (uint32_t i = begin; i < end; ++i) {
    if (!this->blocks[i].valid){
      if(strategy==FIFO)
        this->FIFOQUEUE[id].push_back(i);
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
  case FIFO:
    resultId=this->FIFOQUEUE[id].front();
    this->FIFOQUEUE[id].push_back(resultId);
    
    this->FIFOQUEUE[id].erase(it);
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
void Cache::writeBlockToVictim(Cache::Block &b){
  uint32_t addrBegin = this->getAddr(b);
  if (this->victimCache != nullptr) {
    for (uint32_t i = 0; i < b.size; ++i) {
      for (uint32_t i = 0; i < b.size; ++i) {
      this->victimCache->setByte(addrBegin + i, b.data[i]);
      }
    }
  } 
}
void Cache::setHigherCache(Cache* higherCacher){
  this->higherCache=higherCache;
}

void Cache::setVictimCache(Cache* victimCache){
  this->victimCache=victimCache;
}

void Cache::expelSameBlockInLowerCache(uint32_t addr){
  if(this->lowerCache!=nullptr){
    int blockId;
    if ((blockId = this->lowerCache->getBlockId(addr)) != -1){
      this->lowerCache->blocks[blockId].valid=false;
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