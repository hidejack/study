--一、数据库相关名词
--1.SQL ：结构化查询语言
1）DDL：数据定义语言。用于建立、修改、删除数据库对象
CREATE：创建表或其他对象结构
ALTER： 修改表或其他对象结构
DROP ： 删除表或其他对象结构
TRUNCATE：删除表数据，保留表结构(truncate table emp_duke)

2)DML:用于改变数据表中的数据，和事务相关，经提交才真正改变
INSERT ：将数据插入表中
UPDATE ：更新数据表中已存在的数据
DELETE ：删除数据表中的数据

3）TCL：用来维护数据一致性的语句
COMMIT ：提交==F11
ROLLBACK： 回滚==F12
SAVEPOINT：保存点，可以回退到指定的保存点

4）DQL：查询所需数据
SELECT 语句

5）DCL ：执行权限的授予和回收操作
GRANT  ：  授予。授予权限
REVOKE ：  收回权限
CREATE USER：创建用户

--2.其他
DEFAULT ： 指定数据默认值
NOT NULL： 不允许数据为 NULL
SELECT  ： 查询表中数据
FROM    ： 指数据来源
WHERE   ： 过滤条件
DUAL    ： 伪表

--二、数据库类型（ORACLE）
--1.NUMBER：数字类型
  NUMBER（P，S） P：整数位个数  S：小数位个数（不含小数点）

--2.CHAR ：固定长度字符类型
  CHAR（N）     N表示字节长度，最大为2000
  特点：固长，查找快，但占用空间较浪费
  
--3.VARCHAR2：变长的字符类型
  VARCHAR2（N）  N表示最多可占用的字节长度，最大为4000
  特点：变长，节省空间。但查找不方便
  
--4.DATE ：定义日期的数据类型
格式：DD-MON-RR  OR DD-MON-YY 长度为7个字节

--三、DDL操作----对表的结构的操作
--1.创建表
  CREATE TABLE + 表名 +（定义字段）

--2.查看表结构
  DESC + 表名
  
--3.删除表
  DROP TABLE +表名
  
--4.修改表名
  RENAME + 表名 +TO + 新表名
  
--5.修改表结构
  1）添加新字段------->增
  ALTER TABLE +表名 + ADD +（字段）
  2）删除字段------> 删
  ALTER TABLE +表名 + DROP +（字段） 
  3）修改字段------> 改
  ALTER TABLE +表名 + MODIFY +（字段内容）
  
--四、DML操作---对表的数据内容操作
--1.插入数据
  INSERT INTO +TABLENAME +（字段）+VALUES+（对应添加的值）
  注：字段顺序和赋值的顺序要一致，前后顺序一致
  
--2.查看数据
  SELECT + 字段 + FROM + 表名
  
--3.修改数据
  UPDATE + 表名 + SET + 修改字段信息 + WHERE + 条件
  
--4.删除数据
  DELETE FROM + 表名 + WHERE + 条件
  
--五、函数
--1.字符串函数
1） CONCAT（） ：用来连接字符串
 CONCAT（A，B，C）<--------------> A || B || C

2) LENGTH（） ：字符串长度
  LENGTH（NAME） 得到 NAME 字符串的长度
  
3） UPPER（A）：将字符串 A 全部转为大写
    LOWER（A）：将字符串 A 全部转为小写
    INITCAP（A）：将字符串 A 首字母转为大写

4）TRIM （A FROM B）：去除字符串B中含有A字符串的内容 --首尾去除
  注：只能去除连续的，且 A 必须为单个字符 即长度为 1
  LTRIM （A，B）：将B从 A 的左侧开始去除 
  RTRIM （A，B）：将B从 A 的右侧开始去除
  注：LTRIM 和 RTRIM 中参数 B 长度不限，但只能去除连续内容
  
5）LPAD(A,NUM,B) ：将字符串A保留 NUM 位，剩余长度的用字符串B左补齐---效果为右对齐
   RPAD(A,NUM,B) ：将字符串A保留 NUM 位，剩余长度的用字符串B右补齐---效果为左对齐
   
