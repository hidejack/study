SELECT语句
用于查询表中数据
SELECT子句后面跟的是要查询的
字段,可以包括表中的具体字段,函数
或者表达式.
FROM子句用来指定数据来源的表
WHERE子句用来添加过滤条件,这样
做的结果是只将满足条件的记录查询出来

查看emp表中的数据
SELECT empno,ename,job,sal
FROM emp

SELECT子句中使用表达式
查看每个员工的年薪?
SELECT ename,sal*12
FROM emp

字符串函数
CONCAT()函数,用来连接字符串
SELECT CONCAT(ename,sal)
FROM emp

SELECT CONCAT(CONCAT(ename,','),sal)
FROM emp

SELECT ename||','||sal
FROM emp

LENGTH函数,查看字符串长度
SELECT ename,LENGTH(ename)
FROM emp

UPPER,LOWER,INITCAP
将字符串转换为全大写,全小写
以及首字母大写
对于INITCAP而言,可以使用空格
隔开多个单词,那么每个单词首字母
都会大写.

伪表:dual
当查询的内容不和任何表中数据有关系
时,可以使用伪表,伪表只会查询出一条
记录.
SELECT UPPER('helloworld'),
       LOWER('HELLOWORLD'),
       INITCAP('HELLO WORLD')
FROM dual

TRIM,LTRIM,RTRIM
去除当前字符串中两边的指定重复
字符,LTRIM仅去除左侧的,RTRIM
则仅去除右侧的.
SELECT TRIM('e' FROM 'eeeliteeee')
FROM dual

SELECT LTRIM('esrrersrresresliteeee','res')
FROM dual


LPAD,RPAD补位函数
SELECT LPAD(sal,5,'$')
FROM emp


SUBSTR截取字符串
数据库中的下标都是从1开始的
SELECT 
  SUBSTR('thinking in java',13,4)
FROM dual

第三个参数不指定则是截取到末尾,指定的长度
若超过实际可以截取的内容也是截取到末尾
SELECT 
  SUBSTR('thinking in java',10)
FROM dual

截取的位置可以是负数,若是则表示从倒数
第几个字符开始截取
SELECT 
  SUBSTR('thinking in java',-4,4)
FROM dual


INSTR(char1,char2[,n,m])函数
查找char2在char1中的位置
n为从第几个字符开始检索
m为第几次出现
n,m不写则默认都是1

SELECT 
 INSTR('thinking in java','in',4,1)
FROM 
 dual


数字函数
ROUND(n,m)四舍五入
SELECT ROUND(45.678, 2) FROM DUAL
SELECT ROUND(45.678, 0) FROM DUAL
SELECT ROUND(45.678, -1) FROM DUAL


TRUNC(n,m)截取数字
SELECT TRUNC(45.678, 2) FROM DUAL
SELECT TRUNC(45.678, 0) FROM DUAL
SELECT TRUNC(45.678, -1) FROM DUAL


MOD(m,n)求余数
SELECT ename, sal, MOD(sal, 1000) 
FROM emp 


CEIL,FLOOR
向上取整和向下取整
SELECT CEIL(45.678) FROM DUAL
SELECT FLOOR(45.678) FROM DUAL


查看scott员工的信息?
SELECT ename,sal,deptno
FROM emp
WHERE ename=UPPER('scott')

查看名字只有5个字母的员工的名字,工资?
部门号
SELECT ename,sal,deptno
FROM emp
WHERE LENGTH(ename)=5

查看第三个字母是A的员工信息?
SELECT ename,sal,deptno
FROM emp
WHERE INSTR(ename,'A')=3

SELECT ename,sal,deptno
FROM emp
WHERE SUBSTR(ename,3,1)='A'


日期类型

SYSDATE,SYSTIMESTAMP
SYSDATE对应数据库一个内部函数,
该函数返回一个表示当前系统时间
的DATE类型值.
SYSTIMESTAMP返回的是一个表示
当前系统时间的时间戳类型的值

SELECT SYSDATE FROM dual
SELECT SYSTIMESTAMP FROM dual

TO_DATE函数
可以将字符串按照给定的日期格式解析
为一个DATE类型的值

