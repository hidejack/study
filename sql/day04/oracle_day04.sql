子查询
子查询是一条SELECT语句,但它是嵌套在
其他SQL语句中的,为的是给该SQL提供数据
以支持其执行操作.

查看谁的工资高于CLARK?
SELECT ename,sal
FROM emp
WHERE sal>(SELECT sal FROM emp
           WHERE ename='CLARK')

查看与CLARK同职位的员工?
SELECT ename,job FROM emp
WHERE job=(SELECT job FROM emp
           WHERE ename='CLARK')


查看与CLARK同部门的员工?
SELECT ename,deptno FROM emp
WHERE deptno=(SELECT deptno FROM emp
              WHERE ename='CLARK')


在DDL中使用子查询
可以根据子查询的结果集快速创建一张表

创建表employee,表中字段为:
empno,ename,job,sal,deptno,dname,loc
数据为现有表中emp与dept对应的数据
CREATE TABLE employee
AS
SELECT e.empno,e.ename,e.job,e.sal,
       e.deptno,d.dname,d.loc
FROM emp e,dept d
WHERE e.deptno=d.deptno(+)

DESC employee
SELECT * FROM employee

DROP TABLE employee

创建表时若子查询中的字段有别名则该表
对应的字段就使用该别名作为其字段名,
当子查询中一个字段含有函数或表达式,那么
该字段必须给别名.
CREATE TABLE employee
AS
SELECT e.empno id,e.ename name,
       e.job,e.sal*12 salary,
       e.deptno,d.dname,d.loc
FROM emp e,dept d
WHERE e.deptno=d.deptno(+)

SELECT name,salary
FROM employee

DML中使用子查询
将CLARK所在部门的所有员工删除
DELETE FROM employee
WHERE deptno=(SELECT deptno 
              FROM employee
              WHERE name='CLARK')


SELECT * FROM employee

子查询常用于SELECT语句中.
子查询根据查询结果集的不同分为:
单行单列子查询:常用于过滤条件,可以配合
             =,>,>=,<,<=使用
多行单列子查询:常用于过滤条件,由于查询出
             多个值,在判断=时要用IN,
             判断>,>=等操作要配合ANY,ALL
多行多列子查询:常当做一张表看待.

查询与SALESMAN同部门的其他职位员工：
SELECT ename,job,deptno
FROM emp
WHERE deptno IN (SELECT deptno 
                 FROM emp
                 WHERE job='SALESMAN')
AND job<>'SALESMAN'

查看比职位是CLERK和SALESMAN工资都高的员工?
SELECT ename,sal
FROM emp
WHERE sal> ALL(SELECT sal FROM emp
               WHERE job IN('CLERK','SALESMAN')
               )

EXISTS关键字
EXISTS后面跟一个子查询,当该子查询可以查询
出至少一条记录时,则EXISTS表达式成立并返回
true

SELECT deptno, dname FROM dept d
WHERE 
 NOT EXISTS(SELECT * FROM emp e
            WHERE d.deptno = e.deptno)


查看每个部门的最低薪水是多少?前提是该部门
的最低薪水要高于30号部门的最低薪水
SELECT MIN(sal),deptno
FROM emp
GROUP BY deptno
HAVING MIN(sal)>(SELECT MIN(sal)
                 FROM emp
                 WHERE deptno=30)


子查询在FROM子句中的使用
当一个子查询是多列子查询,通常将该子查询
的结果集当做一张表看待并基于它进行二次
查询.

查看比自己所在部门平均工资高的员工?

1:查看每个部门平均工资
SELECT AVG(sal),deptno
FROM emp
GROUP BY deptno

SELECT e.ename,e.sal,e.deptno
FROM emp e,(SELECT AVG(sal) avg_sal,
                   deptno
            FROM emp
            GROUP BY deptno) t
WHERE e.deptno=t.deptno
AND e.sal>t.avg_sal

在SELECT子句中使用子查询,可以将查询的结果
当做外层查询记录中的一个字段值显示
SELECT e.ename, e.sal, 
      (SELECT d.dname FROM dept d 
       WHERE d.deptno = e.deptno) deptno
FROM emp e

分页查询
分页查询是将查询表中数据时分段查询,而不
是一次性将所有数据查询出来.
有时查询的数据量非常庞大,这回导致系统资源
消耗大,响应速度长,数据冗余严重.
为此当遇到这种情况时一般使用分页查询解决.
数据库基本都支持分页,但是不同数据库语法不
同(方言).

ORACLE中的分页是基于伪列ROWNUM实现的.

ROWNUM不存在与任何一张表中,但是所有的表
都可以查询该字段.该字段的值是随着查询自动
生成的,方式是:每当可以从表中查询出一条记
录时,该字段得值即为该条记录的行号,从1开始,
逐次递增.

SELECT ROWNUM,empno,ename,sal,job
FROM emp
WHERE ROWNUM > 1

在使用ROWNUM对结果集进行编号的查询过程
中不能使用ROWNUM做>1以上的数字判断,否则
将查询不出任何数据.
SELECT *
FROM(SELECT ROWNUM rn,empno,
            ename,sal,job
     FROM emp)
WHERE rn BETWEEN 6 AND 10

查看公司工资排名的6-10
SELECT *
FROM(SELECT ROWNUM rn,t.*
     FROM(SELECT empno,ename,sal
          FROM emp
          ORDER BY sal DESC) t)
