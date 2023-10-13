#include "lib.h"

int main()
{
    int x = 1;
    print_d(x);
    print_c('\n');
    float a = x;
    float b = 2;
    float c = 3;
    float out = a * b + c;
    print_f(out);
    print_c('\n');
    out = c - a * b;
    print_f(out);
    print_c('\n');
    x = (int)out;
    print_d(x);
    print_c('\n');
    exit_proc();
}