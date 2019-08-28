DQL查询语句

SELECT子句中可以使用函数或表达式
,那么结果集中对应的该字段名就是这个
函数或表达式,可读性差,为此可以为这样
的字段添加别名,那么结果集会以这个别名
作为该字段的名字
别名本身不区分大小写,而且不能含有空格.
若希望别名区分大小写或含有空格,那么可以
在别名上使用双引号括起来.
SELECT ename,sal*12 "sal"
FROM emp




查看工资高于1000的职位是
CLERK和SALESMAN
SELECT ename,sal,job
FROM emp
WHERE sal>1000
AND (job='SALESMAN'
OR job='CLERK')

AND的优先级高于OR,可以通过括号
来提高OR的优先级


LIKE用于模糊匹配字符串,支持两个
通配符:
_:单一的一个字符
%:任意个字符

查看名字第二个字母是A最后一个字母是N的?
SELECT ename
FROM emp
WHERE ename LIKE '_A%N'


IN和NOT IN
判断是否在列表中或不在列表中
SELECT ename, job FROM emp  
WHERE job IN ('MANAGER', 'CLERK');

SELECT ename, job FROM emp
WHERE deptno NOT IN (10, 20);

IN和NOT IN常用来判断子查询的结果



BETWEEN...AND...
判断在一个区间范围内

工资在1500到3000之间的员工
SELECT ename,sal
FROM emp
WHERE sal BETWEEN 1500 AND 3000

ANY,ALL
ANY和ALL是配合>,>=,<,<=一个
列表使用的.
>ANY(list):大于列表中最小的
>ALL(list):大于列表中最大的
<ANY(list):小于列表中最大的
<ALL(list):小于列表中最小的
ANY和ALL常用于子查询.
SELECT empno, ename, job, 
       sal, deptno
FROM emp
WHERE sal > ANY (3500,4000,4500);

使用函数或者表达式最为过滤条件
SELECT ename, sal, job 
FROM emp 
WHERE ename = UPPER('scott');

SELECT ename, sal, job 
FROM emp 
WHERE sal * 12 >50000;

DISTINCT关键字
对结果集中指定字段值重复的记录进行
去重

查看公司有哪些职位?
SELECT DISTINCT job
FROM emp

多字段去重,是对这些字段值的组合
进行去重
SELECT DISTINCT job,deptno
FROM emp

排序
ORDER BY子句
ORDER BY可以根据其后指定的
字段对结果集按照该字段的值进行
升序或者降序排列.
ASC:升序,不写默认就是升序
DESC:降序.

查看公司的工资排名:
SELECT ename,sal
FROM emp
ORDER BY sal DESC

ORDER BY按照多个字段排序
ORDER BY首先按照第一个字段的排序
方式对结果集进行排序,当第一个字段
有重复值时才会按照第二个字段排序
方式进行排序,以此类推.每个字段都可以
单独指定排序方式.
SELECT ename,deptno,sal
FROM emp
ORDER BY deptno DESC,sal DESC

排序的字段中含有NULL值,NULL被认作
最大值.
SELECT ename,comm
FROM emp
ORDER BY comm DESC

聚合函数
聚合函数有叫多行函数,分组函数
聚合函数是对结果集某些字段的值进行统计的.

MAX,MIN
求给定字段的最大值与最小值

查看公司的最高工资与最低工资是多少?
SELECT MAX(sal),MIN(sal)
FROM emp

AVG,SUM
求平均值和总和
SELECT AVG(sal),SUM(sal)
FROM emp

COUNT函数
COUNT函数不是对给定的字段的值进行
统计的,而是对给定字段不为NULL的记录
数统计的.
实际上所有聚合函数都忽略NULL值统计.

SELECT COUNT(ename)
FROM emp

通常查看表的记录数可以使用COUNT(*)
SELECT COUNT(*) FROM emp


查看平均绩效
SELECT AVG(NVL(comm,0)),SUM(comm)
FROM emp


分组
GROUP BY 子句
GROUP BY可以将结果集按照其后指定
的字段值相同的记录看做一组,然后配合
聚合函数进行更细分的统计工作.

查看每个部门的平均工资?
SELECT AVG(sal),deptno
FROM emp
GROUP BY deptno

查看每个职位的最高工资?
SELECT MAX(sal),job
FROM emp
GROUP BY job

GROUP BY也可以根据多个字段分组
分组原则为这几个字段值都相同的记录看做一组

