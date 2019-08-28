�Ӳ�ѯ
�Ӳ�ѯ��һ��SELECT���,������Ƕ����
����SQL����е�,Ϊ���Ǹ���SQL�ṩ����
��֧����ִ�в���.

�鿴˭�Ĺ��ʸ���CLARK?
SELECT ename,sal
FROM emp
WHERE sal>(SELECT sal FROM emp
           WHERE ename='CLARK')

�鿴��CLARKְͬλ��Ա��?
SELECT ename,job FROM emp
WHERE job=(SELECT job FROM emp
           WHERE ename='CLARK')


�鿴��CLARKͬ���ŵ�Ա��?
SELECT ename,deptno FROM emp
WHERE deptno=(SELECT deptno FROM emp
              WHERE ename='CLARK')


��DDL��ʹ���Ӳ�ѯ
���Ը����Ӳ�ѯ�Ľ�������ٴ���һ�ű�

������employee,�����ֶ�Ϊ:
empno,ename,job,sal,deptno,dname,loc
����Ϊ���б���emp��dept��Ӧ������
CREATE TABLE employee
AS
SELECT e.empno,e.ename,e.job,e.sal,
       e.deptno,d.dname,d.loc
FROM emp e,dept d
WHERE e.deptno=d.deptno(+)

DESC employee
SELECT * FROM employee

DROP TABLE employee

������ʱ���Ӳ�ѯ�е��ֶ��б�����ñ�
��Ӧ���ֶξ�ʹ�øñ�����Ϊ���ֶ���,
���Ӳ�ѯ��һ���ֶκ��к�������ʽ,��ô
���ֶα��������.
CREATE TABLE employee
AS
SELECT e.empno id,e.ename name,
       e.job,e.sal*12 salary,
       e.deptno,d.dname,d.loc
FROM emp e,dept d
WHERE e.deptno=d.deptno(+)

SELECT name,salary
FROM employee

DML��ʹ���Ӳ�ѯ
��CLARK���ڲ��ŵ�����Ա��ɾ��
DELETE FROM employee
WHERE deptno=(SELECT deptno 
              FROM employee
              WHERE name='CLARK')


SELECT * FROM employee

�Ӳ�ѯ������SELECT�����.
�Ӳ�ѯ���ݲ�ѯ������Ĳ�ͬ��Ϊ:
���е����Ӳ�ѯ:�����ڹ�������,�������
             =,>,>=,<,<=ʹ��
���е����Ӳ�ѯ:�����ڹ�������,���ڲ�ѯ��
             ���ֵ,���ж�=ʱҪ��IN,
             �ж�>,>=�Ȳ���Ҫ���ANY,ALL
���ж����Ӳ�ѯ:������һ�ű���.

��ѯ��SALESMANͬ���ŵ�����ְλԱ����
SELECT ename,job,deptno
FROM emp
WHERE deptno IN (SELECT deptno 
                 FROM emp
                 WHERE job='SALESMAN')
AND job<>'SALESMAN'

�鿴��ְλ��CLERK��SALESMAN���ʶ��ߵ�Ա��?
SELECT ename,sal
FROM emp
WHERE sal> ALL(SELECT sal FROM emp
               WHERE job IN('CLERK','SALESMAN')
               )

EXISTS�ؼ���
EXISTS�����һ���Ӳ�ѯ,�����Ӳ�ѯ���Բ�ѯ
������һ����¼ʱ,��EXISTS���ʽ����������
true

SELECT deptno, dname FROM dept d
WHERE 
 NOT EXISTS(SELECT * FROM emp e
            WHERE d.deptno = e.deptno)


�鿴ÿ�����ŵ����нˮ�Ƕ���?ǰ���Ǹò���
�����нˮҪ����30�Ų��ŵ����нˮ
SELECT MIN(sal),deptno
FROM emp
GROUP BY deptno
HAVING MIN(sal)>(SELECT MIN(sal)
                 FROM emp
                 WHERE deptno=30)


�Ӳ�ѯ��FROM�Ӿ��е�ʹ��
��һ���Ӳ�ѯ�Ƕ����Ӳ�ѯ,ͨ�������Ӳ�ѯ
�Ľ��������һ�ű��������������ж���
��ѯ.

�鿴���Լ����ڲ���ƽ�����ʸߵ�Ա��?

1:�鿴ÿ������ƽ������
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

��SELECT�Ӿ���ʹ���Ӳ�ѯ,���Խ���ѯ�Ľ��
��������ѯ��¼�е�һ���ֶ�ֵ��ʾ
SELECT e.ename, e.sal, 
      (SELECT d.dname FROM dept d 
       WHERE d.deptno = e.deptno) deptno
FROM emp e

��ҳ��ѯ
��ҳ��ѯ�ǽ���ѯ��������ʱ�ֶβ�ѯ,����
��һ���Խ��������ݲ�ѯ����.
��ʱ��ѯ���������ǳ��Ӵ�,��ص���ϵͳ��Դ
���Ĵ�,��Ӧ�ٶȳ�,������������.
Ϊ�˵������������ʱһ��ʹ�÷�ҳ��ѯ���.
���ݿ������֧�ַ�ҳ,���ǲ�ͬ���ݿ��﷨��
ͬ(����).

