#ifndef SCOREBOARD_H
#define SCOREBOARD_H


#include "RISCV.h"
#include <vector>
#include <cstdint>
#include <queue>
using namespace std;
using namespace RISCV;
const uint32_t REORDERBUFFERSIZE=32;
const uint32_t ALURESERVATIONSTATIONSIZE=4;
const uint32_t MULRESERVATIONSTATIONSIZE=4;
const uint32_t MEMRESERVATIONSTATIONSIZE=4;
const uint32_t DIVRESERVATIONSTATIONSIZE=4;

class tomasulo{
public:
    struct reorderBufferEntry
    {
        uint32_t entry;
        bool ready;
        instCompleteSchedule period;
        uint32_t executeCycle;
        uint32_t busy;
        // Op instructionOp;
        Inst instruction;
        RegId destination;
        uint64_t value;
        uint64_t address;
    };
    std::vector<reorderBufferEntry> reorderBuffer;
    
    struct registerStatusEntry
    {
        uint32_t entry;
        bool busy;
    };
    std::vector<registerStatusEntry> registerStatus;

    struct reservationStationEntry
    {
        uint64_t PC;
        uint32_t entry;
        Inst instruction;
        // bool busy;
        Op instructionOp;
        int64_t vj;
        int64_t vk;
        uint32_t qj;
        uint32_t qk;
        RegId destination;
        uint64_t address;
    };
    tomasulo();
    std::vector<reservationStationEntry> aluReservationStation;
    std::vector<reservationStationEntry> mulReservationStation;
    std::vector<reservationStationEntry> memReservationStation;
    std::vector<reservationStationEntry> divReservationStation;
    
    bool isReorderBufferFree();
    bool isReservationStationFree(FunctionalUnit fu);
    bool isOperationJReady(uint32_t entry,FunctionalUnit fu);
    bool isOperationKReady(uint32_t entry,FunctionalUnit fu);
    bool isNotStoreBeforeLoadInRS(uint32_t entry);
    bool isStoreLoadSameAddress(uint32_t entry);
    bool isStoreFinish(uint32_t entry);
    bool isExecuteFinish(uint32_t entry);
    
    
    uint32_t getReorderbufferEntry();
    uint32_t newROBentry(Inst inst);
    void executeOneCycle(uint32_t entry);
    void getLoadAddress(uint32_t entry);
    void newRSentry(Inst inst,uint32_t entry);
    void setRegj(FunctionalUnit fu,uint32_t entry,uint64_t vj,uint32_t qj);
    void setRegk(FunctionalUnit fu,uint32_t entry,uint64_t vk,uint32_t qk);
    void setRegd(FunctionalUnit fu,uint32_t entry,RegId rd);
    void setPC(FunctionalUnit fu,uint32_t entry,uint64_t pc);
    void setOffset(FunctionalUnit fu,uint32_t entry,int64_t offset);
};


#endif