查看同部门同职位的平均工资?
SELECT AVG(sal),job,deptno
FROM emp
GROUP BY job,deptno

当SELECT子句中含有聚合函数时,那么凡
不在聚合函数中的其他单独字段都必须出现
在GROUP BY子句中,反过来则不是必须的.


查看部门的平均工资,前提是该部门的平均
工资高于2000
SELECT AVG(sal),deptno
FROM emp
WHERE AVG(sal)>2000
GROUP BY deptno

WHERE中不能使用聚合函数作为过滤
条件,原因是过滤时机不对.
WHERE是在数据库检索表中数据时,对
数据逐条过滤以决定是否查询出该数据
时使用的,所以WHERE用来确定结果集
的数据.

使用聚合函数的结果作为过滤条件,那么
一定是数据从表中查询完毕(WHERE在查询
过程中发挥作用)得到结果集,并且分组完毕
才进行聚合函数统计结果,得到后才可以对
分组进行过滤,由此可见,这个过滤时机是在
WHERE之后进行的.

聚合函数的过滤条件要在HAVING子句中使用
HAVING必须跟在GROUP BY子句之后.HAVING
是用来过滤分组的.

SELECT AVG(sal),deptno
FROM emp
GROUP BY deptno
HAVING AVG(sal)>2000

查看平均工资高于2000的部门的
最高工资和最低工资分别是多少?
SELECT MAX(sal),MIN(sal),deptno
FROM emp
GROUP BY deptno
HAVING AVG(sal)>2000


关联查询
从多张表中查询对应记录的信息
关联查询的重点在于这些表中的记录
的对应关系,这个关系也称为连接条件

查看每个员工的名字以及其所在部门的名字?
SELECT e.ename,d.dname,e.deptno
FROM emp e,dept d
WHERE e.deptno=d.deptno

当两张表有同名字段时,SELECT子句中
必须明确指定该字段来自哪张表.在关联
查询中,表名也可以添加别名,这样可以简化
SELECT语句的复杂度


关联查询要添加连接条件,否则会产生笛卡尔积
笛卡尔积通常是一个无意义的结果集,它的记录
数是所有参与查询的表的记录数乘积的结果.
要避免出现,数据量大时极易出现内存溢出等现象.
N张表关联查询要有至少N-1个连接条件.
SELECT e.ename,d.dname,e.deptno
FROM emp e,dept d


查看在NEW YORK工作的员工?
SELECT e.ename,d.deptno
FROM emp e,dept d
WHERE e.deptno=d.deptno
AND d.loc='NEW YORK'

查看工资高于3000的员工的名字
工资,部门名以及所在地?
SELECT e.ename,e.sal,
       d.dname,d.loc
FROM emp e,dept d
WHERE e.deptno=d.deptno
AND e.sal>3000

查看SALES部门的员工名字以及部门的名字
SELECT e.ename,d.dname
FROM emp e JOIN dept d
ON e.deptno=d.deptno
WHERE d.dname='SALES'

不满足连接条件的记录是不会在关联
查询中被查询出来的.

外链接
外链接除了会将满足链接条件的记录查询
出来之外,还会将不满足链接条件的记录也
查询出来.
外链接分为:
左外链接:以JOIN左侧表作为驱动表(所有数据都会
        被查询出来),那么当该表中的某条记录不
        满足链接条件时来自右侧表中的字段全部
        填NULL.
右外链接:
全外链接:

SELECT e.ename,d.dname
FROM emp e 
  LEFT|RIGHT|FULL OUTER JOIN 
     dept d
ON e.deptno=d.deptno

SELECT e.ename,d.dname
FROM emp e JOIN dept d
ON e.deptno(+)=d.deptno


自连接
自连接即:当前表的一条记录可以对应
当前表自己的多条记录
自连接是为了解决同类型数据但是又存在
上下级关系的树状结构数据时使用.

查看每个员工以及其领导的名字?
SELECT e.ename,m.ename
FROM emp e,emp m
WHERE e.mgr=m.empno

查看SMITH的上司在哪个城市工作?
SELECT e.ename,m.ename,
       m.deptno,d.loc
FROM emp e,emp m,dept d
WHERE e.mgr=m.empno
AND m.deptno=d.deptno
AND e.ename='SMITH'

SELECT e.ename,m.ename,
       m.deptno,d.loc
FROM emp e JOIN emp m
ON e.mgr=m.empno
JOIN dept d
ON m.deptno=d.deptno
WHERE e.ename='SMITH'




