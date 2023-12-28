/*
 * Created by He, Hao at 2019-3-11
 */

#include <cstring>
#include <fstream>
#include <sstream>
#include <string>

#include "Debug.h"
#include "Simulator.h"


Simulator::Simulator(MemoryManager *memory, BranchPredictor *predictor) {
  this->memory = memory;
  this->branchPredictor = predictor;
  this->pc = 0;
  for (int i = 0; i < REGNUM; ++i) {
    this->reg[i] = 0;
  }
}

Simulator::~Simulator() {}

void Simulator::initStack(uint32_t baseaddr, uint32_t maxSize) {
  this->reg[REG_SP] = baseaddr;
  this->stackBase = baseaddr;
  this->maximumStackSize = maxSize;
  for (uint32_t addr = baseaddr; addr > baseaddr - maxSize; addr--) {
    if (!this->memory->isPageExist(addr)) {
      this->memory->addPage(addr);
    }
    this->memory->setByte(addr, 0);
  }
}

void Simulator::simulate() {
  // Main Simulation Loop
  struct snopEntry{
    instCompleteSchedule period;
    FunctionalUnit fu;
    uint32_t entry;
  } temSnopEntry;
  vector<snopEntry> snop;
  while (true) {
    if (this->reg[0] != 0) {
      // Some instruction might set this register to zero
      this->reg[0] = 0;
      // this->panic("Register 0's value is not zero!\n");
    }

    if (this->reg[REG_SP] < this->stackBase - this->maximumStackSize) {
      this->panic("Stack Overflow!\n");
    }

    this->executeWriteBack = false;
    this->executeWBReg = -1;
    this->memoryWriteBack = false;
    this->memoryWBReg = -1;
    
    
    //suanshu
    for(int i=0;i<this->ts.aluReservationStation.size();i++){
      if(this->ts.isOperationJReady(this->ts.aluReservationStation[i].entry,ALUUNIT)&&
      this->ts.isOperationKReady(this->ts.aluReservationStation[i].entry,ALUUNIT)){
        temSnopEntry.fu=ALUUNIT;
        temSnopEntry.entry=this->ts.aluReservationStation[i].entry;
        temSnopEntry.period=issuedPeriod;
        snop.push_back(temSnopEntry);
        break;
      }
    }
    for(int i=0;i<this->ts.mulReservationStation.size();i++){
      if(this->ts.isOperationJReady(this->ts.mulReservationStation[i].entry,MULUNIT)&&
      this->ts.isOperationKReady(this->ts.mulReservationStation[i].entry,MULUNIT)){
        temSnopEntry.fu=MULUNIT;
        temSnopEntry.entry=this->ts.mulReservationStation[i].entry;
        temSnopEntry.period=issuedPeriod;
        snop.push_back(temSnopEntry);
        break;
      }
    }
    for(int i=0;i<this->ts.divReservationStation.size();i++){
      if(this->ts.isOperationJReady(this->ts.divReservationStation[i].entry,DIVUNIT)&&
      this->ts.isOperationKReady(this->ts.divReservationStation[i].entry,DIVUNIT)){
        temSnopEntry.fu=DIVUNIT;
        temSnopEntry.entry=this->ts.divReservationStation[i].entry;
        temSnopEntry.period=issuedPeriod;
        snop.push_back(temSnopEntry);
        break;
      }
    }

    //store
    for(int i=0;i<this->ts.memReservationStation.size();i++){
      if(!isStoreMem(this->ts.memReservationStation[i].instruction))
        break;
      if(this->ts.isOperationJReady(this->ts.memReservationStation[i].entry,MEMUNIT)&&
      this->ts.isOperationKReady(this->ts.memReservationStation[i].entry,MEMUNIT)){
        temSnopEntry.fu=MEMUNIT;
        temSnopEntry.entry=this->ts.memReservationStation[i].entry;
        temSnopEntry.period=issuedPeriod;
        snop.push_back(temSnopEntry);
      }
      else{
        break;
      }
    }
    // remain execute
    for(int i=0;i<this->ts.reorderBuffer.size();i++){
      if(this->ts.reorderBuffer[i].executeCycle>0&&this->ts.reorderBuffer[i].busy){
        temSnopEntry.fu=MEMUNIT;
        temSnopEntry.entry=this->ts.reorderBuffer[i].entry;
        temSnopEntry.period=executePeriod;
        snop.push_back(temSnopEntry);
      }
    }
    //load
    for(int i=0;i<this->ts.memReservationStation.size();i++){
      if(isStoreMem(this->ts.memReservationStation[i].instruction))
        continue;
      if(this->ts.isOperationJReady(this->ts.memReservationStation[i].entry,MEMUNIT)&&
      this->ts.isNotStoreBeforeLoadInRS(this->ts.memReservationStation[i].entry)&&
      this->ts.isStoreLoadSameAddress(this->ts.memReservationStation[i].entry)){
        this->history.memoryHazardCount++;
      }
      if(this->ts.isOperationJReady(this->ts.memReservationStation[i].entry,MEMUNIT)&&
      this->ts.isNotStoreBeforeLoadInRS(this->ts.memReservationStation[i].entry)&&
      !this->ts.isStoreLoadSameAddress(this->ts.memReservationStation[i].entry)){
        temSnopEntry.fu=MEMUNIT;
        temSnopEntry.entry=this->ts.memReservationStation[i].entry;
        temSnopEntry.period=issuedPeriod;
        snop.push_back(temSnopEntry);
        break;
      }
    }

    for(int i=0;i<this->ts.reorderBuffer.size();i++){
      if(this->ts.reorderBuffer[i].executeCycle==0){
        temSnopEntry.fu=MEMUNIT;
        temSnopEntry.entry=this->ts.reorderBuffer[i].entry;
        temSnopEntry.period=executePeriod;
        snop.push_back(temSnopEntry);
      }
    }
    
  //todo commit
    for(int i=0;i<this->ts.reorderBuffer.size();i++){
      if(this->ts.reorderBuffer[i].ready){

        temSnopEntry.fu=MEMUNIT;
        temSnopEntry.entry=this->ts.reorderBuffer[i].entry;
        temSnopEntry.period=writebackedPeriod;
        snop.push_back(temSnopEntry);
      }
      else{
        break;
      }
    }
    int flag=1;
    if(!this->ts.aluReservationStation.empty()){
      for(int i=0;i<snop.size();i++){
        if(snop[i].fu==ALUUNIT&&(snop[i].period==issuedPeriod||snop[i].period==executePeriod))
          flag=0;
      }
    }
    this->history.dataHazardCount+=flag;
    flag=1;
    if(!this->ts.memReservationStation.empty()){
      for(int i=0;i<snop.size();i++){
        if(snop[i].fu==MEMUNIT&&(snop[i].period==issuedPeriod||snop[i].period==executePeriod))
          flag=0;
      }
    }
    this->history.dataHazardCount+=flag;
    flag=1;
    if(!this->ts.mulReservationStation.empty()){
      for(int i=0;i<snop.size();i++){
        if(snop[i].fu==MULUNIT&&(snop[i].period==issuedPeriod||snop[i].period==executePeriod))
          flag=0;
      }
    }
    this->history.dataHazardCount+=flag;
    flag=1;
    if(!this->ts.divReservationStation.empty()){
      for(int i=0;i<snop.size();i++){
        if(snop[i].fu==DIVUNIT&&(snop[i].period==issuedPeriod||snop[i].period==executePeriod))
          flag=0;
      }
    }
    this->history.dataHazardCount+=flag;
    flag=1;
    if(!this->fetchPasue){
      this->issue();
    }

    for(int i=0;i<snop.size();i++){
      if(snop[i].period==issuedPeriod){
        this->excecute(snop[i].fu,snop[i].entry);

      }
      else if(snop[i].period==executePeriod){
        if(this->ts.isExecuteFinish(snop[i].entry)){
          this->writeBack(snop[i].entry);
        }
        else{
          this->ts.executeOneCycle(snop[i].entry);
        }
      }
      else if(snop[i].period==writebackedPeriod){
        this->commit(snop[i].entry);
      }
    }
    
    snop.clear();


    if(this->fetchPasue)
      this->history.controlHazardCount++;
    this->history.cycleCount++;
    this->history.regRecord.push_back(this->getRegInfoStr());
    if (this->history.regRecord.size() >= 100000) { // Avoid using up memory
      this->history.regRecord.clear();
      this->history.instRecord.clear();
    }

    if (verbose) {
      this->printInfo();
    }

    if (this->isSingleStep) {
      printf("Type d to dump memory in dump.txt, press ENTER to continue: ");
      char ch;
      while ((ch = getchar()) != '\n') {
        if (ch == 'd') {
          this->dumpHistory();
        }
      }
    }
  }
}



