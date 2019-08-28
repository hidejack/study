#include <stdio.h>
#include <stdlib.h>

//编译预处理指令 都是以#开头
//extern int i 函数的声明


//#define 用来定义宏
#define PI 3.14159
#define PI2 2 * PI
//多行要用 \ 分开
#define PRT printf("%f \n",PI) ;\
            printf("%f \n",PI2)

//没有值的宏 : 用于条件编译
#define _DEBUG

//预定义的宏:
//__LINE__ :源代码所在行数
//__FILE__：源代码所在文件
//__DATE__ ： 编译日期
// __TIME__

//像函数的宏
#define cube(x)    ((x)*(x)*(x))

//带参数的宏 ： 一切都要有括号。整个值要有括号，参数要有括号。
//重要！！！定义宏，不要加分号;
//宏不存在类型检查
//部分宏可以被inline 取代


int main(int argc, char const *argv[])
{
    PRT;
    printf("%d\n",cube(5));
    return 0;
}