6）SUBSTR（A，3，2）：字符串A从第 3 位开始，截取 2 位
  注：1.若不指定第三个参数则默认截取到末尾
     2.若第三个参数超过字符串长度，则默认截取到末尾
     3.若第二个参数为负数，则表示从末尾起 第二个参数值 位 开始截取
     4.字符串中下标默认从1开始，与JAVA不同
     
7）INSTR（CHAR1，CHAR2，N，M）:查找 CHAR2在 CHAR1中的位置，从第N个字符开始检索，M为第几次出现
   注：若N，M不写则默认都是1
   
--2.数字函数
1）ROUND（N，M）：四舍五入，保留N后M位

2）TRUNC（N，M）：截取数字，截取到N后M位

3）MOD（N，M）：取余，取N/M的余数
  注：M可为0，若M为0，则返回N
  
4) CEIL (N):向上取整
  FLOOR（N）：向下取整
  
--3.日期中的函数
1）SYSDATE ：当前系统时间   DATE 类型
   SYSTIMESTAMP：当前系统时间，时间戳类型的值

2）TO_DATE:将字符串解析为 DATE 型值
例：
Select
  TO_DATE('2008-08-08 20:08:08','YYYY-MM-DD HH24:MI:SS')
From Dual

3)TO_CHAR() :将DATE按照给定的格式转为字符串
例：
Select 
  TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS')
FROM DUAL

4)LAST_DAY() :返回给定日期所在月的月底日期
例：
SELECT LAST_DAY(SYSDATE)
FROM DUAL

5)ADD_MONTHS(DATE,I):对给定日期加上指定的月，若I为负数则是减去

6)MONTHS_BETWEEN(DATE1,DATE2):计算两个日期之间相差的月，计算是根据DATE1-DATE2得到的

7)Next_Day(Date,I):返回给定日期的第二天开始一周之内的指定周几的日期
    I：1表示周日，2表示周一，依次类推
    
8)LEAST() :求最小值
  GREATEST():求最大值
 注：除了日期外，常用的数字也可以比较大小
    参数内可传多个值
例：
SELECT
  Least(1,2,3,4)
FROM DUAL

9）Extract():提取给定日期中指定时间分量的值
例：
SELECT EXTRACT(YEAR FROM SYSDATE)
From Dual

--4.NULL值运算操作
注：1.NULL与任何数字运算，结果都为NULL
   2.NULL与字符串拼接，等于什么也没干
   3.判断字段的值是否为NULL:判断要使用 IS NULL 或 IS NOT NULL

1)NVL(ARG1,ARG2):空值函数
注：当ARG1为NULL，函数返回ARG2的值。若不为NULL，则返回ARG1本身
作用：将NULL值替换为一个非NULL的值
 
2) NVL2(ARG1,ARG2,ARG3):空值函数
注：当ARG1不为NULL，则函数返回ARG2。当ARG1为NULL，则函数返回ARG3
   该函数是根据一个值是否为NULL来返回两个不同结果
作用：将NULL值替换为一个非NULL的值

--注意：
1.日期可以进行计算，差值为天数
2.YY 和 RR 的区别:
  YY 均为本世纪年份。 
  RR 根据当前年份进行计算。当前年份为0-49，若日期为0-49则为本世纪，50-99为上世纪
                       当前年份为50-99，则0-49为下世纪，50-99为本世纪
    相同区段即为本世纪，不同区段，50-99为下世纪，0-49为上世纪

--六、DQL语句中的相关语法
--注意：
1.别名：可用函数表达式，但不区分大小写，若用“”括起来，则区分大小写
2.AND 优先级高于 OR 可以通过括号提高 OR 的优先级
3.<> 等价 !=

--1.判断：
1）LikE ：用于模糊匹配字符串。支持两个通配符：
    _：单一的一个字符
    %：任意个字符
例：
Select Ename,Sal,Job From Emp_Duke Where Ename Like '_A%N'

2)IN 和 NOT IN:判断是否在列表中或不再列表中
例：
SELECT ENAME,JOB,DEPTNO FROM EMP_DUKE WHERE DEPTNO NOT IN(10,20);
注：IN 和 NOT IN常用来判断子查询的结果

