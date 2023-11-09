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
  Scoreboard *scoreboard;

  Simulator(MemoryManager *memory,Scoreboard *scoreboard);
  ~Simulator();

  void initStack(uint32_t baseaddr, uint32_t maxSize);

  void simulate();

  void dumpHistory();

  void printInfo();

  void printStatistics();


private: 

  struct IReg {
    // Control Signals
    bool bubble;
    uint32_t stall;
    uint64_t pc;
    RISCV::RegId rs1, rs2;
    RISCV::RegId dest;
    int64_t op1,op2,offset;
    RISCV::Inst inst;
    FunctionalUnit unit;
  } iIntReg,iIntRegNew,iAddReg,iAddRegNew,iMul1Reg,iMul1RegNew,iMul2Reg,iMul2RegNew,iDivReg,iDivRegNew;

  struct RReg {
    // Control Signals
    bool bubble;
    uint32_t stall;
    RISCV::RegId rs1, rs2;
    uint64_t pc;
    RISCV::Inst inst;
    int64_t op1;
    int64_t op2;
    RISCV::RegId dest;
    int64_t offset;
    FunctionalUnit unit;
    bool predictedBranch;
  } rIntReg,rIntRegNew,rAddReg,rAddRegNew,rMul1Reg,rMul1RegNew,rMul2Reg,rMul2RegNew,rDivReg,rDivRegNew;
  struct EReg {
    // Control Signals
    bool bubble;
    uint32_t stall;
    uint64_t pc;
    RISCV::Inst inst;
    int64_t op1;
    int64_t op2;
    bool writeReg;
    RISCV::RegId destReg;
    int64_t out;
    bool writeMem;
    bool readMem;
    bool readSignExt;
    uint32_t memLen;
    FunctionalUnit unit;
    bool branch;
  } eIntReg,eIntRegNew,eAddReg,eAddRegNew,eMul1Reg,eMul1RegNew,eMul2Reg,eMul2RegNew,eDivReg,eDivRegNew;;


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

  // void fetch();
  // void decode();
  // void excecute();
  // void memoryAccess();
  // void writeBack();
  void issue(uint64_t instPC);
  void read(uint64_t instPC);
  void execute(uint64_t instPC);
  void writeBack(uint64_t instPC);

  int64_t handleSystemCall(int64_t op1, int64_t op2);

  std::string getRegInfoStr();
  void panic(const char *format, ...);
};

#endif
