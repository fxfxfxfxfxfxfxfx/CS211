/*
 * Main Body for the RISCV Simulator
 *
 * Created by He, Hao at 2019-3-11
 */

#ifndef SIMULATOR_H
#define SIMULATOR_H

#include <cstdarg>
#include <string>
#include <vector>


#include "MemoryManager.h"
#include "Scoreboard.h"

class Simulator {
public:
  bool isSingleStep;
  bool verbose;
  bool shouldDumpHistory;
  uint64_t pc;
  uint64_t predictedPC; // for branch prediction module, predicted PC destination
  uint64_t anotherPC; // // another possible prediction destination
  uint64_t reg[RISCV::REGNUM];
  uint32_t stackBase;
  uint32_t maximumStackSize;
  MemoryManager *memory;
  struct snapShotUnit
  {
    uint64_t pc;
    instCompleteSchedule instSc;
  }tem;
  vector<snapShotUnit> snapShot;
  Scoreboard *scoreboard;

  Simulator(MemoryManager *memory,Scoreboard *scoreboard);
  ~Simulator();

  void initStack(uint32_t baseaddr, uint32_t maxSize);

  void simulate();

  void dumpHistory();

  void printInfo();

  void printStatistics();


private: 
  // Pipeline Related Variables
  // To avoid older values(in MEM) overriding newer values(in EX)
  bool executeWriteBack;
  RISCV::RegId executeWBReg;
  bool memoryWriteBack;
  RISCV::RegId memoryWBReg;
  struct History {
    uint32_t instCount;
    uint32_t cycleCount;
    uint32_t stalledCycleCount;

    uint32_t dataHazardCount;
    uint32_t stallDataHazardCount;
    uint32_t controlHazardCount;
    uint32_t memoryHazardCount;
    uint32_t structureHazardCount;
    uint32_t stallStructureHazardCount;
    

    std::vector<std::string> instRecord;
    std::vector<std::string> regRecord;

    std::string memoryDump;
  } history;

  void issue(uint64_t instPC);
  void read(uint64_t instPC);
  void execute(uint64_t instPC);
  void writeBack(uint64_t instPC);

  int64_t handleSystemCall(int64_t op1, int64_t op2);

  std::string getRegInfoStr();
  void panic(const char *format, ...);
};

#endif
