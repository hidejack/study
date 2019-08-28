#include <stdio.h>
#include <stdlib.h>

/**
 * 动态分配内存
 * 调用malloc（size_t）函数，参数传入要分配的内存大小
 * 返回 void*
 * void* 表示不确定类型的一片内存空间
 * 
*/
int main() {
    int number = 10;
    int *a = 0;
    a = (int*) malloc(number * sizeof(int));

    //TODO Something!

    free(a);
    free(NULL); //可以用
    return 0;
}