3)BETWEEN...AND...:判断是否在一个区间范围内

4)ANY,ALL
Any 和 all 是配合>,>=,<,<=一个列表使用的
>Any(List):大于列表中最小的
>All(List):大于列表中最大的
<Any(List):小于列表中最大的
<ALL(LIST):小于列表中最小的
注：1.ANY和ALL常用于子查询
   2.常使用函数或者表达式作为过滤条件

注：以上均可作为过滤条件，在 WHERE 之后进行判断

--2.去重 
  DISTINCT: 关键字,对结果集中指定字段值重复的记录进行去重
例：
Select Distinct Job,Deptno From Emp_Duke
注：多字段去重时，是对这些字段值的组合进行去重
    常跟SELECT 语句后使用

--3.排序
  ORDER BY ：可以根据其后指定的字段对结果集按照该字段的值进行升序或者降序排列
  ASC：升序，不写默认就是升序
  DESC：降序
例：
Select Ename,Deptno,Sal From Emp_Duke Order By Sal,Deptno Desc
注：ORDER BY
  1.进行多段排序时： 首先按照第一个字段的排序方式对结果集进行排序
                  当第一个字段有重复值时才会按照第二个字段排序方式进行排序，以此类推
  2.每个字段都可以单独指定排序方式
  3.排序的字段中含有NULL值，NULL被默认为最大值
  
--4.聚合函数(多行函数、分组函数)
定义：对结果集某些字段的值进行统计

1)MAX MIN :求给定字段的最大值和最小值
例：
select max(sal) ,min(sal) from emp_duke 

2)AVG SUM:求平均值和 和值
例：
Select Round(Avg(Sal),5),Sum(Sal) From Emp_Duke

3）Count ：对给定字段不为NULL的记录数进行统计
注：实际上所有聚合函数都忽略NULL值统计
例：
SELECT COUNT(COMM) FROM EMP_DUKE where id=001

4)HAVING :用来过滤分组
注：1.聚合函数的过滤条件要在 HAVING 子句中使用
   2.having 必须跟在 group by 子句之后
例：
SELECT AVG(SAL),DEPTNO FROM EMP_DUKE
GROUP BY DEPTNO HAVING AVG(SAL)>2000
--注意：
WHERE 中不能使用聚合函数作为过滤条件，执行顺序不对。

--5.分组
group by : 将结果集按照其后指定的字段值相同的记录看做一组，然后配合聚合函数进行更细分的统计工作
例：
SELECT ROUND(AVG(SAL),2),DEPTNO FROM EMP_DUKE GROUP BY DEPTNO ORDER BY DEPTNO
注：1.GROUP BY 根据多个字段分组时：
    分组原则为这几个字段值都相同的记录看做一组
   2.当 SELECT 子句中含有聚合函数时，那么凡不再聚合函数中的其他
      单独字段都必须出现在GROUP BY子句中，反过来则不是必须的
      
--七、关联查询
 定义：从多张表中查询对应记录的信息
 重点：连接条件
 连接条件：表与表之间的对应关系
例：
SELECT ENAME,DNAME ,E.DEPTNO FROM EMP_DUKE E,DEPT_DUKE D 
WHERE E.DEPTNO=D.DEPTNO  ORDER BY D.DEPTNO
注：1.上例中连接条件为：E.DEPTNO=D.DEPTNO
   2.两张表有同名字段时，SELECT 子句中必须明确指定该字段来自哪张表
   3.在关联查询中，表名可以添加别名，简化SELECT语句的复杂度
   4.关联查询一定要添加连接条件，否则会产生笛卡尔积
   5.N 张表关联查询要有至少N-1个连接条件

--1.内连接：用来完成关联查询的,只能将满足条件的查询出来
例：
第一种
SELECT E.ENAME,D.DNAME FROM EMP_DUKE E JOIN DEPT_DUKE D
On E.Deptno=D.Deptno Where D.Dname='SALES'

