#include "lib.h"
int main()
{
    // float a = 1;
    int a = 1, b = 2;
    float c = 1, d = 2; 
    int x = a + b;
    print_d(x);
    // print_c('\n');
    float y = c + d;
    print_f(y);
    // print_c('\n');
    float z = c * d;
    print_f(z);
    // print_c('\n');
    // print_f(a);
    // int *p = &a;
    exit_proc();
}
// #include "lib.h"
// int main() {
//     float a = 2, b = 1, c = 3, d = 4;
//     float x = a + b;
//     print_f(x);
//     print_c('\n');
//     float y = a - b;
//     print_f(y);
//     print_c('\n');
//     // float z = c * d;
//     // print_f(z);
//     // print_c('\n');

//     x = d / c;
//     print_f(x);
//     print_c('\n');
//     exit_proc();
// }


// test
// riscv64-unknown-elf-gcc -march=rv64if ../test/test_float_1.c ../test/lib.c -o ../riscv-elf/test_float_1.riscv
// riscv64-unknown-elf-objdump -d ../riscv-elf/test_float_1.riscv > ../riscv-elf/test_float_1.s
// ./Simulator ../riscv-elf/test_float_1.riscv 

