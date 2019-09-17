
#include <stdio.h>
#include <time.h>

clock_t start,end;
double duration;

void printN_1(int);
void printN_2(int);

int main() {
    start = clock();
    printN_2(100000000);
    end = clock();
    duration = (double)((end - start) / CLOCKS_PER_SEC);
    printf("%f",duration);
    return 0;
}

/**
 * 循环实现
 */
void printN_1(int n){
    int i ;
    for(i = 0;i<=n;i++){
    }
    return ;
}

/**
 * 递归实现
*/
void printN_2(int n){
    if(n){
        printN_2(n);
    }
}