#include "lib.h"
int main() {
    float a = 3.14159, b = 2.653, c = 3.0, d = 123.45;
    float x = a + b;
    print_f(x);
    print_c('\n');
    float y = a - b;
    print_f(y);
    print_c('\n');
    float z = c * d;
    print_f(z);
    print_c('\n');

    x = d / c;
    print_f(x);
    print_c('\n');
    exit_proc();
}