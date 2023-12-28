#include "Tomasulo.h"
#include <cstring>
#include <fstream>
#include <sstream>
#include <string>
#include <stdio.h>
tomasulo::tomasulo(){
    struct registerStatusEntry tem;
    tem.entry=0;
    tem.busy=false;
    for(int i=0;i<REGNUM;i++)
        this->registerStatus.push_back(tem);
}

bool tomasulo::isReorderBufferFree(){
    return this->reorderBuffer.size()<REORDERBUFFERSIZE;
}

bool tomasulo::isReservationStationFree(FunctionalUnit fu){
    switch (fu)
    {
    case MEMUNIT:
        return this->memReservationStation.size()<MEMRESERVATIONSTATIONSIZE;
        break;
    case ALUUNIT:
        return this->aluReservationStation.size()<ALURESERVATIONSTATIONSIZE;
        break;
    case MULUNIT:
        return this->mulReservationStation.size()<MULRESERVATIONSTATIONSIZE;
        break;
    case DIVUNIT:
        return this->divReservationStation.size()<DIVRESERVATIONSTATIONSIZE;
        break;
    default:
        printf("Unknow functional unit code %d!\n",fu);
        break;
    }
    return false;
}

bool tomasulo::isOperationJReady(uint32_t entry,FunctionalUnit fu){
    switch (fu)
    {
    case MEMUNIT:
        for(int i=0;i<this->memReservationStation.size();i++){
            if(this->memReservationStation[i].entry==entry){
                return this->memReservationStation[i].qj==0;
            }
        }
        printf("Unknow entry code %d in memory reservation station!",entry);
        break;
    case ALUUNIT:
        for(int i=0;i<this->aluReservationStation.size();i++){
            if(this->aluReservationStation[i].entry==entry){
                return this->aluReservationStation[i].qj==0;
            }
        }
        printf("Unknow entry code %d in alu reservation station!",entry);
        break;
    case MULUNIT:
        for(int i=0;i<this->mulReservationStation.size();i++){
            if(this->mulReservationStation[i].entry==entry){
                return this->mulReservationStation[i].qj==0;
            }
        }
        printf("Unknow entry code %d in mul reservation station!",entry);
        break;
    case DIVUNIT:
        for(int i=0;i<this->divReservationStation.size();i++){
            if(this->divReservationStation[i].entry==entry){
                return this->divReservationStation[i].qj==0;
            }
        }
        printf("Unknow entry code %d in div reservation station!",entry);
        break;
    default:
        printf("Unknow functional unit code %d!\n",fu);
        break;
    }
    return false;
}

bool tomasulo::isOperationKReady(uint32_t entry,FunctionalUnit fu){
    switch (fu)
    {
    case MEMUNIT:
        for(int i=0;i<this->memReservationStation.size();i++){
            if(this->memReservationStation[i].entry==entry){
                return this->memReservationStation[i].qk==0;
            }
        }
        printf("Unknow entry code %d in memory reservation station!",entry);
        break;
    case ALUUNIT:
        for(int i=0;i<this->aluReservationStation.size();i++){
            if(this->aluReservationStation[i].entry==entry){
                return this->aluReservationStation[i].qk==0;
            }
        }
        printf("Unknow entry code %d in alu reservation station!",entry);
        break;
    case MULUNIT:
        for(int i=0;i<this->mulReservationStation.size();i++){
            if(this->mulReservationStation[i].entry==entry){
                return this->mulReservationStation[i].qk==0;
            }
        }
        printf("Unknow entry code %d in mul reservation station!",entry);
        break;
    case DIVUNIT:
        for(int i=0;i<this->divReservationStation.size();i++){
            if(this->divReservationStation[i].entry==entry){
                return this->divReservationStation[i].qk==0;
            }
        }
        printf("Unknow entry code %d in div reservation station!",entry);
        break;
    default:
        printf("Unknow functional unit code %d!\n",fu);
        break;
    }
    return false;
}
// 在memory保留站中有没有更早的储存指令
bool tomasulo::isNotStoreBeforeLoadInRS(uint32_t entry){
    bool ret=true;
    for(int i=0;i<this->memReservationStation.size();i++){
        if(getInstType(this->memReservationStation[i].instruction)==S_TYPE)
            ret=false;
        if(this->memReservationStation[i].entry==entry)
            break;
    }
    return ret;
}