ORACLE�еķ�ҳ�ǻ���α��ROWNUMʵ�ֵ�.

ROWNUM���������κ�һ�ű���,�������еı�
�����Բ�ѯ���ֶ�.���ֶε�ֵ�����Ų�ѯ�Զ�
���ɵ�,��ʽ��:ÿ�����Դӱ��в�ѯ��һ����
¼ʱ,���ֶε�ֵ��Ϊ������¼���к�,��1��ʼ,
��ε���.

SELECT ROWNUM,empno,ename,sal,job
FROM emp
WHERE ROWNUM > 1

��ʹ��ROWNUM�Խ�������б�ŵĲ�ѯ����
�в���ʹ��ROWNUM��>1���ϵ������ж�,����
����ѯ�����κ�����.
SELECT *
FROM(SELECT ROWNUM rn,empno,
            ename,sal,job
     FROM emp)
WHERE rn BETWEEN 6 AND 10

�鿴��˾����������6-10
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

�������乫ʽ
pageSize:ÿҳ��ʾ����Ŀ��
page:ҳ��

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


DECODE����,����ʵ�ַ�֮Ч���ĺ���
SELECT ename, job, sal,
     DECODE(job,  
            'MANAGER', sal * 1.2,
            'ANALYST', sal * 1.1,
            'SALESMAN', sal * 1.05,
            sal
     ) bonus
FROM emp


DECODE��GROUP BY�����е�Ӧ�ÿ���
���ֶ�ֵ��ͬ�ļ�¼����һ��.

ͳ������,��ְλ��"MANAGER","ANALYST"
����һ��,����ְҵ������һ��ֱ�ͳ������.

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
     

������
����������Խ��������ָ�����ֶη���
�������ٰ���ָ�����ֶ�����,������������
���.

ROW_NUMBER()������������������Ψһ������:
�鿴ÿ�����ŵĹ�������?
SELECT 
 ename,sal,deptno,
 ROW_NUMBER() OVER(
  PARTITION BY deptno
  ORDER BY sal DESC
 ) rank
FROM emp


RANK����,�������ڲ�����Ҳ��Ψһ������,
ͬ���������ֶ�ֵһ���ļ�¼,���ɵ�����
Ҳһ��.
SELECT 
 ename,sal,deptno,
 RANK() OVER(
  PARTITION BY deptno
  ORDER BY sal DESC
 ) rank
FROM emp

DENSE_RANK��������������������Ψһ
������.
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

�鿴ÿ��Ӫҵ��?
SELECT year_id,month_id,day_id,
       SUM(sales_value)
FROM sales_tab
GROUP BY year_id,month_id,day_id
ORDER BY year_id,month_id,day_id


ÿ��Ӫҵ��?
SELECT year_id,month_id,
       SUM(sales_value)
FROM sales_tab
GROUP BY year_id,month_id
ORDER BY year_id,month_id

ÿ��Ӫҵ��?
SELECT year_id,
       SUM(sales_value)
FROM sales_tab
GROUP BY year_id
ORDER BY year_id

�ܹ�Ӫҵ��?
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

�߼����麯��
�߼����麯������GROUP BY�Ӿ���,ÿ���߼�
���麯������һ�׷������.

ROLLUP():����ԭ��,������εݼ�,һֱ������
         ��������Ҫ,ÿһ�ַ��鶼ͳ��һ�ν��
         ���Ҳ���һ���������ʾ.

GROUP BY ROLLUP(a,b,c)
�ȼ���:
GROUP BY a,b,c
UNION ALL
GROUP BY a,b
UNION ALL
GROUP BY a
UNION ALL
ȫ��

�鿴ÿ��,ÿ��,ÿ���Լ��ܹ���Ӫҵ��?
SELECT year_id,month_id,day_id,
       SUM(sales_value)
FROM sales_tab
GROUP BY 
 ROLLUP(year_id,month_id,day_id)


CUBE():ÿ����Ϸ�һ����
�������:2�Ĳ��������η�

GROUP BY CUBE(a,b,c)
abc
ab
bc
ac
a
b
c
ȫ��

SELECT year_id,month_id,day_id,
       SUM(sales_value)
FROM sales_tab
GROUP BY 
 CUBE(year_id,month_id,day_id)
ORDER BY  year_id,month_id,day_id
 
 

GROUPING SETS:ÿ��������һ�ַ��鷽ʽ,
Ȼ����Щ����ͳ�ƺ���һ���������ʾ.

���鿴ÿ����ÿ��Ӫҵ��?
SELECT year_id,month_id,day_id,
       SUM(sales_value)
FROM sales_tab
GROUP BY 
 GROUPING SETS(
  (year_id,month_id,day_id),
  (year_id,month_id)
 )

 