void Simulator::issue() {
  if (this->pc % 2 != 0) {
    this->panic("Illegal PC 0x%x!\n", this->pc);
  }
  uint32_t inst = this->memory->getInt(this->pc);
  if(inst==0)
    exit(0);
  uint32_t len = 4;

  if (this->verbose) {
    printf("Fetched instruction 0x%.8x at address 0x%lx\n", inst, this->pc);
  }
  


  std::string instname = "";
  std::string inststr = "";
  std::string deststr, op1str, op2str, offsetstr;
  Inst insttype = Inst::UNKNOWN;
  int64_t op1 = 0, op2 = 0, offset = 0; // op1, op2 and offset are values
  RegId dest = 0, reg1 = -1, reg2 = -1; // reg1 and reg2 are operands

  // Reg for 32bit instructions
  if (len == 4) // 32 bit instruction
  {
    uint32_t opcode = inst & 0x7F;
    uint32_t funct3 = (inst >> 12) & 0x7;
    uint32_t funct7 = (inst >> 25) & 0x7F;
    RegId rd = (inst >> 7) & 0x1F;
    RegId rs1 = (inst >> 15) & 0x1F;
    RegId rs2 = (inst >> 20) & 0x1F;
    int32_t imm_i = int32_t(inst) >> 20;
    int32_t imm_s =
        int32_t(((inst >> 7) & 0x1F) | ((inst >> 20) & 0xFE0)) << 20 >> 20;
    int32_t imm_sb = int32_t(((inst >> 7) & 0x1E) | ((inst >> 20) & 0x7E0) |
                             ((inst << 4) & 0x800) | ((inst >> 19) & 0x1000))
                         << 19 >>
                     19;
    int32_t imm_u = int32_t(inst) >> 12;
    int32_t imm_uj = int32_t(((inst >> 21) & 0x3FF) | ((inst >> 10) & 0x400) |
                             ((inst >> 1) & 0x7F800) | ((inst >> 12) & 0x80000))
                         << 12 >>
                     11;

    switch (opcode) {
    case OP_REG:
      reg1 = rs1;
      reg2 = rs2;
      dest = rd;
      switch (funct3) {
      case 0x0: // add, mul, sub
        if (funct7 == 0x00) {
          instname = "add";
          insttype = ADD;
        } else if (funct7 == 0x01) {
          instname = "mul";
          insttype = MUL;
        } else if (funct7 == 0x20) {
          instname = "sub";
          insttype = SUB;
        } else {
          this->panic("Unknown funct7 0x%x for funct3 0x%x\n", funct7, funct3);
        }
        break;
      case 0x1: // sll, mulh
        if (funct7 == 0x00) {
          instname = "sll";
          insttype = SLL;
        } else if (funct7 == 0x01) {
          instname = "mulh";
          insttype = MULH;
        } else {
          this->panic("Unknown funct7 0x%x for funct3 0x%x\n", funct7, funct3);
        }
        break;
      case 0x2: // slt
        if (funct7 == 0x00) {
          instname = "slt";
          insttype = SLT;
        } else {
          this->panic("Unknown funct7 0x%x for funct3 0x%x\n", funct7, funct3);
        }
        break;
      case 0x3: // sltu
        if (funct7 == 0x00)
        {
          instname = "sltu";
          insttype = SLTU;
        }
        else
        {
          this->panic("Unknown funct7 0x%x for funct3 0x%x\n", funct7, funct3);
        }
        break;
      case 0x4: // xor div
        if (funct7 == 0x00) {
          instname = "xor";
          insttype = XOR;
        } else if (funct7 == 0x01) {
          instname = "div";
          insttype = DIV;
        } else {
          this->panic("Unknown funct7 0x%x for funct3 0x%x\n", funct7, funct3);
        }
        break;
      case 0x5: // srl, sra
        if (funct7 == 0x00) {
          instname = "srl";
          insttype = SRL;
        } else if (funct7 == 0x20) {
          instname = "sra";
          insttype = SRA;
        } else {
          this->panic("Unknown funct7 0x%x for funct3 0x%x\n", funct7, funct3);
        }
        break;
      case 0x6: // or, rem
        if (funct7 == 0x00) {
          instname = "or";
          insttype = OR;
        } else if (funct7 == 0x01) {
          instname = "rem";
          insttype = REM;
        } else {
          this->panic("Unknown funct7 0x%x for funct3 0x%x\n", funct7, funct3);
        }
        break;
      case 0x7: // and
        if (funct7 == 0x00) {
          instname = "and";
          insttype = AND;
        } else {
          this->panic("Unknown funct7 0x%x for funct3 0x%x\n", funct7, funct3);
        }
        break;
      default:
        this->panic("Unknown Funct3 field %x\n", funct3);
      }
      op1str = REGNAME[rs1];
      op2str = REGNAME[rs2];
      deststr = REGNAME[rd];
      inststr = instname + " " + deststr + "," + op1str + "," + op2str;
      break;
    case OP_IMM:
      reg1 = rs1;
      op2 = imm_i;
      dest = rd;
      switch (funct3) {
      case 0x0:
        instname = "addi";
        insttype = ADDI;
        break;
      case 0x2:
        instname = "slti";
        insttype = SLTI;
        break;
      case 0x3:
        instname = "sltiu";
        insttype = SLTIU;
        break;
      case 0x4:
        instname = "xori";
        insttype = XORI;
        break;
      case 0x6:
        instname = "ori";
        insttype = ORI;
        break;
      case 0x7:
        instname = "andi";
        insttype = ANDI;
        break;
      case 0x1:
        instname = "slli";
        insttype = SLLI;
        op2 = op2 & 0x3F;
        break;
      case 0x5:
        if (((inst >> 26) & 0x3F) == 0x0) {
          instname = "srli";
          insttype = SRLI;
          op2 = op2 & 0x3F;
        } else if (((inst >> 26) & 0x3F) == 0x10) {
          instname = "srai";
          insttype = SRAI;
          op2 = op2 & 0x3F;
        } else {
          this->panic("Unknown funct7 0x%x for OP_IMM\n", (inst >> 26) & 0x3F);
        }
        break;
      default:
        this->panic("Unknown Funct3 field %x\n", funct3);
      }
      op1str = REGNAME[rs1];
      op2str = std::to_string(op2);
      deststr = REGNAME[dest];
      inststr = instname + " " + deststr + "," + op1str + "," + op2str;
      break;
    case OP_LUI:
      op1 = imm_u;
      op2 = 0;
      offset = imm_u;
      dest = rd;
      instname = "lui";
      insttype = LUI;
      op1str = std::to_string(imm_u);
      deststr = REGNAME[dest];
      inststr = instname + " " + deststr + "," + op1str;
      break;
    case OP_AUIPC:
      op1 = imm_u;
      op2 = 0;
      offset = imm_u;
      dest = rd;
      instname = "auipc";
      insttype = AUIPC;
      op1str = std::to_string(imm_u);
      deststr = REGNAME[dest];
      inststr = instname + " " + deststr + "," + op1str;
      break;
    case OP_JAL:
      op1 = imm_uj;
      op2 = 0;
      offset = imm_uj;
      dest = rd;
      instname = "jal";
      insttype = JAL;
      op1str = std::to_string(imm_uj);
      deststr = REGNAME[dest];
      inststr = instname + " " + deststr + "," + op1str;
      break;
    case OP_JALR:
      reg1 = rs1;
      op2 = imm_i;
      dest = rd;
      instname = "jalr";
      insttype = JALR;
      op1str = REGNAME[rs1];
      op2str = std::to_string(op2);
      deststr = REGNAME[dest];
      inststr = instname + " " + deststr + "," + op1str + "," + op2str;
      break;
    case OP_BRANCH:
      reg1 = rs1;
      reg2 = rs2;
      offset = imm_sb;
      switch (funct3) {
      case 0x0:
        instname = "beq";
        insttype = BEQ;
        break;
      case 0x1:
        instname = "bne";
        insttype = BNE;
        break;
      case 0x4:
        instname = "blt";
        insttype = BLT;
        break;
      case 0x5:
        instname = "bge";
        insttype = BGE;
        break;
      case 0x6:
        instname = "bltu";
        insttype = BLTU;
        break;
      case 0x7:
        instname = "bgeu";
        insttype = BGEU;
        break;
      default:
        this->panic("Unknown funct3 0x%x at OP_BRANCH\n", funct3);
      }
      op1str = REGNAME[rs1];
      op2str = REGNAME[rs2];
      offsetstr = std::to_string(offset);
      inststr = instname + " " + op1str + "," + op2str + "," + offsetstr;
      break;
    case OP_STORE:
      reg1 = rs1;
      reg2 = rs2;
      offset = imm_s;
      switch (funct3) {
      case 0x0:
        instname = "sb";
        insttype = SB;
        break;
      case 0x1:
        instname = "sh";
        insttype = SH;
        break;
      case 0x2:
        instname = "sw";
        insttype = SW;
        break;
      case 0x3:
        instname = "sd";
        insttype = SD;
        break;
      default:
        this->panic("Unknown funct3 0x%x for OP_STORE\n", funct3);
      }
      op1str = REGNAME[rs1];
      op2str = REGNAME[rs2];
      offsetstr = std::to_string(offset);
      inststr = instname + " " + op2str + "," + offsetstr + "(" + op1str + ")";
      break;
    case OP_LOAD:
      reg1 = rs1;
      op2 = imm_i;
      offset = imm_i;
      dest = rd;
      switch (funct3) {
      case 0x0:
        instname = "lb";
        insttype = LB;
        break;
      case 0x1:
        instname = "lh";
        insttype = LH;
        break;
      case 0x2:
        instname = "lw";
        insttype = LW;
        break;
      case 0x3:
        instname = "ld";
        insttype = LD;
        break;
      case 0x4:
        instname = "lbu";
        insttype = LBU;
        break;
      case 0x5:
        instname = "lhu";
        insttype = LHU;
        break;
      case 0x6:
        instname = "lwu";
        insttype = LWU;
      default:
        this->panic("Unknown funct3 0x%x for OP_LOAD\n", funct3);
      }
      op1str = REGNAME[rs1];
      op2str = std::to_string(op2);
      deststr = REGNAME[rd];
      inststr = instname + " " + deststr + "," + op2str + "(" + op1str + ")";
      break;
    case OP_SYSTEM:
      if (funct3 == 0x0 && funct7 == 0x000) {
        instname = "ecall";
        reg1 = REG_A0;
        reg2 = REG_A7;
        dest = REG_A0;
        insttype = ECALL;
      } else {
        this->panic("Unknown OP_SYSTEM inst with funct3 0x%x and funct7 0x%x\n",
                    funct3, funct7);
      }
      inststr = instname;
      break;
    case OP_IMM32:
      reg1 = rs1;
      op2 = imm_i;
      dest = rd;
      switch (funct3) {
      case 0x0:
        instname = "addiw";
        insttype = ADDIW;
        break;
      case 0x1:
        instname = "slliw";
        insttype = SLLIW;
        break;
      case 0x5:
        if (((inst >> 25) & 0x7F) == 0x0) {
          instname = "srliw";
          insttype = SRLIW;
        } else if (((inst >> 25) & 0x7F) == 0x20) {
          instname = "sraiw";
          insttype = SRAIW;
        } else {
          this->panic("Unknown shift inst type 0x%x\n", ((inst >> 25) & 0x7F));
        }
        break;
      default:
        this->panic("Unknown funct3 0x%x for OP_ADDIW\n", funct3);
      }
      op1str = REGNAME[rs1];
      op2str = std::to_string(op2);
      deststr = REGNAME[rd];
      inststr = instname + " " + deststr + "," + op1str + "," + op2str;
      break;
    case OP_32: {
      reg1 = rs1;
      reg2 = rs2;
      dest = rd;
      uint32_t temp = (inst >> 25) & 0x7F; // 32bit funct7 field
      switch (funct3) {
      case 0x0:
        if (temp == 0x0) {
          instname = "addw";
          insttype = ADDW;
        } else if (temp == 0x20) {
          instname = "subw";
          insttype = SUBW;
        } else {
          this->panic("Unknown 32bit funct7 0x%x\n", temp);
        }
        break;
      case 0x1:
        if (temp == 0x0) {
          instname = "sllw";
          insttype = SLLW;
        } else {
          this->panic("Unknown 32bit funct7 0x%x\n", temp);
        }
        break;
      case 0x5:
        if (temp == 0x0) {
          instname = "srlw";
          insttype = SRLW;
        } else if (temp == 0x20) {
          instname = "sraw";
          insttype = SRAW;
        } else {
          this->panic("Unknown 32bit funct7 0x%x\n", temp);
        }
        break;
      default:
        this->panic("Unknown 32bit funct3 0x%x\n", funct3);
      }
    } break;
    default:
      this->panic("Unsupported opcode 0x%x!\n", opcode);
    }

    char buf[4096];
    sprintf(buf, "0x%lx: %s\n", this->pc, inststr.c_str());
    this->history.instRecord.push_back(buf);

    if (verbose) {
      printf("Decoded instruction 0x%.8x as %s\n", inst, inststr.c_str());
    }
  } else { // 16 bit instruction
    this->panic(
        "Current implementation does not support 16bit RV64C instructions!\n");
  }
  // to do
  // this->pc = this->pc + len;
  if (instname != INSTNAME[insttype]) {
    this->panic("Unmatch instname %s with insttype %d\n", instname.c_str(),
                insttype);
  }
  //tomasulo handle
  FunctionalUnit fu=getFunctionalUnit(insttype);
  if(!this->ts.isReorderBufferFree()||!this->ts.isReservationStationFree(fu))
    return;
  uint32_t entry=this->ts.newROBentry(insttype);
  this->ts.newRSentry(insttype,entry);
  uint32_t qj=0;
  uint32_t qk=0;
  uint32_t h;
  bool predictedBranch = false;
  if(isBranch(insttype)||isJump(insttype)){
    this->fetchPasue=true;
  }
  if(reg1!=-1){
    if(this->ts.registerStatus[reg1].busy){
      h=this->ts.registerStatus[reg1].entry;
      for(int i=0;i<this->ts.reorderBuffer.size();i++){
        if(this->ts.reorderBuffer[i].entry==h){
          if(this->ts.reorderBuffer[i].ready){
            op1=this->ts.reorderBuffer[i].value;
            qj=0;
          }
          else{
            qj=h;
          }
        }
      }
    }
    else{
      op1=this->reg[reg1];
      qj=0;
    }
  }

  if(reg2!=-1){
  if(this->ts.registerStatus[reg2].busy){
    h=this->ts.registerStatus[reg2].entry;
    for(int i=0;i<this->ts.reorderBuffer.size();i++){
      if(this->ts.reorderBuffer[i].entry==h){
        if(this->ts.reorderBuffer[i].ready){
          op2=this->ts.reorderBuffer[i].value;
          qk=0;
        }
        else{
          qk=h;
        }
      }
    }
  }
  else{
    op2=this->reg[reg2];
    qk=0;
    }
  }
  this->ts.setRegj(fu,entry,op1,qj);
  this->ts.setRegk(fu,entry,op2,qk);
  if(isWriteReg(insttype)){
    this->ts.setRegd(fu,entry,dest);
  }
  this->ts.setPC(fu,entry,this->pc);
  this->ts.setOffset(fu,entry,offset);

  this->pc = this->pc + len;

}