bool tomasulo::isStoreLoadSameAddress(uint32_t entry){
    uint64_t address;
    for(int i=0;i<this->memReservationStation.size();i++){
        if(this->memReservationStation[i].entry==entry)
            address=this->memReservationStation[i].address+this->memReservationStation[i].vj;
    }
    bool ret=false;
    for(int i=0;i<this->reorderBuffer.size();i++){
        if(getInstType(this->reorderBuffer[i].instruction)==S_TYPE&&this->reorderBuffer[i].address==address)
            ret=true;
        if(this->reorderBuffer[i].entry==entry)
            break;
    }
    return ret;
}

bool tomasulo::isStoreFinish(uint32_t entry){
    return this->memReservationStation[0].entry==entry;
}

uint32_t tomasulo::getReorderbufferEntry(){
    vector<bool> entryPool(REORDERBUFFERSIZE);
    for(int i=0;i<this->reorderBuffer.size();i++){
        entryPool[this->reorderBuffer[i].entry-1]=1;
    }
    for(uint32_t i=0;i<entryPool.size();i++){
        if(!entryPool[i])
            return i+1;
    }
    return 0;
}

uint32_t tomasulo::newROBentry(Inst inst){
    struct reorderBufferEntry tem;
    tem.entry=this->getReorderbufferEntry();
    tem.instruction=inst;
    tem.ready=false;
    tem.busy=false;
    tem.period=dispatchedPeriod;
    tem.executeCycle=latency[getComponentUsed(inst)];
    this->reorderBuffer.push_back(tem);
    return tem.entry;
}

void tomasulo::newRSentry(Inst inst,uint32_t entry){
    struct reservationStationEntry tem;
    tem.entry=entry;
    tem.instruction=inst;
    FunctionalUnit fu=getFunctionalUnit(inst);
    switch (fu)
    {
    case ALUUNIT:
        this->aluReservationStation.push_back(tem);
        break;
    case MEMUNIT:
        this->memReservationStation.push_back(tem);
        break;
    case MULUNIT:
        this->mulReservationStation.push_back(tem);
        break;
    case DIVUNIT:
        this->divReservationStation.push_back(tem);
        break;
    default:
        break;
    }
}
void tomasulo::setRegj(FunctionalUnit fu,uint32_t entry,uint64_t vj,uint32_t qj){
    switch (fu)
    {
    case ALUUNIT:
        for(int i=0;i<this->aluReservationStation.size();i++){
            if(this->aluReservationStation[i].entry==entry){
                this->aluReservationStation[i].qj=qj;
                this->aluReservationStation[i].vj=vj;
            }
        }
        break;
    case MEMUNIT:
        for(int i=0;i<this->memReservationStation.size();i++){
            if(this->memReservationStation[i].entry==entry){
                this->memReservationStation[i].qj=qj;
                this->memReservationStation[i].vj=vj;
            }
        }
        break;
    case MULUNIT:
        for(int i=0;i<this->mulReservationStation.size();i++){
            if(this->mulReservationStation[i].entry==entry){
                this->mulReservationStation[i].qj=qj;
                this->mulReservationStation[i].vj=vj;
            }
        }
        break;
    case DIVUNIT:
        for(int i=0;i<this->divReservationStation.size();i++){
            if(this->divReservationStation[i].entry==entry){
                this->divReservationStation[i].qj=qj;
                this->divReservationStation[i].vj=vj;
            }
        }
        break;
    default:
        break;
    }
}

void tomasulo::setRegk(FunctionalUnit fu,uint32_t entry,uint64_t vk,uint32_t qk){
    switch (fu)
    {
    case ALUUNIT:
        for(int i=0;i<this->aluReservationStation.size();i++){
            if(this->aluReservationStation[i].entry==entry){
                this->aluReservationStation[i].qk=qk;
                this->aluReservationStation[i].vk=vk;
            }
        }
        break;
    case MEMUNIT:
        for(int i=0;i<this->memReservationStation.size();i++){
            if(this->memReservationStation[i].entry==entry){
                this->memReservationStation[i].qk=qk;
                this->memReservationStation[i].vk=vk;
            }
        }
        break;
    case MULUNIT:
        for(int i=0;i<this->mulReservationStation.size();i++){
            if(this->mulReservationStation[i].entry==entry){
                this->mulReservationStation[i].qk=qk;
                this->mulReservationStation[i].vk=vk;
            }
        }
        break;
    case DIVUNIT:
        for(int i=0;i<this->divReservationStation.size();i++){
            if(this->divReservationStation[i].entry==entry){
                this->divReservationStation[i].qk=qk;
                this->divReservationStation[i].vk=vk;
            }
        }
        break;
    default:
        break;
    }
    
}

