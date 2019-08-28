SELECT���
���ڲ�ѯ��������
SELECT�Ӿ���������Ҫ��ѯ��
�ֶ�,���԰������еľ����ֶ�,����
���߱��ʽ.
FROM�Ӿ�����ָ��������Դ�ı�
WHERE�Ӿ�������ӹ�������,����
���Ľ����ֻ�����������ļ�¼��ѯ����

�鿴emp���е�����
SELECT empno,ename,job,sal
FROM emp

SELECT�Ӿ���ʹ�ñ��ʽ
�鿴ÿ��Ա������н?
SELECT ename,sal*12
FROM emp

�ַ�������
CONCAT()����,���������ַ���
SELECT CONCAT(ename,sal)
FROM emp

SELECT CONCAT(CONCAT(ename,','),sal)
FROM emp

SELECT ename||','||sal
FROM emp

LENGTH����,�鿴�ַ�������
SELECT ename,LENGTH(ename)
FROM emp

UPPER,LOWER,INITCAP
���ַ���ת��Ϊȫ��д,ȫСд
�Լ�����ĸ��д
����INITCAP����,����ʹ�ÿո�
�����������,��ôÿ����������ĸ
�����д.

α��:dual
����ѯ�����ݲ����κα��������й�ϵ
ʱ,����ʹ��α��,α��ֻ���ѯ��һ��
��¼.
SELECT UPPER('helloworld'),
       LOWER('HELLOWORLD'),
       INITCAP('HELLO WORLD')
FROM dual

TRIM,LTRIM,RTRIM
ȥ����ǰ�ַ��������ߵ�ָ���ظ�
�ַ�,LTRIM��ȥ������,RTRIM
���ȥ���Ҳ��.
SELECT TRIM('e' FROM 'eeeliteeee')
FROM dual

SELECT LTRIM('esrrersrresresliteeee','res')
FROM dual


LPAD,RPAD��λ����
SELECT LPAD(sal,5,'$')
FROM emp


SUBSTR��ȡ�ַ���
���ݿ��е��±궼�Ǵ�1��ʼ��
SELECT 
  SUBSTR('thinking in java',13,4)
FROM dual

������������ָ�����ǽ�ȡ��ĩβ,ָ���ĳ���
������ʵ�ʿ��Խ�ȡ������Ҳ�ǽ�ȡ��ĩβ
SELECT 
  SUBSTR('thinking in java',10)
FROM dual

��ȡ��λ�ÿ����Ǹ���,�������ʾ�ӵ���
�ڼ����ַ���ʼ��ȡ
SELECT 
  SUBSTR('thinking in java',-4,4)
FROM dual


INSTR(char1,char2[,n,m])����
����char2��char1�е�λ��
nΪ�ӵڼ����ַ���ʼ����
mΪ�ڼ��γ���
n,m��д��Ĭ�϶���1

SELECT 
 INSTR('thinking in java','in',4,1)
FROM 
 dual


���ֺ���
ROUND(n,m)��������
SELECT ROUND(45.678, 2) FROM DUAL
SELECT ROUND(45.678, 0) FROM DUAL
SELECT ROUND(45.678, -1) FROM DUAL


TRUNC(n,m)��ȡ����
SELECT TRUNC(45.678, 2) FROM DUAL
SELECT TRUNC(45.678, 0) FROM DUAL
SELECT TRUNC(45.678, -1) FROM DUAL


MOD(m,n)������
SELECT ename, sal, MOD(sal, 1000) 
FROM emp 


CEIL,FLOOR
����ȡ��������ȡ��
SELECT CEIL(45.678) FROM DUAL
SELECT FLOOR(45.678) FROM DUAL


�鿴scottԱ������Ϣ?
SELECT ename,sal,deptno
FROM emp
WHERE ename=UPPER('scott')

�鿴����ֻ��5����ĸ��Ա��������,����?
���ź�
SELECT ename,sal,deptno
FROM emp
WHERE LENGTH(ename)=5

�鿴��������ĸ��A��Ա����Ϣ?
SELECT ename,sal,deptno
FROM emp
WHERE INSTR(ename,'A')=3

SELECT ename,sal,deptno
FROM emp
WHERE SUBSTR(ename,3,1)='A'


��������

SYSDATE,SYSTIMESTAMP
SYSDATE��Ӧ���ݿ�һ���ڲ�����,
�ú�������һ����ʾ��ǰϵͳʱ��
��DATE����ֵ.
SYSTIMESTAMP���ص���һ����ʾ
��ǰϵͳʱ���ʱ������͵�ֵ

