#include "lib.h"

int main()
{
    int x = 1;
    print_d(x);
    float a = x;
    float b = 2;
    float c = 3;
    float out = a * b + c;
    print_f(out);
    out = c - a * b;
    print_f(out);
    x = (int)out;
    print_d(x);
    print_c('\n');
}