void Simulator::excecute(FunctionalUnit fu,uint32_t entry) {
  if (verbose) {
    printf("Execute: %d\n",entry);
  }

  Inst inst;
  int64_t op1 ;
  int64_t op2 ;
  int64_t offset ;
  bool predictedBranch;

  uint64_t dRegPC ;
  bool writeReg = false;
  RegId destReg ;
  switch (fu)
  {
  case ALUUNIT:
    for(int i=0;i<this->ts.aluReservationStation.size();i++){
      if(this->ts.aluReservationStation[i].entry==entry){
        inst=this->ts.aluReservationStation[i].instruction;
        op1=this->ts.aluReservationStation[i].vj;
        op2=this->ts.aluReservationStation[i].vk;
        offset=this->ts.aluReservationStation[i].address;
        destReg=this->ts.aluReservationStation[i].destination;
        dRegPC=this->ts.aluReservationStation[i].PC;
        this->ts.aluReservationStation.erase(this->ts.aluReservationStation.begin()+i);
      }
    }
    break;
  case MEMUNIT:
    for(int i=0;i<this->ts.memReservationStation.size();i++){
      if(this->ts.memReservationStation[i].entry==entry){
        inst=this->ts.memReservationStation[i].instruction;
        op1=this->ts.memReservationStation[i].vj;
        op2=this->ts.memReservationStation[i].vk;
        offset=this->ts.memReservationStation[i].address;
        destReg=this->ts.memReservationStation[i].destination;
        dRegPC=this->ts.memReservationStation[i].PC;
        this->ts.memReservationStation.erase(this->ts.memReservationStation.begin()+i);
      }
    }
    break;
  case MULUNIT:
    for(int i=0;i<this->ts.mulReservationStation.size();i++){
      if(this->ts.mulReservationStation[i].entry==entry){
        inst=this->ts.mulReservationStation[i].instruction;
        op1=this->ts.mulReservationStation[i].vj;
        op2=this->ts.mulReservationStation[i].vk;
        offset=this->ts.mulReservationStation[i].address;
        destReg=this->ts.mulReservationStation[i].destination;
        dRegPC=this->ts.mulReservationStation[i].PC;
        this->ts.mulReservationStation.erase(this->ts.mulReservationStation.begin()+i);
      }
    }
    break;
  case DIVUNIT:
    for(int i=0;i<this->ts.divReservationStation.size();i++){
      if(this->ts.divReservationStation[i].entry==entry){
        inst=this->ts.divReservationStation[i].instruction;
        op1=this->ts.divReservationStation[i].vj;
        op2=this->ts.divReservationStation[i].vk;
        offset=this->ts.divReservationStation[i].address;
        destReg=this->ts.divReservationStation[i].destination;
        dRegPC=this->ts.divReservationStation[i].PC;
        this->ts.divReservationStation.erase(this->ts.divReservationStation.begin()+i);
      }
    }
    break;
  default:
    break;
  }
  this->history.instCount++;
  int64_t out = 0;
  bool writeMem = false;
  bool readMem = false;
  bool readSignExt = false;
  uint32_t memLen = 0;
  bool branch = false;

  switch (inst) {
  case LUI:
    writeReg = true;
    out = offset << 12;
    break;
  case AUIPC:
    writeReg = true;
    out = dRegPC + (offset << 12);
    break;
  case JAL:
    writeReg = true;
    out = dRegPC + 4;
    dRegPC = dRegPC + op1;
    branch = true;
    break;
  case JALR:
    writeReg = true;
    out = dRegPC + 4;
    dRegPC = (op1 + op2) & (~(uint64_t)1);
    branch = true;
    break;
  case BEQ:
    if (op1 == op2) {
      branch = true;
      dRegPC = dRegPC + offset;
    }
    break;
  case BNE:
    if (op1 != op2) {
      branch = true;
      dRegPC = dRegPC + offset;
    }
    break;
  case BLT:
    if (op1 < op2) {
      branch = true;
      dRegPC = dRegPC + offset;
    }
    break;
  case BGE:
    if (op1 >= op2) {
      branch = true;
      dRegPC = dRegPC + offset;
    }
    break;
  case BLTU:
    if ((uint64_t)op1 < (uint64_t)op2) {
      branch = true;
      dRegPC = dRegPC + offset;
    }
    break;
  case BGEU:
    if ((uint64_t)op1 >= (uint64_t)op2) {
      branch = true;
      dRegPC = dRegPC + offset;
    }
    break;
  case LB:
    readMem = true;
    writeReg = true;
    memLen = 1;
    out = op1 + offset;
    readSignExt = true;
    break;
  case LH:
    readMem = true;
    writeReg = true;
    memLen = 2;
    out = op1 + offset;
    readSignExt = true;
    break;
  case LW:
    readMem = true;
    writeReg = true;
    memLen = 4;
    out = op1 + offset;
    readSignExt = true;
    break;
  case LD:
    readMem = true;
    writeReg = true;
    memLen = 8;
    out = op1 + offset;
    readSignExt = true;
    break;
  case LBU:
    readMem = true;
    writeReg = true;
    memLen = 1;
    out = op1 + offset;
    break;
  case LHU:
    readMem = true;
    writeReg = true;
    memLen = 2;
    out = op1 + offset;
    break;
  case LWU:
    readMem = true;
    writeReg = true;
    memLen = 4;
    out = op1 + offset;
    break;
  case SB:
    writeMem = true;
    memLen = 1;
    out = op1 + offset;
    op2 = op2 & 0xFF;
    break;
  case SH:
    writeMem = true;
    memLen = 2;
    out = op1 + offset;
    op2 = op2 & 0xFFFF;
    break;
  case SW:
    writeMem = true;
    memLen = 4;
    out = op1 + offset;
    op2 = op2 & 0xFFFFFFFF;
    break;
  case SD:
    writeMem = true;
    memLen = 8;
    out = op1 + offset;
    break;
  case ADDI:
  case ADD:
    writeReg = true;
    out = op1 + op2;
    break;
  case ADDIW:
  case ADDW:
    writeReg = true;
    out = (int64_t)((int32_t)op1 + (int32_t)op2);
    break;
  case SUB:
    writeReg = true;
    out = op1 - op2;
    break;
  case SUBW:
    writeReg = true;
    out = (int64_t)((int32_t)op1 - (int32_t)op2);
    break;
  case MUL:
    writeReg = true;
    out = op1 * op2;
    break;
  case DIV:
    writeReg = true;
    out = op1 / op2;
    break;
  case SLTI:
  case SLT:
    writeReg = true;
    out = op1 < op2 ? 1 : 0;
    break;
  case SLTIU:
  case SLTU:
    writeReg = true;
    out = (uint64_t)op1 < (uint64_t)op2 ? 1 : 0;
    break;
  case XORI:
  case XOR:
    writeReg = true;
    out = op1 ^ op2;
    break;
  case ORI:
  case OR:
    writeReg = true;
    out = op1 | op2;
    break;
  case ANDI:
  case AND:
    writeReg = true;
    out = op1 & op2;
    break;
  case SLLI:
  case SLL:
    writeReg = true;
    out = op1 << op2;
    break;
  case SLLIW:
  case SLLW:
    writeReg = true;
    out = int64_t(int32_t(op1 << op2));
    break;
    break;
  case SRLI:
  case SRL:
    writeReg = true;
    out = (uint64_t)op1 >> (uint64_t)op2;
    break;
  case SRLIW:
  case SRLW:
    writeReg = true;
    out = uint64_t(uint32_t((uint32_t)op1 >> (uint32_t)op2));
    break;
  case SRAI:
  case SRA:
    writeReg = true;
    out = op1 >> op2;
    break;
  case SRAW:
  case SRAIW:
    writeReg = true;
    out = int64_t(int32_t((int32_t)op1 >> (int32_t)op2));
    break;
  case ECALL:
    out = handleSystemCall(op1, op2);
    writeReg = true;
    break;
  default:
    this->panic("Unknown instruction type %u\n", inst);
  }
  


  bool good = true;
  uint32_t cycles = 0;
  int64_t tttt=out;
  if (readMem) {
    switch (memLen) {
    case 1:
      if (readSignExt) {
        out = (int64_t)this->memory->getByte(out, &cycles);
      } else {
        out = (uint64_t)this->memory->getByte(out, &cycles);
      }
      break;
    case 2:
      if (readSignExt) {
        out = (int64_t)this->memory->getShort(out, &cycles);
      } else {
        out = (uint64_t)this->memory->getShort(out, &cycles);
      }
      break;
    case 4:
      if (readSignExt) {
        out = (int64_t)this->memory->getInt(out, &cycles);
      } else {
        out = (uint64_t)this->memory->getInt(out, &cycles);
      }
      break;
    case 8:
      if (readSignExt) {
        out = (int64_t)this->memory->getLong(out, &cycles);
      } else {
        out = (uint64_t)this->memory->getLong(out, &cycles);
      }
      break;
    default:
      this->panic("Unknown memLen %d\n", memLen);
    }
    // printf("get address=%x  value=%d\n",tttt,out);
  }

  for(int i=0;i<this->ts.reorderBuffer.size();i++){
    if(this->ts.reorderBuffer[i].entry==entry){
      if(isStoreMem(inst)){
        this->ts.reorderBuffer[i].address=out;
        this->ts.reorderBuffer[i].period=writebackedPeriod;
        this->ts.reorderBuffer[i].ready=true;
        this->ts.reorderBuffer[i].busy=false;
        this->ts.reorderBuffer[i].value=op2;
      }
      else if(isBranch(inst)){
        if(branch)
          this->ts.reorderBuffer[i].address=dRegPC;
        else
          this->ts.reorderBuffer[i].address=this->pc;
        this->ts.reorderBuffer[i].period=writebackedPeriod;
        this->ts.reorderBuffer[i].ready=true;
        this->ts.reorderBuffer[i].busy=false;
        this->ts.reorderBuffer[i].value=out;
      }
      else if(isJump(inst)){
        this->ts.reorderBuffer[i].address=dRegPC;
        this->ts.reorderBuffer[i].period=writebackedPeriod;
        this->ts.reorderBuffer[i].ready=true;
        this->ts.reorderBuffer[i].busy=false;
        this->ts.reorderBuffer[i].value=out;
      }
      else if(isReadMem(inst)){
        this->ts.reorderBuffer[i].value=out;
        this->ts.reorderBuffer[i].period=executePeriod;
        this->ts.reorderBuffer[i].ready=false;
        this->ts.reorderBuffer[i].busy=true;
        this->ts.reorderBuffer[i].executeCycle=cycles;
      }
      else{
        this->ts.reorderBuffer[i].value=out;
        this->ts.reorderBuffer[i].period=executePeriod;
        this->ts.reorderBuffer[i].ready=false;
        this->ts.reorderBuffer[i].busy=true;
      } 
    }
  }

}
void Simulator::writeBack(uint32_t entry){
  if (verbose) {
    printf("Write back: %d\n",entry);
  }
  RegId dest;
  uint64_t value;
  for(int i=0;i<this->ts.reorderBuffer.size();i++){
    if(this->ts.reorderBuffer[i].entry==entry){
      dest=this->ts.reorderBuffer[i].destination;
      value=this->ts.reorderBuffer[i].value;
      this->ts.reorderBuffer[i].period=writebackedPeriod;
      this->ts.reorderBuffer[i].ready=true;
    }
  }
  for(int i=0;i<this->ts.aluReservationStation.size();i++){
    if(this->ts.aluReservationStation[i].qj==entry){
      this->ts.aluReservationStation[i].vj=value;
      this->ts.aluReservationStation[i].qj=0;
    }
    if(this->ts.aluReservationStation[i].qk==entry){
      this->ts.aluReservationStation[i].vk=value;
      this->ts.aluReservationStation[i].qk=0;
    }
  }
  for(int i=0;i<this->ts.memReservationStation.size();i++){
    if(this->ts.memReservationStation[i].qj==entry){
      this->ts.memReservationStation[i].vj=value;
      this->ts.memReservationStation[i].qj=0;
    }
    if(this->ts.memReservationStation[i].qk==entry){
      this->ts.memReservationStation[i].vk=value;
      this->ts.memReservationStation[i].qk=0;
    }
  }
  for(int i=0;i<this->ts.mulReservationStation.size();i++){
    if(this->ts.mulReservationStation[i].qj==entry){
      this->ts.mulReservationStation[i].vj=value;
      this->ts.mulReservationStation[i].qj=0;
    }
    if(this->ts.mulReservationStation[i].qk==entry){
      this->ts.mulReservationStation[i].vk=value;
      this->ts.mulReservationStation[i].qk=0;
    }
  }
  for(int i=0;i<this->ts.divReservationStation.size();i++){
    if(this->ts.divReservationStation[i].qj==entry){
      this->ts.divReservationStation[i].vj=value;
      this->ts.divReservationStation[i].qj=0;
    }
    if(this->ts.divReservationStation[i].qk==entry){
      this->ts.divReservationStation[i].vk=value;
      this->ts.divReservationStation[i].qk=0;
    }
  }
}
void Simulator::commit(uint32_t entry)
{
  if (verbose) {
    printf("Commit: %d\n",entry);
  }
  Inst inst;
  RegId dest;
  uint64_t op2;
  uint64_t out;
  uint32_t memLen;
  for(int i=0;i<this->ts.reorderBuffer.size();i++){
    if(this->ts.reorderBuffer[i].entry==entry){
      inst=this->ts.reorderBuffer[i].instruction;
      dest=this->ts.reorderBuffer[i].destination;
      op2=this->ts.reorderBuffer[i].address;
      out=this->ts.reorderBuffer[i].value;
      this->ts.reorderBuffer.erase(this->ts.reorderBuffer.begin()+i);
    }
  }
  if(isBranch(inst)||isJump(inst)){
    this->fetchPasue=false;
    this->pc=op2;
  }
  if(isStoreMem(inst)){
    switch (inst)
    {
    case SB:
      memLen = 1;
      break;
    case SH:
      memLen = 2;
      break;
    case SW:
      memLen = 4;
      break;
    case SD:
      memLen = 8;
      break;
    }
    bool good = true;
    uint32_t cycles = 0;
    // printf("set: address=%x value=%d\n",op2,out);
    switch (memLen) {
    case 1:
      good = this->memory->setByte(op2, out, &cycles);
      break;
    case 2:
      good = this->memory->setShort(op2, out, &cycles);
      break;
    case 4:
      good = this->memory->setInt(op2, out, &cycles);
      break;
    case 8:
      good = this->memory->setLong(op2, out, &cycles);
      break;
    default:
      this->panic("Unknown memLen %d\n", memLen);
    }
    if (!good) {
      this->panic("Invalid Mem Access!\n");
    }
  }
  else if(isWriteReg(inst)){
    // if(dest==REG_A0)
    //   printf("a0=%d\n",out);
    reg[dest]=out;
    if(this->ts.registerStatus[dest].entry==entry){
      this->ts.registerStatus[dest].busy=false;
    }
  }
}


