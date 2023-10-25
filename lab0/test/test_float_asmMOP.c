#include "lib.h"

int main() {
    float out;
    float intout;
    int in=0x3F800000;
    float a = 2.0f;
    float b = 3.0f;
    float c = 4.0f;
    asm volatile (
        "fmadd.s %0, %1, %2, %3\n"  // out = a * b + c
        : "=f" (out)               
        : "f" (a), "f" (b), "f" (c) 
    );
    print_f(out);
    print_c('\n');
    asm volatile (
        "fmsub.s %0, %1, %2, %3\n"  // out = a * b - c
        : "=f" (out)                
        : "f" (a), "f" (b), "f" (c) 
    );
    print_f(out);
    print_c('\n');
    asm volatile (
        "fsqrt.s %0, %1\n"  // out = a^0.5
        : "=f" (out)                
        : "f" (c) 
    );
    print_f(out);
    print_c('\n');
    asm volatile (
        "fmv.x.w %0, %1\n"  
        : "=r" (intout)                
        : "f" (a) 
    );
    print_d(intout);
    print_c('\n');
    asm volatile (
        "fmv.w.x %0, %1\n"  
        : "=f" (out)       
        : "r" (in)         
    );
    print_f(out);
    print_c('\n');
    return 0;
}