第二种
SELECT E.ENAME,D.DNAME FROM EMP_DUKE E,DEPT_DUKE D
WHERE E.DEPTNO=D.DEPTNO AND D.DNAME='SALES'
注：1.不满足连接条件的记录是不会在关联查询中被查询出来的
   2.JOIN ON : ON 后跟连接条件
   
--2.外连接:外链接除了会将满足链接条件的记录查询出来之外,还会将不满足链接条件的记录也查询出来
外链接分为：
左外链接：以 JOIN 左侧表作为驱动表（所有数据都会被查询出来）
        那么当该表中的某条记录满足链接条件时，来自右侧表中的字段
        全部填 NULL
右外连接：以 JOIN 右侧表作为驱动表（所有数据都会被查询出来）
        那么当该表中的某条记录满足链接条件时，来自左侧表中的字段
        全部填null
全外链接：以 JOIN 两侧表作为驱动表（所有数据都会被查询出来）
        那么当该表中的某条记录不满足链接条件时，则两侧字段
        全部填NULL
例：
Select E.Ename,D.Dname 
From Emp_Duke E Left Outer Join Dept_Duke D
On E.Deptno=D.Deptno

Select E.Ename,D.Dname
From Emp_Duke E Right Outer Join Dept_Duke D
On E.Deptno=D.Deptno

Select E.Ename,D.Dname
From Emp_Duke E Full Outer Join Dept_Duke D
On E.Deptno=D.Deptno

--(+)的左，右外链接，全外链接不能实现
Select E.Ename,D.Dname
From Emp_Duke E Join Dept_Duke D
On E.Deptno=D.Deptno(+)
--哪边放加号哪边补null
Select E.Ename,D.Dname
FROM EMP_DUKE E JOIN DEPT_DUKE D
On E.Deptno(+)=D.Deptno

--3.自链接：当前表的一条记录可以对应当前表自己的多条记录
  作用：解决同类型数据但是又存在上下级关系的树状结构数据时使用
例：
SELECT E.ENAME,M.ENAME,D.DEPTNO,D.LOC FROM EMP_DUKE E 
Join Emp_Duke M On E.Mgr=M.Empno Join Dept_Duke D
ON M.DEPTNO=D.DEPTNO WHERE E.ENAME='SMITH'

--八、子查询 
  定义：嵌套在sql语句中的一条select语句
  作用：给该sql提供数据以支持其执行操作
例：
Select Ename,sal From Emp_Duke 
Where Sal>(Select Sal From Emp_Duke 
Where Ename='CLARK')

1）在ddl语句中使用子查询
  作用：可以根据子查询的结果快速创建一张表
例：
CREATE TABLE employee001 
AS
SELECT e.ename,e.sal,e.empno,e.deptno,d.dname,d.loc
FROM emp_duke e,dept_duke d
WHERE e.deptno=d.deptno(+);
注：当子查询中一个字段含有函数或表达式，那么该字段必须给别名

2）在dml中使用子查询
子查询根据查询结果集的不同分为：
单行单列子查询：常用于过滤条件，可以配合
             =，>,>=,<,<=使用
多行单列子查询：常用于过滤条件，由于查询出多个值，在判断
             =时要用 IN 判断>,>=等操作要配合 ANY ，ALL
多行多列子查询：常当作一张表看待
2.1）子查询当过滤条件时的使用：
    何时用：当查询结果为单行单列或多行单列时，常用于过滤条件
例：
SELECT ename,JOB,deptno FROM emp_duke
where deptno in(
SELECT deptno FROM emp_duke WHERE JOB='SALESMAN'
) and job<>'SALESMAN'

2.2）子查询在from语句中的使用
   何时用：当一个子查询是多列子查询，通常将该子查询的结果集当作一张表看待并基于它进行二次查询
SELECT e.ename,e.sal,e.deptno 
FROM emp_duke e,(
                 SELECT avg(sal) avg_sal,deptno 
                 FROM emp_duke 
                 GROUP BY deptno
                 ) t
where t.deptno=e.deptno
AND e.sal>t.avg_sal

