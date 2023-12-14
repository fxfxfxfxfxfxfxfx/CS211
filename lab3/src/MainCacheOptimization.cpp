/**
 * Entry point for the optimized cache
 *
 * Created by He, Hao at 2019/04/30
 */

#include <cstdint>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

#include "Cache.h"
#include "Debug.h"
#include "MemoryManager.h"
extern std::deque<uint32_t> traceList;
bool parseParameters(int argc, char **argv);
void printUsage();

const char *traceFilePath;

int main(int argc, char **argv) {
  if (!parseParameters(argc, argv)) {
    return -1;
  }

  Cache::Policy l1policy, l2policy;
  l1policy.cacheSize = 32 * 1024;
  l1policy.blockSize = 64;
  l1policy.blockNum = 32 * 1024 / 64;
  l1policy.associativity = 8;
  l1policy.hitLatency = 2;
  l1policy.missLatency = 8;
  l2policy.cacheSize = 256 * 1024;
  l2policy.blockSize = 64;
  l2policy.blockNum = 256 * 1024 / 64;
  l2policy.associativity = 8;
  l2policy.hitLatency = 8;
  l2policy.missLatency = 100;

  // Initialize memory and cache
  MemoryManager *memory = nullptr;
  Cache *l1cache = nullptr, *l2cache = nullptr;
  memory = new MemoryManager();
  l2cache = new Cache(memory, l2policy);
  l1cache = new Cache(memory, l1policy, l2cache);
  l2cache->setHigherCache(l1cache);
  // victim = new Cache(memory,)
  memory->setCache(l1cache);

  // Read and execute trace in cache-trace/ folder
  std::ifstream trace1(traceFilePath);
  if (!trace1.is_open()) {
    printf("Unable to open file %s\n", traceFilePath);
    exit(-1);
  }
  char type; //'r' for read, 'w' for write
  uint32_t addr;
  while (trace1 >> type >> std::hex >> addr) {
    if (!memory->isPageExist(addr))
      traceList.push_back(addr);
  }
  printf("size=%d\n",traceList.size());
  std::ifstream trace(traceFilePath);
  while (trace >> type >> std::hex >> addr) {
    if (!memory->isPageExist(addr))
      memory->addPage(addr);
      printf("00000000\n");
    switch (type) {
    case 'r':
      memory->getByte(addr);
      traceList.pop_front();
      break;
    case 'w':
      memory->setByte(addr, 0);
      traceList.pop_front();
      break;
    default:
      dbgprintf("Illegal type %c\n", type);
      exit(-1);
    }
  }

  // Output Simulation Results
  printf("L1 Cache:\n");
  l1cache->printStatistics();

  delete l1cache;
  delete l2cache;
  delete memory;
  return 0;
}

bool parseParameters(int argc, char **argv) {
  // Read Parameters
  if (argc > 1) {
    traceFilePath = argv[1];
    return true;
  } else {
    return false;
  }
}

void printUsage() { printf("Usage: CacheSim trace-file\n"); }