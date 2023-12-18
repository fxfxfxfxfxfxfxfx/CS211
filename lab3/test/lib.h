#ifndef RISCV_SIMULATOR_LIB_H
#define RISCV_SIMULATOR_LIB_H

void print_d(int num);
void print_s(const char *str);
void print_c(char ch);

void exit_proc();

char read_char();
long long read_num();

void print_f(float num);
void set_array(int num,int*orignal,int*final);
int get_arraymax(int num,int* orignal);
#endif