2.3）子查询在select语句中的使用
    何时用：当需要查询子查询的结果集时，可将子查询的结果当作外层查询记录中的一个字段值显示
例如：
Select E.Ename,E.Sal,
       (Select D.Dname From Dept_Duke D
        Where D.Deptno=E.Deptno) Deptno
From Emp_Duke E

3）EXISTS 关键字
  作用：用做判断条件，后跟一个子查询，当该子查询可以查询出至少一条
       记录时，则 EXISTS 表达式成立并返回true
例：
SELECT deptno,dname FROM dept_duke d
WHERE not EXISTS(
            SELECT * FROM emp_duke e
            WHERE e.deptno =d.deptno
            )

--九、分页查询
定义：将查询表中数据时分段查询，而不是一次性将所有数据查询出来
何时用：查询的数据量非常庞大，系统资源消耗大，响应速度长，数据冗余严重时一般使用分页查询解决
注：1、数据库基本都支持分页，但是不同数据库语法不同（方言）
   2、Oracle 中的分页是基于伪列 Rownum 实现的
--1.rownum
伪列：不存在与任何一张表中，但是所有的表都可以查询该字段
注：1.该字段的值是随着查询自动生成的
   2.生成方式：每当可以从表中查询出一条记录时，该字段的值即为该条记录的行号，从1开始，逐次递增
   3.查询过程中使用 ROWNUM 做>1以上的数字判断，将查询不出任何数据
   4.用于过滤条件查询时，可用别名
例：
Select Empno,Ename,Sal,Job From Emp_Duke Where Rownum<6
select empno,ename,sal,job from emp_duke where rownum between 6 and 10
Select *  from (
      select rownum rn,t.* From(
          Select Ename,Empno,Job,Sal  From Emp_Duke Order By Sal Desc)T
      Where rownum<=10)
where rn>=6

--2.计算区间公式
Pagesize:每页显示的条目数
page：页数
Star：（page-1） * Pagesize+1
end：pagesize*page