WHERE rn BETWEEN 6 AND 10

SELECT *
FROM(SELECT ROWNUM rn,t.*
     FROM(SELECT empno,ename,sal
          FROM emp
          ORDER BY sal DESC) t
     WHERE ROWNUM <=10)
WHERE rn>=6

计算区间公式
pageSize:每页显示的条目数
page:页数

star:(page-1)*pageSize+1
end:pageSize*page

int start = (page-1)*pageSize+1;
int end = pageSize*page;

String sql = "SELECT * " +
             "FROM(SELECT ROWNUM rn,t.* " +
             "     FROM(SELECT empno,ename,sal" +
             "          FROM emp " +
             "          ORDER BY sal DESC) t " +
             "     WHERE ROWNUM <="+end+") " +
             "WHERE rn>="+start;


DECODE函数,可以实现分之效果的函数
SELECT ename, job, sal,
     DECODE(job,  
            'MANAGER', sal * 1.2,
            'ANALYST', sal * 1.1,
            'SALESMAN', sal * 1.05,
            sal
     ) bonus
FROM emp


DECODE在GROUP BY分组中的应用可以
将字段值不同的记录看做一组.

统计人数,将职位是"MANAGER","ANALYST"
看作一组,其余职业看作另一组分别统计人数.

SELECT 
 COUNT(*),DECODE(job,
           'MANAGER','VIP',
           'ANALYST','VIP',
           'OTHER')
FROM emp
GROUP BY DECODE(job,
        'MANAGER','VIP',
        'ANALYST','VIP',
        'OTHER')


SELECT deptno, dname, loc     
FROM dept
ORDER BY 
 DECODE(dname,
 'OPERATIONS',1,
 'ACCOUNTING',2,
 'SALES',3)
     

排序函数
排序函数允许对结果集按照指定的字段分组
在组内再按照指定的字段排序,最终生成组内
编号.

ROW_NUMBER()函数生成组内连续且唯一的数字:
查看每个部门的工资排名?
SELECT 
 ename,sal,deptno,
 ROW_NUMBER() OVER(
  PARTITION BY deptno
  ORDER BY sal DESC
 ) rank
FROM emp


RANK函数,生成组内不连续也不唯一的数字,
同组内排序字段值一样的记录,生成的数字
也一样.
SELECT 
 ename,sal,deptno,
 RANK() OVER(
  PARTITION BY deptno
  ORDER BY sal DESC
 ) rank
FROM emp

DENSE_RANK函数生成组内连续但不唯一
的数字.
SELECT 
 ename,sal,deptno,
 DENSE_RANK() OVER(
  PARTITION BY deptno
  ORDER BY sal DESC
 ) rank
FROM emp



SELECT year_id,month_id,day_id,sales_value
FROM sales_tab
ORDER BY year_id,month_id,day_id

查看每天营业额?
SELECT year_id,month_id,day_id,
       SUM(sales_value)
FROM sales_tab
GROUP BY year_id,month_id,day_id
ORDER BY year_id,month_id,day_id


每月营业额?
SELECT year_id,month_id,
       SUM(sales_value)
FROM sales_tab
GROUP BY year_id,month_id
ORDER BY year_id,month_id

每年营业额?
SELECT year_id,
       SUM(sales_value)
FROM sales_tab
GROUP BY year_id
ORDER BY year_id

总共营业额?
SELECT SUM(sales_value)
FROM sales_tab


SELECT year_id,month_id,day_id,
       SUM(sales_value)
FROM sales_tab
GROUP BY year_id,month_id,day_id
UNION ALL
SELECT year_id,month_id,null,
       SUM(sales_value)
FROM sales_tab
GROUP BY year_id,month_id
UNION ALL
SELECT year_id,null,null,
       SUM(sales_value)
FROM sales_tab
GROUP BY year_id
UNION ALL
SELECT null,null,null,
       SUM(sales_value)
FROM sales_tab

高级分组函数
高级分组函数用在GROUP BY子句中,每个高级
分组函数都有一套分组策略.

ROLLUP():分组原则,参数逐次递减,一直到所有
         参数都不要,每一种分组都统计一次结果
         并且并在一个结果集显示.

GROUP BY ROLLUP(a,b,c)
等价于:
GROUP BY a,b,c
UNION ALL
GROUP BY a,b
UNION ALL
GROUP BY a
UNION ALL
全表

查看每天,每月,每年以及总共的营业额?
SELECT year_id,month_id,day_id,
       SUM(sales_value)
FROM sales_tab
GROUP BY 
 ROLLUP(year_id,month_id,day_id)


CUBE():每种组合分一次组
分组次数:2的参数个数次方

GROUP BY CUBE(a,b,c)
abc
ab
bc
ac
a
b
c
全表

SELECT year_id,month_id,day_id,
       SUM(sales_value)
FROM sales_tab
GROUP BY 
 CUBE(year_id,month_id,day_id)
ORDER BY  year_id,month_id,day_id
 
 

GROUPING SETS:每个参数是一种分组方式,
然后将这些分组统计后并在一个结果集显示.

仅查看每天与每月营业额?
SELECT year_id,month_id,day_id,
       SUM(sales_value)
FROM sales_tab
GROUP BY 
 GROUPING SETS(
  (year_id,month_id,day_id),
  (year_id,month_id)
 )

 


