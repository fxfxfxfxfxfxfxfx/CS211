#include <cstdint>
#include <stdio.h>
namespace RISCV {
using namespace RISCV;
const int REGNUM = 32;
const int UNITNUM = 5;
typedef uint32_t RegId;
enum Reg {
  REG_ZERO = 0,
  REG_RA = 1,
  REG_SP = 2,
  REG_GP = 3,
  REG_TP = 4,
  REG_T0 = 5,
  REG_T1 = 6,
  REG_T2 = 7,
  REG_S0 = 8,
  REG_S1 = 9,
  REG_A0 = 10,
  REG_A1 = 11,
  REG_A2 = 12,
  REG_A3 = 13,
  REG_A4 = 14,
  REG_A5 = 15,
  REG_A6 = 16,
  REG_A7 = 17,
  REG_S2 = 18,
  REG_S3 = 19,
  REG_S4 = 20,
  REG_S5 = 21,
  REG_S6 = 22,
  REG_S7 = 23,
  REG_S8 = 24,
  REG_S9 = 25,
  REG_S10 = 26,
  REG_S11 = 27,
  REG_T3 = 28,
  REG_T4 = 29,
  REG_T5 = 30,
  REG_T6 = 31,
};
extern const char *REGNAME[32];
extern const char *INSTNAME[];


enum InstType {
  R_TYPE,
  I_TYPE,
  S_TYPE,
  SB_TYPE,
  U_TYPE,
  UJ_TYPE,
  INSTTYPEUNKNOWN=-1,
};

enum Inst {
  LUI = 0,
  AUIPC = 1,
  JAL = 2,
  JALR = 3,
  BEQ = 4,
  BNE = 5,
  BLT = 6,
  BGE = 7,
  BLTU = 8,
  BGEU = 9,
  LB = 10,
  LH = 11,
  LW = 12,
  LD = 13,
  LBU = 14,
  LHU = 15,
  SB = 16,
  SH = 17,
  SW = 18,
  SD = 19,
  ADDI = 20,
  SLTI = 21,
  SLTIU = 22,
  XORI = 23,
  ORI = 24,
  ANDI = 25,
  SLLI = 26,
  SRLI = 27,
  SRAI = 28,
  ADD = 29,
  SUB = 30,
  SLL = 31,
  SLT = 32,
  SLTU = 33,
  XOR = 34,
  SRL = 35,
  SRA = 36,
  OR = 37,
  AND = 38,
  ECALL = 39,
  ADDIW = 40,
  MUL = 41,
  MULH = 42,
  DIV = 43,
  REM = 44,
  LWU = 45,
  SLLIW = 46,
  SRLIW = 47,
  SRAIW = 48,
  ADDW = 49,
  SUBW = 50,
  SLLW = 51,
  SRLW = 52,
  SRAW = 53,
  UNKNOWN = -1,
};
enum Op{
  add = 0,
  sub = 1,
  mul = 2,
  div = 3,
  load = 4,
  store = 5,
  unknownOp=-1,
};

enum FunctionalUnit{
  MEMUNIT = 0,
  ALUUNIT = 1,
  MULUNIT =2,
  DIVUNIT=3,
  NOTOCCUPIED=-1,
};


// Components in the execute stage
// Reference:
// https://docs.boom-core.org/en/latest/sections/intro-overview/boom-pipeline.html
enum executeComponent {
  ALU,
  memCalc,
  dataMem,
  branchALU,
  iMul,
  iDiv,
  int2FP,
  fp2Int,
  fpDiv,
  fmaAdd, /* fused multiply-add unit for fp */
  fmaMul, /* fused multiply-add unit for fp */
  number_of_component,
  unknown = ALU,
};
enum instCompleteSchedule{
  dispatchedPeriod,
  issuedPeriod,
  executePeriod,
  writebackedPeriod,
  commitedPeriod,
};
// The lowest cycle of an datamem access
const uint32_t datamem_lat_lower_bound = 1;
// The lock cast on the stage where the next stage is busy across multiple cycles
const uint32_t datamem_stall_lock = UINT32_MAX;

const uint32_t latency[number_of_component] = {
  /* ALU */       0,
  /* memCalc */   1,
  /* dataMem */   datamem_stall_lock,
  /* branchALU */ 0,
  /* iMul */      2,
  /* iDiv */      6,
  /* int2FP */    0,
  /* fpDiv */     24,
  /* fmaAdd */    3,
  /* fmaMul */    6,
};
inline InstType getInstType(RISCV::Inst inst) {
    switch (inst)
    {
      case ADD: case SUB: case XOR:
      case OR:  case AND: case SLL: 
      case SLT: case SLTU:case SRL: 
      case SRA: case MUL: case MULH:
      case DIV: case REM: case ADDW:
      case SUBW:case SLLW:case SRLW:
      case SRAW:
        return R_TYPE; break;
      case ADDI: case ADDIW:case SLTI:  
      case SLTIU:case XORI: case ORI:  
      case ANDI: case SLLI: case SLLIW: 
      case SRLI: case SRLIW:case SRAI:  
      case SRAIW:case LB:   case LH:  
      case LW:   case LD:   case LBU:  
      case LHU:  case LWU:  case JALR:
      case ECALL:
        return I_TYPE; break;
      case SB:   case SH:  case SW:    case SD:
        return S_TYPE; break;
      case BEQ:  case BNE:   case BLT:  case BGE:
      case BLTU: case BGEU:
        return SB_TYPE; break;
      case LUI:  case AUIPC:   
        return U_TYPE; break;
      case JAL:
        return UJ_TYPE; break;
      default:
        return INSTTYPEUNKNOWN; break;
    }
  return INSTTYPEUNKNOWN;
}
inline executeComponent getComponentUsed(RISCV::Inst inst) {
    switch (inst)
    {
      /* When using the instructions below,
          general ALU is used */
      case ADDI: case ADD: case ADDIW: case ADDW:
      case SUB:  case SUBW:
      case SLTI: case SLT: case SLTIU: case SLTU:
      case XORI: case XOR:
      case ORI:  case OR:
      case ANDI: case AND:
      case SLLI: case SLL: case SLLIW: case SLLW:
      case SRLI: case SRL: case SRLIW: case SRLW:
      case SRAI: case SRA: case SRAW:  case SRAIW:
        return ALU; break;
      /* When using the instructions below,
          ALU for memory address calculation is used */
      case SB:   case SH:  case SW:    case SD:
        return memCalc; break;
      /* When using the instructions below,
          datamem is used */
      case LB:   case LH:  case LW:    case LD:
      case LBU:  case LHU: case LWU:
        return dataMem; break;
      /* When using the instructions below,
          ALU for branch offset calculation is used */
      case LUI:  case AUIPC: case JAL:  case JALR:
      case BEQ:  case BNE:   case BLT:  case BGE:
      case BLTU: case BGEU:
        return branchALU; break;
      /* When using the instructions below,
          integer multiplier is used */
      case MUL:
        return iMul; break;
      /* When using the instructions below,
          integer divider is used */
      case DIV:
        return iDiv; break;
      // YOUR CODE HERE
      // case INST:
      // ...
      // return COMPONENT_TYPE; break;
      default:
        return unknown; break;
    }
  return unknown;
}

inline FunctionalUnit getFunctionalUnit(RISCV::Inst inst) {
    switch (inst)
    {
      /* When using the instructions below,
          general ALU is used */
      case ADDI: case ADD: case ADDIW: case ADDW:
      case SUB:  case SUBW:
      case SLTI: case SLT: case SLTIU: case SLTU:
      case XORI: case XOR:
      case ORI:  case OR:
      case ANDI: case AND:
      case SLLI: case SLL: case SLLIW: case SLLW:
      case SRLI: case SRL: case SRLIW: case SRLW:
      case SRAI: case SRA: case SRAW:  case SRAIW:
        return ALUUNIT; break;
      /* When using the instructions below,
          ALU for memory address calculation is used */
      case SB:   case SH:  case SW:    case SD:
      /* When using the instructions below,
          datamem is used */
      case LB:   case LH:  case LW:    case LD:
      case LBU:  case LHU: case LWU:
        return MEMUNIT; break;
      /* When using the instructions below,
          ALU for branch offset calculation is used */
      case LUI:  case AUIPC: case JAL:  case JALR:
      case BEQ:  case BNE:   case BLT:  case BGE:
      case BLTU: case BGEU:
        return ALUUNIT; break;
      /* When using the instructions below,
          integer multiplier is used */
      case MUL: case ECALL:
        return MULUNIT; break;
      /* When using the instructions below,
          integer divider is used */
      case DIV:
        return DIVUNIT; break;
      // YOUR CODE HERE
      // case INST:
      // ...
      // return COMPONENT_TYPE; break;
      default:
        return NOTOCCUPIED; break;
    }
  return NOTOCCUPIED;
}
// Opcode field
const int OP_REG = 0x33;
const int OP_IMM = 0x13;
const int OP_LUI = 0x37;
const int OP_BRANCH = 0x63;
const int OP_STORE = 0x23;
const int OP_LOAD = 0x03;
const int OP_SYSTEM = 0x73;
const int OP_AUIPC = 0x17;
const int OP_JAL = 0x6F;
const int OP_JALR = 0x67;
const int OP_IMM32 = 0x1B;
const int OP_32 = 0x3B;

inline bool isBranch(Inst inst) {
  if (inst == BEQ || inst == BNE || inst == BLT || inst == BGE ||
      inst == BLTU || inst == BGEU) {
    return true;
  }
  return false;
}

inline bool isJump(Inst inst) {
  if (inst == JAL || inst == JALR) {
    return true;
  }
  return false;
}

inline bool isReadMem(Inst inst) {
  if (inst == LB || inst == LH || inst == LW || inst == LD || inst == LBU ||
      inst == LHU || inst == LWU) {
    return true;
  }
  return false;
}
inline bool isStoreMem(Inst inst){
  if (inst==SB||inst==SH||inst==SW||inst==SD) {
    return true;
  }
  return false;
}
inline bool isWriteReg(Inst inst){
  if(inst==BEQ||inst==BNE||inst==BLT||inst==BGE||inst==BLTU||inst==BGEU||inst==SB||inst==SH||inst==SW||inst==SD)
    return false;
  else
    return true;
}
} // namespace RISCV
