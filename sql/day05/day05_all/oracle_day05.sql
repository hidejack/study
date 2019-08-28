��ͼ
��ͼ�����ݿ����֮һ
�������ݿ�������ֲ����ظ�,����
��ͼ����һ������"v_"��ͷ

��ͼ��SQL��������ֵĽ�ɫ�����ͬ
������ͼ������һ����ʵ���ڵı�,��
ֻ�Ƕ�Ӧһ��SELECT���Ĳ�ѯ�����,
�����䵱����������.
ʹ����ͼ��Ŀ���Ǽ�SQL���ĸ��Ӷ�,
�����Ӳ�ѯ,�������ݷ���.

������ͼ
����ͼ����������Ϊ10�Ų��ŵ�Ա����Ϣ
CREATE VIEW v_emp_10
AS
SELECT empno,ename,sal,deptno
FROM emp
WHERE deptno=10

�鿴��ͼ����:
SELECT * FROM v_emp_10

��ͼ��Ӧ���Ӳ�ѯ�е��ֶ������к���
���߱��ʽ,��ô���ֶα���ָ������.
����ͼ��Ӧ���Ӳ�ѯ�е��ֶ�ʹ���˱���,
��ô��ͼ�и��ֶξ��ñ���������.

�޸���ͼ
������ͼ����Ӧһ��SELECT���,�����޸�
��ͼ�����滻��SELECT������.

CREATE OR REPLACE VIEW v_emp_10
AS
SELECT empno id,ename name,
       sal salary,deptno
FROM emp
WHERE deptno=10

SELECT * FROM v_emp_10
DESC v_emp_10


��ͼ��Ϊ����ͼ�븴����ͼ
����ͼ:��Ӧ���Ӳ�ѯ�в�����
������ѯ,��ѯ���ֶβ���������,
���ʽ��,û�з���,û��ȥ��.
��֮���Ǹ�����ͼ.

����ͼ����DML����
���ܶԼ���ͼ����DML����.
����ͼ����DML�������Ƕ���ͼ������Դ
�Ļ�������еĲ���.

INSERT INTO v_emp_10
(id,name,salary,deptno)
VALUES
(1001,'JACK',2000,10)

SELECT * FROM v_emp_10
SELECT * FROM emp

����ͼ��DML�������ǶԻ������,��ô
�����������ܶԻ������������Ⱦ
INSERT INTO v_emp_10
(id,name,salary,deptno)
VALUES
(1002,'ROSE',3000,20)

��ͼ��ROSE���ɼ�
SELECT * FROM v_emp_10
SELECT * FROM emp

����ͬ�����ڸ��º�����ݲ��ɿ�
�����
UPDATE v_emp_10
SET deptno=20

ɾ������Ի������������Ⱦ
DELETE FROM v_emp_10
WHERE deptno=20

Ϊ��ͼ��Ӽ��ѡ��,���Ա�֤����ͼ
��DML��������ͼ����ɼ�,��������
���и�DML����,�����ͱ����˶Ի���
����������Ⱦ.
CREATE OR REPLACE VIEW v_emp_10
AS
SELECT empno id,ename name,
       sal salary,deptno
FROM emp
WHERE deptno=10
WITH CHECK OPTION


Ϊ��ͼ���ֻ��ѡ��,��ô����ͼ
���������DML����.
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

������ͼ
����һ�����й�˾���Ź����������ͼ,
����Ϊ:���ű��,��������,���ŵ����,
���,ƽ��,�Լ������ܺ���Ϣ.

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

�鿴˭���Լ����ڲ���ƽ�����ʸ�?
SELECT e.ename,e.sal,e.deptno
FROM emp e,v_dept_sal v
WHERE e.deptno=v.deptno
AND e.sal>v.avg_sal


ɾ����ͼ
DROP VIEW v_emp_10

ɾ����ͼ��������Ӱ���������.
����ɾ����ͼ���ݻ��Ӧ����������ɾ��.


����
����Ҳ�����ݿ����֮һ.
����������һϵ������.
���г�����Ϊĳ�ű�������ֶ��ṩֵʹ��.
CREATE SEQUENCE seq_emp_id
START WITH 1
INCREMENT BY 1

����֧������α��:
NEXTVAL:��ȡ������һ��ֵ
�����´���������,��ô��һ�ε��÷��ص���
START WITHָ����ֵ,�Ժ�ÿ�ε��ö���õ�
��ǰ����ֵ���ϲ����������.
NEXTVAL�ᵼ�����з�������,�����в��ܻ���.

CURRVAL:��ȡ���е�ǰֵ,��:���һ�ε���
NEXTVAL��õ���ֵ,CURRVAL���ᵼ�²���.
�����´������������ٵ���һ��NEXTVAL��ſ�
��ʹ��CURRVAL.

SELECT seq_emp_id.CURRVAL
FROM dual

ʹ������ΪEMP�����Ų���������ṩ
�����ֶε�ֵ
INSERT INTO emp
(empno,ename,sal,job,deptno)
VALUES
(seq_emp_id.NEXTVAL,'JACK',
 3000,'CLERK',10)


SELECT * FROM emp


ɾ������
DROP SEQUENCE seq_emp_id

����
���������ݿ����֮һ
������Ϊ����߲�ѯЧ��

������ͳ����Ӧ�������ݿ��Զ���ɵ�
ֻҪ���ݿ���Ϊ����ʹ��ĳ���Ѵ�����
����ʱ�ͻ��Զ�Ӧ��.



Լ��

Ψһ��Լ��
Ψһ��Լ�����Ա�֤���и��ֶε�ֵ
�κ�һ����¼���������ظ�,NULL����.
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