--十、decode函数和排序函数
--1.Decode 函数
作用：可以实现分支效果
表达式：Decode(char1,char2,a,char3,b，char4，c，d）
判断char1与char2，char3，char4是否相等，若相等则取对应的a，b，c值，都不相等则取d
注：d可不写，若不写则默认返回null
1）select中使用decode：
例：
Select Ename,Job,Sal,Decode(Job,'MANAGER',Sal*1.2,
                                'ANALYST',Sal*1.1,
                                'SALESMAN',Sal*1.05,
                                Sal) Bonus
From Emp_Duke Order By Sal

Select Ename,Job,Sal,Case Job When 'MANAGER' Then Sal*1.2
                              When 'ANALYST' Then Sal*1.1
                              When 'SALESMAN'Then Sal*1.05
                              Else Sal End  Bonus
From Emp_Duke Order By Bonus Desc

2）group by中使用decode
注：DECODE 在 group by 分组中的应用可以将字段值不同的记录看作一组
例：
Select Count(*) ,Decode(Job,
                        'MANAGER','VIP',
                        'ANALYST','VIP',
                        'OTHER') Bonus
From Emp_Duke Group By Decode(Job,
                        'MANAGER','VIP',
                        'ANALYST','VIP',
                        'OTHER')

SELECT COUNT(*),CASE JOB When 'MANAGER' Then 'VIP'
                              When 'ANALYST' Then 'VIP'
                              Else 'OTHER' End  Bonus
From Emp_Duke Group By Case Job When 'MANAGER' Then 'VIP'
                              When 'ANALYST' Then 'VIP'
                              Else 'OTHER' End 

3）order by 中使用decode
例：
Select Deptno,Dname,Loc From Dept_Duke Order By 
Decode(Dname,'OPERATIONS',1,'ACCOUTING',2,'SALES',3)

--2.排序函数
作用：对结果集按照指定的字段分组，在组内再按照指定的字段排序，最终生成组内编号
1）ROW_NUMBER()
作用：生成组内连续且唯一的数字
例：
Select Ename,Sal,Deptno,
       Row_number() Over(
        Partition By Deptno
        Order By Sal Desc) rank
From Emp_Duke

2）Rank（）
作用：生成组内不连续也不唯一的数字
注：同组内排序字段值一样的记录，生成的数字也一样
例：
Select Ename,Sal,Deptno,
       Rank() Over(
       Partition By Deptno
       Order By Sal Desc) R
From Emp_Duke

3）Dense_Rank（）
作用：生成组内连续但不唯一的数字
例：
Select Ename,Sal,Deptno,
       Dense_Rank() Over(
       Partition By Deptno
       Order By Sal Desc)D
From Emp_Duke

注：
Partition By 按什么分组
Order By 按什么排序

--十一、高级分组函数
高级分组函数用于group by 子句中，且每个高级分组函数都有一套分组策略
--1.数据库中的几种集合
1）union：并集  取二者之和，但不重复
2）union all：并集  取取二者之和，重复
3）intersect：交集  取共有部分，其余不要
4）minus：差集 保留我有你木有的部分

--2.rollup（）
分组原则：参数逐次递减，一直到所有参数都不要，每一种分组都统计一次结果，并且并在一个结果集显示
分组次数：参数加1
Group By Rollup(A,B,C)
等价于：
Group By A,B,C
Union All
Group By A,B
Union All
Group By A
Union All

--3.cube（）
分组原则：每种组合分一次组
分组次数：2的参数个数次方

--4.grouping sets（）
分组原则：每个参数是一种分组方式
分组次数：参数个数

--十二、视图、序列、索引、约束
--1.视图
定义：同表相同，但不是一张真实存在的表，而只是对应一个select语句的查询结果集
作用：简化SQL语句的复杂度，重用子查询，限制数据访问
视图分为：简单视图，复杂视图
简单视图：对应的子查询中不含有关联查询，查询的字段不包含函数表达式等，没有分组，没有去重，反之则是复杂视图
注：1.名字一般以‘v’开头
   2.视图对应的子查询中的字段若含有函数，或者表达式那么该字段必须指定别名，
     当视图对应的子查询中的字段使用了别名，那么视图中该字段就用别名来命名

1）创建视图
例：
Create View V_Emp_Duke
As
Select Empno,Ename,Sal,Deptno
From Emp_duke
where deptno=10

2）修改视图
例：
Create Or Replace View V_Emp_Duke
As
select Empno id,Ename name,Sal salary,Deptno
From Emp_Duke
where deptno=10

3）视图的dml操作
数据污染：对数据的操作产生了不可控的情况（此处的含义）
注：1.仅能对简单视图进行dml操作
   2.对视图进行DML操作就是对视图数据来源的基础表进行的操作
   3.不当的操作会产生数据污染
   4.删除不会产生数据污染
3.1）with check option
作用：为视图添加检查约束
例：
Create Or Replace View V_Emp_Duke
As
select Empno id,Ename name,Sal salary,Deptno
From Emp_Duke
Where Deptno=10
With Check Option

3.2）with read only
作用：为视图添加只读约束
例：
Create Or Replace View V_Emp_Duke
As
select Empno id,Ename name,Sal salary,Deptno
From Emp_Duke
Where Deptno=10
with read only

4）删除视图
注：1.删除视图本身并不会影响基表数据
   2.但是删除视图数据会对应将基表数据删除
例：
Drop View V_Emp_Duke

--2.序列
作用：生成一系列数字，常用于为某张表的主键字段提供值使用
start with：指定开始数值
increment by：固增数值
注：若不指定缓存，则默认缓存为20
1）创建序列：
Create Sequence Seq_Emp_Duke_Id
Start With 1
increment by 1

2）NEXTVAL
作用：获取序列下一个值
注：1.若是新创建的序列，那么第一次调用返回的是Start With 指定的值，以后每次调用都会得到当前序列值加上步长后的数字
   2.Nextval会导致序列发生步进，且序列不能回退
例：
Select Seq_Emp_Duke_Id.nextval
From Dual

3）Currval
作用：获取序列当前值，即最后一次调用Nextval后得到的值，
注：currval不会导致步进但新创建的序列至少调用一次nextval后才可以使用currval
例：
Select Seq_Emp_Duke_Id.currval
From Dual

例：
使用序列为emp表中新插入的数据提供主键字段的值
Insert Into Emp_Duke
(Empno,Ename,Sal,Job,Deptno)
Values 
(Seq_Emp_Duke_Id.Nextval,'JACK',3000,'CLERK',10)

--3.索引
作用：提高查询效率
注：1.索引的统计与应用是数据库自动完成的
   2.只要数据库认为可以使用某个已创建的索引时就会自动应用
1）创建索引
--在emp表的ename列建立索引：
Create Index Idx_Emp_Duke_Ename On Emp_Duke(Ename);

--复合索引：
Create Index Idx_Emp_Duke_Job_Sal On Emp_Duke(Job,Sal)
做它时，会自动应用索引
Select Empno,Ename,Sal,Job From Emp_Duke
Order By Job,Sal
--这里注意顺序，创建索引时和排序时的顺序要一致，不然索引无效

--基于函数的索引：
Create Index Idx_Emp_Duke_Ename_Upper on emp_duke(upper(ename))
做下面的查询时，会自动应用刚刚建立的索引
Select * From Emp_Duke
Where Upper(Ename) ='KING'

--重建索引
Alter Index Idx_Emp_Duke_Ename Rebuild

--删除索引
Drop Index  Idx_Emp_Duke_Ename
Drop Index Idx_Emp_Duke_Job_Sal
Drop Index Idx_Emp_Duke_Ename_Upper

--添加索引的原则
1.不要在小表上添加索引
2.经常作为过滤条件，连接条件，排序，分组，可以作为索引
3.经常做DML操作的表不建议加索引


--4.约束
1).非空约束：
Not Null (Nn)
创建约束条件：
Create Table Employees_Duke (
    Eid Number(6),Name Varchar2(30) Not Null,Salary Number(7,2),
    Hiredate Date Constraint Employees_Duke_Hiredate_Nn Not Null);
