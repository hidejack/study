视图
视图是数据库对象之一
所有数据库对象名字不能重复,所以
视图名字一般是以"v_"开头

视图在SQL语句中体现的角色与表相同
但是视图并不是一张真实存在的表,而
只是对应一个SELECT语句的查询结果集,
并将其当做表看待而已.
使用视图的目的是简化SQL语句的复杂度,
重用子查询,限制数据访问.

创建视图
该视图包含的数据为10号部门的员工信息
CREATE VIEW v_emp_10
AS
SELECT empno,ename,sal,deptno
FROM emp
WHERE deptno=10

查看视图数据:
SELECT * FROM v_emp_10

视图对应的子查询中的字段若含有函数
或者表达式,那么该字段必须指定别名.
当视图对应的子查询中的字段使用了别名,
那么视图中该字段就用别名来命名.

修改视图
由于视图仅对应一个SELECT语句,所以修改
视图就是替换该SELECT语句而已.

CREATE OR REPLACE VIEW v_emp_10
AS
SELECT empno id,ename name,
       sal salary,deptno
FROM emp
WHERE deptno=10

SELECT * FROM v_emp_10
DESC v_emp_10


视图分为简单视图与复杂视图
简单视图:对应的子查询中不含有
关联查询,查询的字段不包含函数,
表达式等,没有分组,没有去重.
反之则是复杂视图.

对视图进行DML操作
仅能对简单视图进行DML操作.
对视图进行DML操作就是对视图数据来源
的基础表进行的操作.

INSERT INTO v_emp_10
(id,name,salary,deptno)
VALUES
(1001,'JACK',2000,10)

SELECT * FROM v_emp_10
SELECT * FROM emp

对视图的DML操作就是对基表操作,那么
操作不当可能对基表进行数据污染
INSERT INTO v_emp_10
(id,name,salary,deptno)
VALUES
(1002,'ROSE',3000,20)

视图对ROSE不可见
SELECT * FROM v_emp_10
SELECT * FROM emp

更新同样存在更新后对数据不可控
的情况
UPDATE v_emp_10
SET deptno=20

删除不会对基表产生数据污染
DELETE FROM v_emp_10
WHERE deptno=20

为视图添加检查选项,可以保证对视图
的DML操作后视图对其可见,否则不允许
进行该DML操作,这样就避免了对基表
进行数据污染.
CREATE OR REPLACE VIEW v_emp_10
AS
SELECT empno id,ename name,
       sal salary,deptno
FROM emp
WHERE deptno=10
WITH CHECK OPTION


为视图添加只读选项,那么该视图
不允许进行DML操作.
CREATE OR REPLACE VIEW v_emp_10
AS
SELECT empno id,ename name,
       sal salary,deptno
FROM emp
WHERE deptno=10
WITH READ ONLY


SELECT object_name 
FROM user_objects 
WHERE object_type = 'VIEW'
AND object_name LIKE '%_fanchuanqi'

SELECT TEXT,view_name 
FROM user_views

SELECT table_name
FROM user_tables

复杂视图
创建一个含有公司部门工资情况的视图,
内容为:部门编号,部门名称,部门的最高,
最低,平均,以及工资总和信息.

CREATE VIEW v_dept_sal
AS
SELECT d.deptno,d.dname,
       MIN(e.sal) min_sal,
       MAX(e.sal) max_sal,
       AVG(e.sal) avg_sal,
       SUM(e.sal) sum_sal
FROM emp e,dept d
WHERE e.deptno=d.deptno
GROUP BY d.deptno,d.dname


SELECT * FROM v_dept_sal

查看谁比自己所在部门平均工资高?
SELECT e.ename,e.sal,e.deptno
FROM emp e,v_dept_sal v
WHERE e.deptno=v.deptno
AND e.sal>v.avg_sal


删除视图
DROP VIEW v_emp_10

删除视图本身并不会影响基表数据.
但是删除视图数据会对应将基表数据删除.


序列
序列也是数据库对象之一.
作用是生成一系列数字.
序列常用与为某张表的主键字段提供值使用.
CREATE SEQUENCE seq_emp_id
START WITH 1
INCREMENT BY 1

序列支持两个伪列:
NEXTVAL:获取序列下一个值
若是新创建的序列,那么第一次调用返回的是
START WITH指定的值,以后每次调用都会得到
当前序列值加上步长后的数字.
NEXTVAL会导致序列发生步进,且序列不能回退.

CURRVAL:获取序列当前值,即:最后一次调用
NEXTVAL后得到的值,CURRVAL不会导致步进.
但是新创建的序列至少调用一次NEXTVAL后才可
以使用CURRVAL.

SELECT seq_emp_id.CURRVAL
FROM dual

使用序列为EMP表中信插入的数据提供
主键字段的值
INSERT INTO emp
(empno,ename,sal,job,deptno)
VALUES
(seq_emp_id.NEXTVAL,'JACK',
 3000,'CLERK',10)


SELECT * FROM emp


删除序列
DROP SEQUENCE seq_emp_id

索引
索引是数据库对象之一
索引是为了提高查询效率

索引的统计与应用是数据库自动完成的
只要数据库认为可以使用某个已创建的
索引时就会自动应用.



约束

唯一性约束
唯一性约束可以保证表中该字段的值
任何一条记录都不可以重复,NULL除外.
CREATE TABLE employees1 (
  eid NUMBER(6) UNIQUE,
  name VARCHAR2(30),
  email VARCHAR2(50),
  salary NUMBER(7, 2),
  hiredate DATE,
  CONSTRAINT employees_email_uk UNIQUE(email)
)

INSERT INTO employees1
(eid,name,email)
VALUES
(NULL,'JACK',NULL)

SELECT * FROM employees1

DELETE FROM employees1
WHERE name='JACK'



CREATE TABLE employees2 (
eid NUMBER(6) PRIMARY KEY,
name VARCHAR2(30),
email VARCHAR2(50),
salary NUMBER(7, 2),
hiredate DATE
);

INSERT INTO employees2
(eid,name)
VALUES
(2,'JACK')





