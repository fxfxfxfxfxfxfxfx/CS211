#include "Scoreboard.h"
#include <cstring>
#include <fstream>
#include <sstream>
#include <string>

Scoreboard::Scoreboard()
{
    this->pause=false;
    this->unit[0].name=INTUNIT;
    this->unit[1].name=ALUUNIT;
    this->unit[2].name=MUL1UNIT;
    this->unit[3].name=MUL2UNIT;
    this->unit[4].name=DIVUNIT;
    for(int i=0;i<5;i++){
        this->unit[i].busy=false;
        this->unit[i].remainingPeriod=0;
        this->unit[i].readMemOver=false;
        this->unit[i].fi=-1;
        this->unit[i].fj=-1;
        this->unit[i].fk=-1;
        this->unit[i].qj=NOTOCCUPIED;
        this->unit[i].qk=NOTOCCUPIED;
        this->unit[i].rj=false;
        this->unit[i].rk=false;
    }
    for(int i=0;i<32;i++)
        this->registerStatus[i]=NOTOCCUPIED;
}
//判断当前指令使用的功能单元是否空闲
bool Scoreboard::isFuncUnitFree(RISCV::Inst inst) {
    uint32_t funit=getComponentUsed(inst);
    switch(funit)
    {
        case ALU:
        case branchALU:
            return !this->unit[1].busy;
            break;
        case memCalc:
        case dataMem:
            return !this->unit[0].busy;
            break;
        case MUL:
            return !this->unit[2].busy || !this->unit[3].busy;
            break;
        case DIV:
            return !this->unit[4].busy;
            break;
        default:
            return true;
            break;
    }
    
}
//判断指令要写入的寄存器是否被占用
bool Scoreboard::isDestBlank(RISCV::RegId regi){
    if(regi==-1||regi==0)
        return true;
    return this->registerStatus[regi]==NOTOCCUPIED;
}
//判断所需的源寄存器是否准备好
bool Scoreboard::isSrcRegReady(RISCV::FunctionalUnit funit){
    if(this->unit[funit].fj!=-1&&!this->unit[funit].rj)
        return false;
    if(this->unit[funit].fk!=-1&&!this->unit[funit].rk)
        return false;
    return true;
}
//判断当前是否有指令正在使用要被写回的寄存器
bool Scoreboard::isDestRead(RISCV::RegId regi){
    for(int i=0;i<5;i++){
        if(this->unit[i].fj==regi&&this->unit[i].rj)
            return false;
        if(this->unit[i].fk==regi&&this->unit[i].rk)
            return false;
    }
    return true;
}

//在取指后更新计分牌
void Scoreboard::updateFetchInstStatus(uint64_t pc){
    InstrucyionStatus tem;
    tem.pc=pc;
    tem.instSchedule=fetchedPeriod;
    tem.inst=UNKNOWN;
    this->instStatus.push_back(tem);
}
void Scoreboard::updateIssueInstStatus(uint64_t pc){
    for(int i=0;i<this->instStatus.size();i++){
        if(this->instStatus[i].pc==pc)
            this->instStatus[i].instSchedule=issuedPeriod;
    }
}
void Scoreboard::updateReadInstStatus(uint64_t pc){
    for(int i=0;i<this->instStatus.size();i++){
        if(this->instStatus[i].pc==pc)
            this->instStatus[i].instSchedule=readedPeriod;
    }
}
void Scoreboard::updateExecuteInstStatus(uint64_t pc){
    for(int i=0;i<this->instStatus.size();i++){
        if(this->instStatus[i].pc==pc)
            this->instStatus[i].instSchedule=executePeriod;
    }
}
void Scoreboard::updateWritebackInstStatus(uint64_t pc){

    for(int i=0;i<this->instStatus.size();i++){
        if(this->instStatus[i].pc==pc){
            this->instStatus[i].instSchedule=writebackedPeriod;
            this->instStatus.erase(this->instStatus.begin()+i);
        }
    }
}
//在指令发射后更新计分牌
FunctionalUnit Scoreboard::updateIssueFuncStatus(RISCV::Inst inst,RISCV::RegId regi,RISCV::RegId regj,RISCV::RegId regk){
    uint32_t com=getComponentUsed(inst);
    FunctionalUnit funit;
    switch(com)
    {
        case ALU:
        case branchALU:
            funit=ALUUNIT;
            this->unit[funit].remainingPeriod=1;
            break;
        case memCalc:
            funit=INTUNIT;
            this->unit[funit].remainingPeriod=2;
            break;
        case dataMem:
            funit=INTUNIT;
            this->unit[funit].remainingPeriod=666666;
            break;
        case MUL:
            if(this->unit[2].remainingPeriod==0){
                funit=MUL1UNIT;
                this->unit[funit].remainingPeriod=3;
                break;
            }
            if(this->unit[3].remainingPeriod==0){
                funit=MUL2UNIT;
                this->unit[funit].remainingPeriod=3;
                break;
            }
        case DIV:
            funit=DIVUNIT;
            this->unit[funit].remainingPeriod=7;
            break;
        default:
            funit=NOTOCCUPIED;
            break;
    }
    this->unit[funit].busy=true;
    this->unit[funit].fi=regi;
    this->unit[funit].fj=regj;
    this->unit[funit].fk=regk;
    
    if(regj==-1){
        this->unit[funit].qj=NOTOCCUPIED;
        this->unit[funit].rj=true;
    }
    else{
        this->unit[funit].qj=registerStatus[regj];
        this->unit[funit].rj=(registerStatus[regj]==NOTOCCUPIED);
    }
    if(regk==-1){
        this->unit[funit].qk=NOTOCCUPIED;
        this->unit[funit].rk=true;
    }
    else{
        this->unit[funit].qk=registerStatus[regk];
        this->unit[funit].rk=(registerStatus[regk]==NOTOCCUPIED);
    }
    if(regi==-1)
        return funit;
    this->registerStatus[regi]=funit;
    return funit;
}
//在读到寄存器后更新计分牌
void Scoreboard::updateReadFuncStatus(RISCV::FunctionalUnit funit){
    this->unit[funit].rj=false;
    this->unit[funit].rk=false;
    this->unit[funit].qj=NOTOCCUPIED;
    this->unit[funit].qk=NOTOCCUPIED;
}
//释放功能单元
void Scoreboard::freeFuncUnit(RISCV::FunctionalUnit funit){
    this->unit[funit].remainingPeriod=0;
    this->unit[funit].readMemOver=false;
    this->unit[funit].busy=false;
    this->unit[funit].fi=-1;
    this->unit[funit].fj=-1;
    this->unit[funit].fk=-1;
    this->unit[funit].qj=NOTOCCUPIED;
    this->unit[funit].qk=NOTOCCUPIED;
    this->unit[funit].rj=false;
    this->unit[funit].rk=false;
}
//在写会后更新计分牌
void Scoreboard::updateWriteBackFuncStatus(RISCV::FunctionalUnit funit,RISCV::RegId regi){
    for(int i=0;i<5;i++){
        if(this->unit[i].fj==regi&&!this->unit[i].rj)
            this->unit[i].rj=true;
        if(this->unit[i].fk==regi&&!this->unit[i].rk)
            this->unit[i].rk=true;
        this->registerStatus[regi]=NOTOCCUPIED;
        this->freeFuncUnit(funit);
    }
}