int64_t Simulator::handleSystemCall(int64_t op1, int64_t op2) {
  int64_t type = op2; // reg a7
  int64_t arg1 = op1; // reg a0
  switch (type) {
  case 0: { // print string
    uint32_t addr = arg1;
    char ch = this->memory->getByte(addr);
    while (ch != '\0') {
      printf("%c", ch);
      ch = this->memory->getByte(++addr);
    }
    break;
  }
  case 1: // print char
    printf("%c", (char)arg1);
    break;
  case 2: // print num
    printf("%d", (int32_t)arg1);
    break;
  case 3:
  case 93: // exit
    printf("Program exit from an exit() system call\n");
    if (shouldDumpHistory) {
      printf("Dumping history to dump.txt...");
      this->dumpHistory();
    }
    this->printStatistics();
    exit(0);
  case 4: // read char
    scanf(" %c", (char*)&op1);
    break;
  case 5: // read num
    scanf(" %ld", &op1);
    break;
  case 6: // print float
    printf("%f", (float)arg1);
    break;
  default:
    this->panic("Unknown syscall type %d\n", type);
  }
  return op1;
}

void Simulator::printInfo() {
  printf("------------ CPU STATE ------------\n");
  printf("PC: 0x%lx\n", this->pc);
  for (uint32_t i = 0; i < 32; ++i) {
    printf("%s: 0x%.8lx(%ld) ", REGNAME[i], this->reg[i], this->reg[i]);
    if (i % 4 == 3)
      printf("\n");
  }
  printf("-----------------------------------\n");
  printf("------------ ROB STATE ------------\n");
  for(int i=0;i<this->ts.reorderBuffer.size();i++){
    printf("%d: entry=%d,inst=%s,ready=%d,period=%d,busy=%d,execycle=%d,dest=%d,value=%d,address=%x\n",
    i,this->ts.reorderBuffer[i].entry,INSTNAME[this->ts.reorderBuffer[i].instruction],
    this->ts.reorderBuffer[i].ready,this->ts.reorderBuffer[i].period,this->ts.reorderBuffer[i].busy, this->ts.reorderBuffer[i].executeCycle,this->ts.reorderBuffer[i].destination,this->ts.reorderBuffer[i].value,this->ts.reorderBuffer[i].address);
  }
  printf("-----------------------------------\n");
    printf("------------ ALURS STATE ------------\n");
  for(int i=0;i<this->ts.aluReservationStation.size();i++){
    printf("entry=%d,pc=%x,inst=%s,vj=%d,vk=%d,qj=%d,qk=%d,dest=%d,address=%x\n"
    ,this->ts.aluReservationStation[i].entry,this->ts.aluReservationStation[i].PC,INSTNAME[this->ts.aluReservationStation[i].instruction],
    this->ts.aluReservationStation[i].vj,this->ts.aluReservationStation[i].vk
    ,this->ts.aluReservationStation[i].qj,this->ts.aluReservationStation[i].qk,this->ts.aluReservationStation[i].destination,this->ts.aluReservationStation[i].address);
  }
  printf("-----------------------------------\n");
  printf("------------ MULRS STATE ------------\n");
  for(int i=0;i<this->ts.mulReservationStation.size();i++){
    printf("entry=%d,pc=%x,inst=%s,vj=%d,vk=%d,qj=%d,qk=%d,dest=%d,address=%x\n"
    ,this->ts.mulReservationStation[i].entry,this->ts.mulReservationStation[i].PC,INSTNAME[this->ts.mulReservationStation[i].instruction],this->ts.mulReservationStation[i].vj,this->ts.mulReservationStation[i].vk
    ,this->ts.mulReservationStation[i].qj,this->ts.mulReservationStation[i].qk,this->ts.mulReservationStation[i].destination,this->ts.mulReservationStation[i].address);

  }
  printf("-----------------------------------\n");
    printf("------------ MEMRS STATE ------------\n");
  for(int i=0;i<this->ts.memReservationStation.size();i++){
    printf("entry=%d,pc=%x,inst=%s,vj=%d,vk=%d,qj=%d,qk=%d,dest=%d,address=%x\n"
    ,this->ts.memReservationStation[i].entry,this->ts.memReservationStation[i].PC,INSTNAME[this->ts.memReservationStation[i].instruction],
    this->ts.memReservationStation[i].vj,this->ts.memReservationStation[i].vk
    ,this->ts.memReservationStation[i].qj,this->ts.memReservationStation[i].qk,this->ts.memReservationStation[i].destination,this->ts.memReservationStation[i].address);

  }
  printf("-----------------------------------\n");
    printf("------------ DIVRS STATE ------------\n");
  for(int i=0;i<this->ts.divReservationStation.size();i++){
    printf("entry=%d,pc=%x,inst=%s,vj=%d,vk=%d,qj=%d,qk=%d,dest=%d,address=%x\n"
    ,this->ts.divReservationStation[i].entry,this->ts.divReservationStation[i].PC,INSTNAME[this->ts.divReservationStation[i].instruction],
    this->ts.divReservationStation[i].vj,this->ts.divReservationStation[i].vk
    ,this->ts.divReservationStation[i].qj,this->ts.divReservationStation[i].qk,this->ts.divReservationStation[i].destination,this->ts.divReservationStation[i].address);

  }
  printf("-----------------------------------\n");
  printf("\n\n\n\n\n\n\n");

}

