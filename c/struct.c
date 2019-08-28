#include <stdio.h>

//typedef 定义struct 新的名字

//结构体定义！
typedef struct Date
{
    int month;
    int day;
    int year;
} ADate;

int main(int argc, char const *argv[])
{
    //声明date 类型变量 d1，d2
    struct Date d1;
    ADate d2;

    //同时定义结构体和变量
    struct point
    {
        int x;
        int y;
    } p1,p2;

    //定义d3
    struct Date d3 = 
    {
        .month=1,
        .day=2,
        .year = 3,
    };

    d1.day = 2;
    d1.month = 3;
    d1.year = 1903;

    struct point p3 = {1,2};

    //指向结构的指针
    struct Date *datePointer = &d1;
    //不常用
    (*datePointer).month = 12;
    //常用 指向结构的指针
    datePointer-> year = 2019;
    printf("year:%d m:%d day:%d ",d1.year,datePointer->month,(*datePointer).day);
    
    


    return 0;
}

