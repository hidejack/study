SELECT SYSDATE FROM dual

SQL��䱾�����ִ�Сд,���ǳ���
�ɶ��Ե�Ŀ��,����ͨ���ὫSQL�е�
�ؼ���ȫ����д,�ǹؼ���ȫ��Сд.

DDL ���ݶ�������
DDL�Ƕ����ݿ������в���������.
���ݿ�������:��,��ͼ,����,����

������:
CREATE TABLE employee(
	id NUMBER(4),
	name VARCHAR2(20),
	gender CHAR(1),
	birth DATE,
  salary NUMBER(6,2),
  job VARCHAR2(30),
  deptno NUMBER(2)
)

�鿴��ṹ
DESC employee

ɾ����
DROP TABLE employee

���ݿ��������������͵�Ĭ��ֵ����NULL
�ڴ������ʱ�����ʹ��DEFAULTΪĳ��
�ֶε���ָ��һ��Ĭ��ֵ.
���ݿ��е��ַ�����������ʹ�õ����ŵ�
��ȻSQL��䱾�����ִ�Сд,�����ַ���
��ֵ�����ִ�Сд��!

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

�޸ı�
1:�޸ı���
2:�޸ı�ṹ

�޸ı���:
RENAME employee TO myemp
DESC myemp

�޸ı�ṹ
1:����µ��ֶ�
2:�޸������ֶ�
3:ɾ�������ֶ�

������ֶ�
ALTER TABLE myemp
ADD(
  hiredate DATE DEFAULT SYSDATE
)
DESC myemp

ɾ���ֶ�
ALTER TABLE myemp
DROP(hiredate)


�޸��ֶ�
�����޸��ֶε�����,����,Ĭ��ֵ,�Ƿ�ǿ�.
�޸ı�ṹ��Ӧ�������ڱ����������Ժ����.
������������,�޸ı����ֶ�ʱ������Ҫ�޸���
��,���޸ĳ��Ⱦ������������С,������ܵ���
ʧ��.
ALTER TABLE myemp
MODIFY(
  job VARCHAR2(40) DEFAULT 'CLERK'
)
DESC myemp


DML���
DML�ǶԱ��е����ݽ��еĲ���
DML�����������(TCL)
DML��������:
��,ɾ,��.

INSERT���
����в�������

INSERT INTO myemp
(id,name,salary,deptno)
VALUES
(1,'jack',5000,10)

SELECT * FROM myemp

COMMIT

--ʹ���Զ������ڸ�ʽ�����¼
INSERT INTO myemp 
(id, name, job,birth) 
VALUES
(1003, 'donna', 'MANAGER', 
TO_DATE('2009-09-01','YYYY-MM-DD')
)

UPDATE���
�޸ı�������
�޸ı�������Ҫʹ��WHERE��ӹ���
����,�����Ż�ֻ�����������ļ�¼
�����޸�,������ȫ���������ݶ��޸�
UPDATE myemp
SET salary=7000,gender='F',
    name='rose'
WHERE id=1

DELETE���
ɾ����������,ɾ������ͨ��ҲҪ���
WHERE������޶�Ҫɾ�����ݵ�����
���������ձ����!
DELETE FROM myemp
WHERE name='rose'











