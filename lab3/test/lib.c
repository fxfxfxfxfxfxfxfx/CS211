/**
 * Simple implementation of common library functions
 */

#include "lib.h"

void print_d(int num)
{
    asm("li a7, 2;"
        "scall");
}

void print_s(const char *str)
{
    asm("li a7, 0;"
        "scall");
}

void print_c(char ch)
{
    asm("li a7, 1;"
        "scall");
}

void exit_proc() {
    asm("li a7, 3;"
        "scall");
}

char read_char()
{
    char result;
    asm("li a7, 4;"
        "scall");
    asm("addi %0, a0, 0" : "=r" (result));
    return result;
}

long long read_num()
{
    long long result;
    asm("li a7, 5;"
        "scall");
    asm("addi %0, a0, 0" : "=r" (result));
    return result;
}

void print_f(float num)
{
    asm("li a7, 6;"
        "scall");
}

void set_array(int num,int*orignal,int*final)
{
    asm("li a7,7;"
        "scall"
    );
}

int get_arraymax(int num,int* orignal)
{
    int result;
    asm("li a7,8;"
        "scall"
    );
    asm("addi %0, a0, 0" : "=r" (result));
}