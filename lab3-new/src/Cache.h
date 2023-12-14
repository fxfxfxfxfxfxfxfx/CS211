/*
 * Basic cache simulator
 *
 * Created by He, Hao on 2019-4-27
 */

#ifndef CACHE_H
#define CACHE_H

#include <cstdint>
#include <vector>
#include <deque>
#include "MemoryManager.h"

enum inclusivePolicy{
  NINE,
  INCLUSIVE,
  EXCLUSIVE,
};

enum replacePolicy{
  LRU,
  RRIP,
  FIFO,
  OPTIMAL,
};

class MemoryManager;

class Cache {
public:
  struct Policy {
    // In bytes, must be power of 2
    uint32_t cacheSize;
    uint32_t blockSize;
    uint32_t blockNum;
    uint32_t associativity;
    uint32_t hitLatency;  // in cycles
    uint32_t missLatency; // in cycles
  };

  struct Block {
    bool valid;
    bool modified;
    uint32_t tag;
    uint32_t id;
    uint32_t size;
    uint32_t rrpv;
    uint32_t lastReference;
    std::vector<uint8_t> data;
    Block() {}
    Block(const Block &b)
        : valid(b.valid), modified(b.modified), tag(b.tag), id(b.id),
          size(b.size) {
      data = b.data;
    }
  };

  struct Statistics {
    uint32_t numRead;
    uint32_t numWrite;
    uint32_t numHit;
    uint32_t numMiss;
    uint64_t totalCycles;
  };

  Cache(MemoryManager *manager, Policy policy, Cache *lowerCache = nullptr,
        bool writeBack = true, bool writeAllocate = true,
        inclusivePolicy clusStrategy=NINE);

  bool inCache(uint32_t addr);
  uint32_t getBlockId(uint32_t addr);
  uint8_t getByte(uint32_t addr, uint32_t *cycles = nullptr);
  void setByte(uint32_t addr, uint8_t val, uint32_t *cycles = nullptr);
  void setHigherCache(Cache* higherCache);
  void setVictimCache(uint32_t size);
  void setReplacePolicy(replacePolicy rep);
  void setInclusionPolicy(inclusivePolicy clu);
  void printInfo(bool verbose);
  void printStatistics();

  Statistics statistics;

private:
  uint32_t referenceCounter;
  bool writeBack;     // default true
  bool writeAllocate; // default true
  replacePolicy repStrategy; //用于保存替换策略
  uint32_t M=4;        //用于保存RRIP中的M
  MemoryManager *memory;
  Cache *lowerCache;
  Cache *higherCache;
  Cache *victimCache;
  std::vector<uint32_t> FIFOQUEUE;
  inclusivePolicy clusStrategy;
  Policy policy;
  std::vector<Block> blocks;

  void initCache();
  void loadBlockFromLowerLevel(uint32_t addr, uint32_t *cycles = nullptr);
  bool loadBlockFromVictim(uint32_t addr, uint32_t *cycles = nullptr);
  uint32_t getReplacementBlockId(uint32_t begin, uint32_t end,replacePolicy strategy=LRU);
  uint32_t deleteReplacementBlockIdVictim();
  void writeBlockToLowerLevel(Block &b);
  void writeBlockToVictim(Block &b);
  void keepInclusiveFromVictim(uint32_t addr,Block victimBlock,uint32_t *cycles = nullptr);
  void keepExclusiveFromVictim(uint32_t addr,uint32_t *cycle=nullptr);
  void expelSameBlockInLowerCache(uint32_t addr);

  // Utility Functions
  bool isPolicyValid();
  bool isPowerOfTwo(uint32_t n);
  uint32_t log2i(uint32_t val);
  uint32_t getTag(uint32_t addr);
  uint32_t getId(uint32_t addr);
  uint32_t getOffset(uint32_t addr);
  uint32_t getAddr(Block &b);
  uint32_t getTagId(uint32_t);
  uint32_t getNext(uint32_t addr);
};

#endif