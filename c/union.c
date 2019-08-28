#include <stdio.h>

//联合 ： 即 i 和 ch 共享 内存，改变i，则改变 ch
typedef union
{
    int i;
    char ch[sizeof(int)];
} CHI;

int main(int argc, char const *argv[])
{
    CHI chi;
    int i ;
    chi.i = 1234;  //04D2
    for(i = 0;i<sizeof(int);i++){
        printf("%02hhX",chi.ch[i]);
        chi.ch[i]=i+2;
    }
    printf("\n");
    printf("%d \n",chi.i);

    for(i = 0;i<sizeof(int);i++){
        printf("%02hhX",chi.ch[i]);
    }

    return 0;
}