void Simulator::printStatistics() {
  printf("------------ STATISTICS -----------\n");
  printf("Number of Instructions: %u\n", this->history.instCount);
  printf("Number of Cycles: %u\n", this->history.cycleCount);
  printf("Avg Cycles per Instrcution: %.4f\n",
         (float)this->history.cycleCount / this->history.instCount);
  printf("Number of Control Hazards: %u\n",
         this->history.controlHazardCount);
  printf("Number of Data Hazards: %u\n", this->history.dataHazardCount);
  printf("Number of Memory Hazards: %u\n",
         this->history.memoryHazardCount);
  printf("-----------------------------------\n");
  //this->memory->printStatistics();
}

std::string Simulator::getRegInfoStr() {
  std::string str;
  char buf[65536];

  str += "------------ CPU STATE ------------\n";
  sprintf(buf, "PC: 0x%lx\n", this->pc);
  str += buf;
  for (uint32_t i = 0; i < 32; ++i) {
    sprintf(buf, "%s: 0x%.8lx(%ld) ", REGNAME[i], this->reg[i], this->reg[i]);
    str += buf;
    if (i % 4 == 3) {
      str += "\n";
    }
  }
  str += "-----------------------------------\n";
  str += "------------ TS STATE ------------\n";
  sprintf(buf, "PC: 0x%lx\n", this->pc);
  str += buf;
  for(int i=0;i<this->ts.reorderBuffer.size();i++){
    sprintf(buf,"%d: entry=%d,inst=%s,ready=%d,period=%d,execycle=%d,dest=%d,value=%d,address=%d",
    i,this->ts.reorderBuffer[i].entry,INSTNAME[this->ts.reorderBuffer[i].instruction],
    this->ts.reorderBuffer[i].ready,this->ts.reorderBuffer[i].period,this->ts.reorderBuffer[i].executeCycle,this->ts.reorderBuffer[i].destination,this->ts.reorderBuffer[i].value,this->ts.reorderBuffer[i].address);
    str+=buf;
    str+="\n";  
  }
  str += "-----------------------------------\n";
  return str;
}

void Simulator::dumpHistory() {
  std::ofstream ofile("dump.txt");
  ofile << "================== Excecution History =================="
        << std::endl;
  for (uint32_t i = 0; i < this->history.instRecord.size(); ++i) {
    ofile << this->history.instRecord[i];
    ofile << this->history.regRecord[i];
  }
  ofile << "========================================================"
        << std::endl;
  ofile << std::endl;

  ofile << "====================== Memory Dump ======================"
        << std::endl;
  ofile << this->memory->dumpMemory();
  ofile << "========================================================="
        << std::endl;
  ofile << std::endl;

  ofile.close();
}

void Simulator::panic(const char *format, ...) {
  char buf[BUFSIZ];
  va_list args;
  va_start(args, format);
  vsprintf(buf, format, args);
  fprintf(stderr, "%s", buf);
  va_end(args);
  this->dumpHistory();
  fprintf(stderr, "Execution history and memory dump in dump.txt\n");
  exit(-1);
}