void tomasulo::setRegd(FunctionalUnit fu,uint32_t entry,RegId rd){
        switch (fu)
    {
    case ALUUNIT:
        for(int i=0;i<this->aluReservationStation.size();i++){
            if(this->aluReservationStation[i].entry==entry){
                this->aluReservationStation[i].destination=rd;
            }
        }
        break;
    case MEMUNIT:
        for(int i=0;i<this->memReservationStation.size();i++){
            if(this->memReservationStation[i].entry==entry){
                this->memReservationStation[i].destination=rd;
            }
        }
        break;
    case MULUNIT:
        for(int i=0;i<this->mulReservationStation.size();i++){
            if(this->mulReservationStation[i].entry==entry){
                this->mulReservationStation[i].destination=rd;
            }
        }
        break;
    case DIVUNIT:
        for(int i=0;i<this->divReservationStation.size();i++){
            if(this->divReservationStation[i].entry==entry){
                this->divReservationStation[i].destination=rd;
            }
        }
        break;
    default:
        break;
    }
    for(int i=0;i<this->reorderBuffer.size();i++){
        if(this->reorderBuffer[i].entry==entry){
            this->reorderBuffer[i].destination=rd;
        }
    }
    this->registerStatus[rd].busy=true;
    this->registerStatus[rd].entry=entry;
}

void tomasulo::setOffset(FunctionalUnit fu,uint32_t entry,int64_t offset){
        switch (fu)
    {
    case ALUUNIT:
        for(int i=0;i<this->aluReservationStation.size();i++){
            if(this->aluReservationStation[i].entry==entry){
                this->aluReservationStation[i].address=offset;
            }
        }
        break;
    case MEMUNIT:
        for(int i=0;i<this->memReservationStation.size();i++){
            if(this->memReservationStation[i].entry==entry){
                this->memReservationStation[i].address=offset;
            }
        }
        break;
    case MULUNIT:
        for(int i=0;i<this->mulReservationStation.size();i++){
            if(this->mulReservationStation[i].entry==entry){
                this->mulReservationStation[i].address=offset;
            }
        }
        break;
    case DIVUNIT:
        for(int i=0;i<this->divReservationStation.size();i++){
            if(this->divReservationStation[i].entry==entry){
                this->divReservationStation[i].address=offset;
            }
        }
        break;
    default:
        break;
    }
}

void tomasulo::setPC(FunctionalUnit fu,uint32_t entry,uint64_t pc){
    switch (fu)
    {
    case ALUUNIT:
        for(int i=0;i<this->aluReservationStation.size();i++){
            if(this->aluReservationStation[i].entry==entry){
                this->aluReservationStation[i].PC=pc;
            }
        }
        break;
    case MEMUNIT:
        for(int i=0;i<this->memReservationStation.size();i++){
            if(this->memReservationStation[i].entry==entry){
                this->memReservationStation[i].PC=pc;
            }
        }
        break;
    case MULUNIT:
        for(int i=0;i<this->mulReservationStation.size();i++){
            if(this->mulReservationStation[i].entry==entry){
                this->mulReservationStation[i].PC=pc;
            }
        }
        break;
    case DIVUNIT:
        for(int i=0;i<this->divReservationStation.size();i++){
            if(this->divReservationStation[i].entry==entry){
                this->divReservationStation[i].PC=pc;
            }
        }
        break;
    default:
        break;
    }
}

bool tomasulo::isExecuteFinish(uint32_t entry){
    for(int i=0;i<this->reorderBuffer.size();i++){
        if(this->reorderBuffer[i].entry==entry){
            return this->reorderBuffer[i].busy&&this->reorderBuffer[i].executeCycle==0;
        }
    }
}

void tomasulo::executeOneCycle(uint32_t entry){
    for(int i=0;i<this->reorderBuffer.size();i++){
        if(this->reorderBuffer[i].entry==entry&&this->reorderBuffer[i].executeCycle>0){
            this->reorderBuffer[i].executeCycle--;

        }
    }
}