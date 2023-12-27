/*
 * Main Body for the RISCV Simulator
 *
 * Created by He, Hao at 2019-3-11
 */

#ifndef SIMULATOR_H
#define SIMULATOR_H

#include <cstdarg>
#include <cstdint>
#include <string>
#include <vector>

#include "BranchPredictor.h"
#include "MemoryManager.h"
#include "Tomasulo.h"


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
  BranchPredictor *branchPredictor;
  tomasulo ts;
  
  Simulator(MemoryManager *memory, BranchPredictor *predictor);
  ~Simulator();

  void initStack(uint32_t baseaddr, uint32_t maxSize);

  void simulate();

  void dumpHistory();

  void printInfo();

  void printStatistics();

private:
  
  // Pipeline Related Variables
  // To avoid older values(in MEM) overriding newer values(in EX)
  bool fetchPasue;
  bool executeWriteBack;
  RISCV::RegId executeWBReg;
  bool memoryWriteBack;
  RISCV::RegId memoryWBReg;
  struct History {
    uint32_t instCount;
    uint32_t cycleCount;
    uint32_t stalledCycleCount;

    uint32_t predictedBranch; // Number of branch that is predicted successfully
    uint32_t unpredictedBranch; // Number of branch that is not predicted
                                // successfully

    uint32_t dataHazardCount;
    uint32_t controlHazardCount;
    uint32_t memoryHazardCount;

    std::vector<std::string> instRecord;
    std::vector<std::string> regRecord;

    std::string memoryDump;
  } history;


  void issue();
  void excecute(FunctionalUnit fu,uint32_t entry);
  void writeBack(uint32_t entry);
  void commit(uint32_t entry);

  int64_t handleSystemCall(int64_t op1, int64_t op2);

  std::string getRegInfoStr();
  void panic(const char *format, ...);
};

#endif