SELECT SYSDATE FROM dual
SELECT SYSTIMESTAMP FROM dual

TO_DATE����
���Խ��ַ������ո��������ڸ�ʽ����
Ϊһ��DATE���͵�ֵ

�����ڸ�ʽ�ַ����з�����Ӣ��,����,���ֵ�
�����ַ�,����Ҫʹ��˫����������.
SELECT 
  TO_DATE('2008��08��08�� 20:08:08',
          'YYYY"��"MM"��"DD"��" HH24:MI:SS')
FROM
  dual

���ڵļ���
���ڿ�����һ�����ֽ��мӼ���,���൱
��Ӽ�ָ������
�������ڿ��Խ��м���,��Ϊ������.

�鿴ÿ��Ա��������ְ��������?
SELECT ename,SYSDATE-hiredate
FROM emp

�����Լ�����:1992-08-02
�鿴������Ϊֹ���˶�����?
SELECT 
 SYSDATE-TO_DATE('1992-08-02',
                 'YYYY-MM-DD')
FROM dual

TO_CHAR():���Խ�DATE���ո����ĸ�ʽ
ת��Ϊ�ַ���.
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
���ظ������������µ��µ�����

�鿴���µ�?
SELECT LAST_DAY(SYSDATE)
FROM dual


ADD_MONTHS(date,i)
�Ը������ڼ���ָ������,��
iΪ�������Ǽ�ȥ.

�鿴ÿ��Ա����ְ20���������
SELECT 
 ename,ADD_MONTHS(hiredate,12*20)
FROM
 emp


MONTHS_BETWEEN(date1,date2)
������������֮��������,������
����date1-date2�õ���

�鿴ÿ��Ա��������ְ���ٸ�����?
SELECT 
 ename,MONTHS_BETWEEN(SYSDATE,hiredate)
FROM 
 emp

NEXT_DAY(date,i)
���ظ������ڵĵڶ��쿪ʼһ��
֮�ڵ�ָ���ܼ�������
i:1��ʾ����,2��ʾ��һ,�Դ�����

SELECT NEXT_DAY(SYSDATE,7)
FROM dual

LEAST,GREATEST
����Сֵ�����ֵ,����
������,���õ�����Ҳ���ԱȽϴ�С
SELECT 
 LEAST(SYSDATE, 
       TO_DATE('2008-08-05',
               'YYYY-MM-DD'))
FROM DUAL


EXTRACT()��ȡ����������ָ��
ʱ�������ֵ
SELECT EXTRACT(YEAR FROM SYSDATE)
FROM dual

�鿴1980����ְ��Ա��
SELECT ename,hiredate
FROM emp
WHERE EXTRACT(YEAR FROM hiredate)=1980


��ֵ����

1:����NULLֵ
CREATE TABLE student
    (id NUMBER(4), name CHAR(20), gender CHAR(1));

INSERT INTO student VALUES(1000, '��Ī��', 'F');

INSERT INTO student VALUES(1001, '��ƽ֮', NULL);

INSERT INTO student(id, name) VALUES(1002, '���޼�');

SELECT * FROM student

2:����ΪNULL
UPDATE student
SET gender=NULL
WHERE id=1000

�ж��ֶε�ֵ�Ƿ�ΪNULL
�ж�Ҫʹ��IS NULL��IS NOT NULL
DELETE FROM student
WHERE gender IS NULL


NULLֵ���������
NULL���κ�������������ΪNULL
NULL���ַ���ƴ�ӵ���ʲô��û��

�鿴ÿ��Ա��������:
SELECT ename,sal,comm,sal+comm
FROM emp

��ֵ����
NVL(arg1,arg2)
��arg1ΪNULL,��������arg2��ֵ
����ΪNULL,�򷵻�arg1����.
���Ըú����������ǽ�NULLֵ�滻Ϊ
һ����NULLֵ.
�鿴ÿ��Ա��������:
SELECT 
 ename,sal,comm,
 sal+NVL(comm,0)
FROM emp

�鿴ÿ���˵ļ�Ч���,��:
�м�Ч��,��ʾΪ"�м�Ч"
��ЧΪNULL��,����ʾΪ"û�м�Ч"

NVL2(arg1,arg2,arg3)
��arg1��ΪNULL,��������arg2
��arg1ΪNULL,��������arg3
�ú����Ǹ���һ��ֵ�Ƿ�ΪNULL��
����������ͬ���.

SELECT 
  ename,comm,
  NVL2(comm,'�н���','û�н���')
FROM
  emp

SELECT 
  ename,sal,comm,
  NVL2(comm,sal+comm,sal)
FROM
  emp



