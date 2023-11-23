#ifndef SCOREBOARD_H
#define SCOREBOARD_H


#include "RISCV.h"
#include <vector>
#include <cstdint>
using namespace std;
using namespace RISCV;

// Scoreboard Data Structure
class Scoreboard{
public:
    bool pause;
    struct UnitStatus
    {
        uint64_t pc;
        bool busy;
        RISCV::FunctionalUnit name;
        uint32_t remainingPeriod;
        bool readMemOver;
        RISCV::RegId fi,fj,fk;
        RISCV::FunctionalUnit qj,qk;
        bool rj,rk;
    };
    struct InstrucyionStatus
    {
        uint64_t pc;
        RISCV::RegId rs1,rs2,dest;
        int64_t op1,op2,offset,out;
        RISCV::Inst inst;
        FunctionalUnit unit;
        bool writeReg,writeMem,readMem,readSignExt;
        uint32_t memLen;
        instCompleteSchedule instSchedule;
    };
    vector<InstrucyionStatus>instStatus;
    UnitStatus unit[5];
    RISCV::FunctionalUnit registerStatus[32];
    Scoreboard();
    //Check whether the functional unit is occupied
    bool isFuncUnitFree(RISCV::Inst inst);
    //Check if Result Reg is blank
    bool isDestBlank(RISCV::RegId regi);
    //Check if source register is ready
    bool isSrcRegReady(RISCV::FunctionalUnit funit);
    //Check whether the previous instruction needs to read the destination register
    bool isDestRead(RISCV::RegId regi);
    void updateFetchInstStatus(uint64_t pc);
    void updateIssueInstStatus(uint64_t pc);
    void updateReadInstStatus(uint64_t pc);
    void updateExecuteInstStatus(uint64_t pc);
    void updateWritebackInstStatus(uint64_t pc);
    //Issue stage update scoreboard
    FunctionalUnit updateIssueFuncStatus(RISCV::Inst inst,RISCV::RegId regi,RISCV::RegId regj,RISCV::RegId regk);
    //Read stage update scoreboard
    void updateReadFuncStatus(RISCV::FunctionalUnit funit);
    //Write bcak stage update scoreboard
    void updateWriteBackFuncStatus(RISCV::FunctionalUnit funit,RISCV::RegId regi);
    void freeFuncUnit(RISCV::FunctionalUnit funit);

};
#endif