在日期格式字符串中凡不是英文,符号,数字的
其他字符,都需要使用双引号括起来.
SELECT 
  TO_DATE('2008年08月08日 20:08:08',
          'YYYY"年"MM"月"DD"日" HH24:MI:SS')
FROM
  dual

日期的计算
日期可以与一个数字进行加减法,这相当
与加减指定的天
两个日期可以进行减法,差为相差的天.

查看每个员工至今入职多少天了?
SELECT ename,SYSDATE-hiredate
FROM emp

输入自己生日:1992-08-02
查看到今天为止活了多少天?
SELECT 
 SYSDATE-TO_DATE('1992-08-02',
                 'YYYY-MM-DD')
FROM dual

TO_CHAR():可以将DATE按照给定的格式
转换为字符串.
SELECT
 TO_CHAR(SYSDATE,
        'YYYY-MM-DD HH24:MI:SS')
FROM
 dual


SELECT 
 TO_CHAR(
  TO_DATE('49-07-12','RR-MM-DD'),
  'YYYY-MM-DD' 
 )
FROM
 dual


LAST_DAY(date)
返回给定日期所在月的月底日期

查看当月底?
SELECT LAST_DAY(SYSDATE)
FROM dual


ADD_MONTHS(date,i)
对给定日期加上指定的月,若
i为负数则是减去.

查看每个员工入职20周年纪念日
SELECT 
 ename,ADD_MONTHS(hiredate,12*20)
FROM
 emp


MONTHS_BETWEEN(date1,date2)
计算两个日期之间相差的月,计算是
根据date1-date2得到的

查看每个员工至今入职多少个月了?
SELECT 
 ename,MONTHS_BETWEEN(SYSDATE,hiredate)
FROM 
 emp

NEXT_DAY(date,i)
返回给定日期的第二天开始一周
之内的指定周几的日期
i:1表示周日,2表示周一,以此类推

SELECT NEXT_DAY(SYSDATE,7)
FROM dual

LEAST,GREATEST
求最小值与最大值,除了
日期外,常用的数字也可以比较大小
SELECT 
 LEAST(SYSDATE, 
       TO_DATE('2008-08-05',
               'YYYY-MM-DD'))
FROM DUAL


EXTRACT()提取给定日期中指定
时间分量的值
SELECT EXTRACT(YEAR FROM SYSDATE)
FROM dual

查看1980年入职的员工
SELECT ename,hiredate
FROM emp
WHERE EXTRACT(YEAR FROM hiredate)=1980


空值操作

1:插入NULL值
CREATE TABLE student
    (id NUMBER(4), name CHAR(20), gender CHAR(1));

INSERT INTO student VALUES(1000, '李莫愁', 'F');

INSERT INTO student VALUES(1001, '林平之', NULL);

INSERT INTO student(id, name) VALUES(1002, '张无忌');

SELECT * FROM student

2:更新为NULL
UPDATE student
SET gender=NULL
WHERE id=1000

判断字段的值是否为NULL
判断要使用IS NULL或IS NOT NULL
DELETE FROM student
WHERE gender IS NULL


NULL值的运算操作
NULL与任何数字运算结果还为NULL
NULL与字符串拼接等于什么都没干

查看每个员工的收入:
SELECT ename,sal,comm,sal+comm
FROM emp

空值函数
NVL(arg1,arg2)
当arg1为NULL,函数返回arg2的值
若不为NULL,则返回arg1本身.
所以该函数的作用是将NULL值替换为
一个非NULL值.
查看每个员工的收入:
SELECT 
 ename,sal,comm,
 sal+NVL(comm,0)
FROM emp

查看每个人的绩效情况,即:
有绩效的,显示为"有绩效"
绩效为NULL的,则显示为"没有绩效"

NVL2(arg1,arg2,arg3)
当arg1不为NULL,则函数返回arg2
当arg1为NULL,则函数返回arg3
该函数是根据一个值是否为NULL来
返回两个不同结果.

SELECT 
  ename,comm,
  NVL2(comm,'有奖金','没有奖金')
FROM
  emp

SELECT 
  ename,sal,comm,
  NVL2(comm,sal+comm,sal)
FROM
  emp



