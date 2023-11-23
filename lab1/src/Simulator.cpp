/*
 * Created by He, Hao at 2019-3-11
 */

#include <cstring>
#include <fstream>
#include <sstream>
#include <string>
#include <queue>
#include "Debug.h"
#include "Simulator.h"


Simulator::Simulator(MemoryManager *memory, Scoreboard *scoreboard) {
  this->memory = memory;
  this->scoreboard=scoreboard;
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
  while (true) {
    if (this->reg[0] != 0) {
      // Some instruction might set this register to zero
      this->reg[0] = 0;
      // this->panic("Register 0's value is not zero!\n");
    }
    for(int i=0;i<this->scoreboard->instStatus.size();i++){
      tem.pc=this->scoreboard->instStatus[i].pc;
      tem.instSc=this->scoreboard->instStatus[i].instSchedule;
      this->snapShot.push_back(tem);
    }

    if (this->reg[REG_SP] < this->stackBase - this->maximumStackSize) {
      this->panic("Stack Overflow!\n");
    }
    if(!this->scoreboard->pause)
      this->issue(this->pc);
     for(int i=0;i<this->snapShot.size();i++){
      if(this->snapShot[i].instSc==issuedPeriod){
        this->read(this->snapShot[i].pc);
      }
    }
     for(int i=0;i<this->snapShot.size();i++){
      if(this->snapShot[i].instSc==readedPeriod){
        this->execute(this->snapShot[i].pc);
      }
    }
     for(int i=0;i<this->snapShot.size();i++){
      if(this->snapShot[i].instSc==executePeriod)
        this->writeBack(this->snapShot[i].pc);
    }

    this->snapShot.clear();
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

void Simulator::issue(uint64_t instPC) {
  std::string instname = "";
  std::string inststr = "";
  std::string deststr, op1str, op2str, offsetstr;
  Inst insttype = Inst::UNKNOWN;
  uint32_t inst = this->memory->getInt(this->pc);
  uint32_t len = 4;
  int64_t op1 = 0, op2 = 0, offset = 0; // op1, op2 and offset are values
  RegId dest = 0, reg1 = -1, reg2 = -1; // reg1 and reg2 are operands
  if (this->pc % 2 != 0) {
    this->panic("Illegal PC 0x%x!\n", this->pc);
  }
  
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
  } else { // 16 bit instruction
    this->panic(
        "Current implementation does not support 16bit RV64C instructions!\n");
  }
  if (instname != INSTNAME[insttype]) {
    this->panic("Unmatch instname %s with insttype %d\n", instname.c_str(),
                insttype);
  }
// Determine whether the functional unit is occupied
  if (verbose) {
    printf("issue: %s,pc=%x\n", INSTNAME[insttype],instPC);
  }
  if(!this->scoreboard->isFuncUnitFree(insttype)){
    this->history.structureHazardCount++;
    return;
  }
  if(!this->scoreboard->isDestBlank(dest)){
    this->history.dataHazardCount++;
  }
  if(!this->scoreboard->isDestBlank(dest)||this->scoreboard->pause){
    return;
  }
  else{  
    this->scoreboard->updateFetchInstStatus(this->pc);
    this->history.instCount++;
    for(int i=0;i<this->scoreboard->instStatus.size();i++){
      if(this->scoreboard->instStatus[i].pc==instPC){
        this->pc = this->pc + len;
        this->scoreboard->instStatus[i].inst=insttype;
        this->scoreboard->instStatus[i].rs1=reg1;
        this->scoreboard->instStatus[i].rs2=reg2;
        this->scoreboard->instStatus[i].dest=dest;
        this->scoreboard->instStatus[i].offset=offset;
        this->scoreboard->instStatus[i].op1=op1;
        this->scoreboard->instStatus[i].op2=op2;
        this->scoreboard->instStatus[i].unit=this->scoreboard->updateIssueFuncStatus(insttype,dest,reg1,reg2);
        this->scoreboard->updateIssueInstStatus(instPC);
      }
    }
  }
  if(isBranch(insttype)||isJump(insttype)){
    this->scoreboard->pause=true;
    this->history.controlHazardCount++;
  }
}

void Simulator::read(uint64_t instPC) {
  int64_t op1,op2;
  RegId reg1,reg2;
  FunctionalUnit funit;
  Inst inst;
  for(int i=0;i<this->scoreboard->instStatus.size();i++){
    if(this->scoreboard->instStatus[i].pc==instPC){
      RISCV::Inst inst=this->scoreboard->instStatus[i].inst;
      op1=this->scoreboard->instStatus[i].op1;
      op2=this->scoreboard->instStatus[i].op2;
      reg1=this->scoreboard->instStatus[i].rs1;
      reg2=this->scoreboard->instStatus[i].rs2;
      funit=this->scoreboard->instStatus[i].unit;
      inst=this->scoreboard->instStatus[i].inst;
    }
  }
  if (verbose) {
    printf("read: %s,pc=%x\n", INSTNAME[inst],instPC);
  }
  if(this->scoreboard->isSrcRegReady(funit)){
    //如果操作数准备好
    if(reg1!=-1)
      op1=this->reg[reg1];
    if(reg2!=-1)
      op2=this->reg[reg2];
    for(int i=0;i<this->scoreboard->instStatus.size();i++){
      if(this->scoreboard->instStatus[i].pc==instPC){
        this->scoreboard->instStatus[i].op1=op1;
        this->scoreboard->instStatus[i].op2=op2;
    }
    this->scoreboard->updateReadFuncStatus(funit);
    this->scoreboard->updateReadInstStatus(instPC);
  }{
    this->history.dataHazardCount++;
  }
  }
}

void Simulator::execute(uint64_t instPC) {
  Inst inst;
  int64_t op1,op2,offset,out;
  FunctionalUnit funit;
  uint64_t dRegPC;
  RegId destReg;
  uint32_t memLen=0;
  bool writeReg = false;
  bool writeMem = false;
  bool readMem = false;
  bool readSignExt = false;
  bool branch = false;
  for(int i=0;i<this->scoreboard->instStatus.size();i++){
    if(this->scoreboard->instStatus[i].pc==instPC){
      inst=this->scoreboard->instStatus[i].inst;
      op1=this->scoreboard->instStatus[i].op1;
      op2=this->scoreboard->instStatus[i].op2;
      offset=this->scoreboard->instStatus[i].offset;
      funit=this->scoreboard->instStatus[i].unit;
      dRegPC=instPC;
      destReg=this->scoreboard->instStatus[i].dest;
    }
  }
  if (verbose) {
    printf("execute: %s,pc=%x\n", INSTNAME[inst],instPC);
  }
  if(isReadMem(inst)&&this->scoreboard->unit[funit].readMemOver){
    this->scoreboard->unit[funit].remainingPeriod--;
    if(this->scoreboard->unit[funit].remainingPeriod==0){
      this->scoreboard->updateExecuteInstStatus(instPC);
    }
    return;
  }
  if(!isReadMem(inst)&&this->scoreboard->unit[funit].remainingPeriod!=latency[getComponentUsed(inst)]+1){
    this->scoreboard->unit[funit].remainingPeriod--;
    if(this->scoreboard->unit[funit].remainingPeriod==0){
      this->scoreboard->updateExecuteInstStatus(instPC);
    }
    return;
  }

  this->scoreboard->unit[funit].remainingPeriod--;
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
    this->panic("Unknown instruction type %d\n", inst);
  }
  //处理跳转
  if (isJump(inst)) {
    // Control hazard here
    this->pc = dRegPC;
  }
  //处理分支
  if (isBranch(inst)) {
    if (branch) {
      this->pc=dRegPC;
    } else {
      // Control Hazard Here
      this->scoreboard->pause=false;
    }
  }
  //处理访存
  bool good = true;
  uint32_t cycles = 0;
  if (writeMem) {
    switch (memLen) {
    case 1:
      good = this->memory->setByte(out, op2, &cycles);
      break;
    case 2:
      good = this->memory->setShort(out, op2, &cycles);
      break;
    case 4:
      good = this->memory->setInt(out, op2, &cycles);
      break;
    case 8:
      good = this->memory->setLong(out, op2, &cycles);
      break;
    default:
      this->panic("Unknown memLen %d\n", memLen);
    }
  }

  if (!good) {
    this->panic("Invalid Mem Access!\n");
  }
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
    this->scoreboard->unit[INTUNIT].remainingPeriod=cycles;
    this->scoreboard->unit[INTUNIT].readMemOver=true;
  }
  for(int i=0;i<this->scoreboard->instStatus.size();i++){
    if(this->scoreboard->instStatus[i].pc==instPC){
      this->scoreboard->instStatus[i].op1=op1;
      this->scoreboard->instStatus[i].op2=op2;
      this->scoreboard->instStatus[i].writeReg=writeReg;
      this->scoreboard->instStatus[i].out=out;
      offset=this->scoreboard->instStatus[i].offset;
      funit=this->scoreboard->instStatus[i].unit;
      dRegPC=instPC;
      destReg=this->scoreboard->instStatus[i].dest;
    }
  }
  if(this->scoreboard->unit[funit].remainingPeriod==0){
    this->scoreboard->updateExecuteInstStatus(instPC);
  }
}
void Simulator::writeBack(uint64_t instPC) {
  bool writeReg;
  int64_t out;
  RegId destReg;
  Inst inst;
  FunctionalUnit funit;
  for(int i=0;i<this->scoreboard->instStatus.size();i++){
    if(this->scoreboard->instStatus[i].pc==instPC){
      writeReg=this->scoreboard->instStatus[i].writeReg;
      destReg=this->scoreboard->instStatus[i].dest;
      out=this->scoreboard->instStatus[i].out;
      funit=this->scoreboard->instStatus[i].unit;
      inst=this->scoreboard->instStatus[i].inst;
    }
  }
  if (verbose) {
    printf("writeback: %s,pc=%x\n", INSTNAME[inst],instPC);
  }
  if(!writeReg||this->scoreboard->isDestRead(destReg)){
    this->history.dataHazardCount++;
    this->reg[destReg]=out;
    this->scoreboard->updateWriteBackFuncStatus(funit,destReg);
    this->scoreboard->updateWritebackInstStatus(instPC);
  }
  if(isBranch(inst)||isJump(inst))
    this->scoreboard->pause=false;
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
  printf("------------ SCOREBOARD STATE ------------\n");
  printf("funit=INTUNIT,busy=%d,remain=%d,fi=%d,fj=%d,fk=%d,qj=%d,qk=%d,Rj=%d,RK=%d\n",
  this->scoreboard->unit[0].busy,
  this->scoreboard->unit[0].remainingPeriod,
  this->scoreboard->unit[0].fi,
  this->scoreboard->unit[0].fj,
  this->scoreboard->unit[0].fk,
  this->scoreboard->unit[0].qj,
  this->scoreboard->unit[0].qk,
  this->scoreboard->unit[0].rj,
  this->scoreboard->unit[0].rk);
  printf("funit=ADDUNIT,busy=%d,remain=%d,fi=%d,fj=%d,fk=%d,qj=%d,qk=%d,Rj=%d,RK=%d\n",
  this->scoreboard->unit[1].busy,
  this->scoreboard->unit[1].remainingPeriod,
  this->scoreboard->unit[1].fi,
  this->scoreboard->unit[1].fj,
  this->scoreboard->unit[1].fk,
  this->scoreboard->unit[1].qj,
  this->scoreboard->unit[1].qk,
  this->scoreboard->unit[1].rj,
  this->scoreboard->unit[1].rk);
  printf("funit=MUL1UNIT,busy=%d,remain=%d,fi=%d,fj=%d,fk=%d,qj=%d,qk=%d,Rj=%d,RK=%d\n",
  this->scoreboard->unit[2].busy,
  this->scoreboard->unit[2].remainingPeriod,
  this->scoreboard->unit[2].fi,
  this->scoreboard->unit[2].fj,
  this->scoreboard->unit[2].fk,
  this->scoreboard->unit[2].qj,
  this->scoreboard->unit[2].qk,
  this->scoreboard->unit[2].rj,
  this->scoreboard->unit[2].rk);
  printf("funit=MUL2UNIT,busy=%d,remain=%d,fi=%d,fj=%d,fk=%d,qj=%d,qk=%d,Rj=%d,RK=%d\n",
  this->scoreboard->unit[3].busy,
  this->scoreboard->unit[3].remainingPeriod,
  this->scoreboard->unit[3].fi,
  this->scoreboard->unit[3].fj,
  this->scoreboard->unit[3].fk,
  this->scoreboard->unit[3].qj,
  this->scoreboard->unit[3].qk,
  this->scoreboard->unit[3].rj,
  this->scoreboard->unit[3].rk);
  printf("funit=DIVUNIT,busy=%d,remain=%d,fi=%d,fj=%d,fk=%d,qj=%d,qk=%d,Rj=%d,RK=%d\n",
  this->scoreboard->unit[4].busy,
  this->scoreboard->unit[4].remainingPeriod,
  this->scoreboard->unit[4].fi,
  this->scoreboard->unit[4].fj,
  this->scoreboard->unit[4].fk,
  this->scoreboard->unit[4].qj,
  this->scoreboard->unit[4].qk,
  this->scoreboard->unit[4].rj,
  this->scoreboard->unit[4].rk);
  printf("------------ SCOREBOARD INST STATE ------------\n");
  for(int i=0;i<this->scoreboard->instStatus.size();i++){
    printf("%d\n",this->scoreboard->instStatus.size());
    printf("inst=%s,pc=%d,rs1=%d,rs2=%d,dest=%d,op1=%d,op2=%d,offset=%d,unit=%d,period=%d\n",
      INSTNAME[this->scoreboard->instStatus[i].inst],
      this->scoreboard->instStatus[i].pc,
      this->scoreboard->instStatus[i].rs1,
      this->scoreboard->instStatus[i].rs2,
      this->scoreboard->instStatus[i].dest,
      this->scoreboard->instStatus[i].op1,
      this->scoreboard->instStatus[i].op2,
      this->scoreboard->instStatus[i].offset,
      this->scoreboard->instStatus[i].unit,
      this->scoreboard->instStatus[i].instSchedule
    );
  }
  printf("------------ REG INST STATE ------------\n");
  for(int i=0;i<32;i++){
    printf("%s  ",REGNAME[i]);
  }
  printf("\n");
  for(int i=0;i<32;i++){
    printf("%d  ",this->scoreboard->registerStatus[i]);
  }
  printf("\n");
  printf("pasue=%d",this->scoreboard->pause);
  printf("\n");
  printf("-----------------------------------\n");

}

void Simulator::printStatistics() {
  printf("------------ STATISTICS -----------\n");
  // printf("Number of Instructions: %u\n", this->history.instCount);
  // printf("Number of Cycles: %u\n", this->history.cycleCount);
  // printf("Avg Cycles per Instrcution: %.4f\n",
  //        (float)this->history.cycleCount / this->history.instCount);
  // printf("Number of Control Hazards: %u\n",
  //        this->history.controlHazardCount);
  printf("Number of Data Hazards: %u\n", this->history.dataHazardCount);
  // printf("Number of Stall Because Data Hazards: %u\n", this->history.stallDataHazardCount);
  // printf("Cycles of structureHazardCount: %u\n",this->history.structureHazardCount);
  // printf("Number of Stall Because Struct Hazards: %u\n", this->history.stallStructureHazardCount);
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