注：两种方式，第二种为标准语法，方便对非空约束进行相应操作

修改表时，添加非空约束：
Alter Table Employees_Duke Modify (Eid Number(6) Not Null)

取消非空约束：
Alter Table Employees_Duke Modify(Eid Number(6) Null)
drop table employees_duke

2).唯一性约束：
Unique（uk）:保证修饰的字段不会出现重复的记录，可以为null
创建唯一性约束:
Create Table Employees_Duke(
    Eid Number(6) Unique ,Name Varchar2(30) ,Salary Number(7,2),
    email varchar2(50),  Hiredate Date ,
    Constraint Emplyoees_Duke_Email_Uk Unique(Email))
测试唯一性约束：
Insert Into Employees_Duke (Eid,Name,Email)
Values (Null,Null,Null);
select * from employees_duke

添加唯一性约束条件：
Alter Table Employees_Duke 
Add Constraint Employees_Duke_Name_Uk Unique(Name)
Drop Table Employees_Duke
--注：添加唯一性约束时，需要先清除要添加字段重复的记录，才能添加唯一性约束


3).主键约束
Primary Key (Pk):功能相当于 Not Null 和 Unique 的组合
自动生成，不人为干预，唯一的，一张表只能有一个字段添加主键约束
联合主键：单个不保证不重复，组合肯定不重复。oracle 不支持

添加主键约束条件：
Create Table Employees_Duke(Eid Number(6) Primary Key,
      Name Varchar2(30),Email Varchar2(50),Salary Number(7,2),Hiredate Date)
Desc Employees_Duke
测试主键约束：
Insert Into Employees_Duke (Eid,Name)
    Values (2,'JACK');
select * from employees_duke

4).外键约束
foreign key (fk)
蛋疼

5).检查约束
Check(Ck)

添加检查约束
Alter Table Employees_Duke Add Constraint Employees_Duke_Salary_Check
        Check (Salary>2000) 
测试检查约束:
Insert Into Employees_Duke (Eid,Name,Salary)
Values (1234,'GG',2500)
Update Employees_Duke Set Salary=1500 Where Eid=1234;

















    






