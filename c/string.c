#include <stdio.h>
#include <string.h>

/**
 * 字符串 c语言中会在末尾 补 0
 * 字符串在c语言中存在的形式是数组
 * char *s = "hello"
 * char s[] = "hello"
 * char s[10] = "hello"
 * 编译器会自动在结尾 加0
 *
*/

char* str_cpy(char *dst,const char *src);

int str_cmp(const char *s1,const char *s2);

size_t str_len(const char *s);

char * str_cat();


int main(int argc, char const *argv[])
{
    char *s1 = "Hello World"; //指针指向hello，hello 在代码段，不可修改
    char *s2 = "Hello World";
    char str1[] = "Hello World";//hello 在str数组中，本地变量，可自动回收
    char str2[] = "Hello World";

    printf("s1=%p \n",s1); //s1=0x10b84df8c
    printf("s2=%p \n",s2);//s2=0x10b84df8c
    printf("str1=%p\n",&str1);//str=0x7ffee43b21d
    printf("str2=%p\n",&str2);

    //测试自己写的函数
    char *a1 = "abc";
    char *a2 = "aBc";
    char *a3 = "abc";
    printf("str_len : %lu \n",str_len(s1));
    int b1 = str_cmp(a1,a2);
    int b2 = str_cmp(a1,a3);
    printf("b1=%d,b2=%d",b1,b2);

    return 0;
}


char* my_str_cpy(char *dst,const char *src)
{
    char *ret = dst;
    while( (*dst++ = *src++) )
        ;
    *dst = '\0';
    return ret;
}

int my_str_cmp(const char *s1,const char *s2)
{
    int idx = 0;
    while(*s1 == *s2 && *s1 != '\0'){
        s1++;
        s2++;
    }
    return *s1 - *s2;
}

size_t my_str_len(const char *s)
{
    int idx = 0;
    while(*s++ != '\0'){
        idx++;
    }
    return idx;
}