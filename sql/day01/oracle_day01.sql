SELECT SYSDATE FROM dual

SQL语句本身不区分大小写,但是出于
可读性的目的,我们通常会将SQL中的
关键字全部大写,非关键字全部小写.

DDL 数据定义语言
DDL是对数据库对象进行操作的语言.
数据库对象包括:表,视图,索引,序列

创建表:
CREATE TABLE employee(
	id NUMBER(4),
	name VARCHAR2(20),
	gender CHAR(1),
	birth DATE,
  salary NUMBER(6,2),
  job VARCHAR2(30),
  deptno NUMBER(2)
)

查看表结构
DESC employee

删除表
DROP TABLE employee

数据库中所有数据类型的默认值都是NULL
在创建表的时候可以使用DEFAULT为某个
字段单独指定一个默认值.
数据库中的字符串字面量是使用单引号的
虽然SQL语句本身不区分大小写,但是字符串
的值是区分大小写的!

CREATE TABLE employee(
	id NUMBER(4),
	name VARCHAR2(20) NOT NULL,
	gender CHAR(1) DEFAULT 'M',
	birth DATE,
  salary NUMBER(6,2),
  job VARCHAR2(30),
  deptno NUMBER(2)
)
DESC employee

修改表
1:修改表名
2:修改表结构

修改表名:
RENAME employee TO myemp
DESC myemp

修改表结构
1:添加新的字段
2:修改现有字段
3:删除现有字段

添加新字段
ALTER TABLE myemp
ADD(
  hiredate DATE DEFAULT SYSDATE
)
DESC myemp

删除字段
ALTER TABLE myemp
DROP(hiredate)


修改字段
可以修改字段的类型,长度,默认值,是否非空.
修改表结构都应当避免在表中有数据以后进行.
若表中有数据,修改表中字段时尽量不要修改类
型,若修改长度尽量增大避免缩小,否则可能导致
失败.
ALTER TABLE myemp
MODIFY(
  job VARCHAR2(40) DEFAULT 'CLERK'
)
DESC myemp


DML语句
DML是对表中的数据进行的操作
DML伴随事物控制(TCL)
DML包含操作:
增,删,改.

INSERT语句
向表中插入数据

INSERT INTO myemp
(id,name,salary,deptno)
VALUES
(1,'jack',5000,10)

SELECT * FROM myemp

COMMIT

--使用自定义日期格式插入记录
INSERT INTO myemp 
(id, name, job,birth) 
VALUES
(1003, 'donna', 'MANAGER', 
TO_DATE('2009-09-01','YYYY-MM-DD')
)

UPDATE语句
修改表中数据
修改表中数据要使用WHERE添加过滤
条件,这样才会只将满足条件的记录
进行修改,否则是全表所有数据都修改
UPDATE myemp
SET salary=7000,gender='F',
    name='rose'
WHERE id=1

DELETE语句
删除表中数据,删除数据通常也要添加
WHERE语句来限定要删除数据的条件
否则就是清空表操作!
DELETE FROM myemp
WHERE name='rose'











