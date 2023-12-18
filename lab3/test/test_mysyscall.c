#include "lib.h"
int main() {
    int a=11;
    int b[11]={12,323,4535,4567,576,456,3434,324,346345,0,5234};
    int c[11];
    set_array(a,b,c);
    for(int i=0;i<11;i++){
        print_d(c[i]);
        print_c('\n');
    }
    a=get_arraymax(a,c);
    print_d(a);
    print_c('\n');
    exit_proc();
}