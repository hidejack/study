DQL��ѯ���

SELECT�Ӿ��п���ʹ�ú�������ʽ
,��ô������ж�Ӧ�ĸ��ֶ����������
��������ʽ,�ɶ��Բ�,Ϊ�˿���Ϊ����
���ֶ���ӱ���,��ô����������������
��Ϊ���ֶε�����
�����������ִ�Сд,���Ҳ��ܺ��пո�.
��ϣ���������ִ�Сд���пո�,��ô����
�ڱ�����ʹ��˫����������.
SELECT ename,sal*12 "sal"
FROM emp




�鿴���ʸ���1000��ְλ��
CLERK��SALESMAN
SELECT ename,sal,job
FROM emp
WHERE sal>1000
AND (job='SALESMAN'
OR job='CLERK')

AND�����ȼ�����OR,����ͨ������
�����OR�����ȼ�


LIKE����ģ��ƥ���ַ���,֧������
ͨ���:
_:��һ��һ���ַ�
%:������ַ�

�鿴���ֵڶ�����ĸ��A���һ����ĸ��N��?
SELECT ename
FROM emp
WHERE ename LIKE '_A%N'


IN��NOT IN
�ж��Ƿ����б��л����б���
SELECT ename, job FROM emp  
WHERE job IN ('MANAGER', 'CLERK');

SELECT ename, job FROM emp
WHERE deptno NOT IN (10, 20);

IN��NOT IN�������ж��Ӳ�ѯ�Ľ��



BETWEEN...AND...
�ж���һ�����䷶Χ��

������1500��3000֮���Ա��
SELECT ename,sal
FROM emp
WHERE sal BETWEEN 1500 AND 3000

ANY,ALL
ANY��ALL�����>,>=,<,<=һ��
�б�ʹ�õ�.
>ANY(list):�����б�����С��
>ALL(list):�����б�������
<ANY(list):С���б�������
<ALL(list):С���б�����С��
ANY��ALL�������Ӳ�ѯ.
SELECT empno, ename, job, 
       sal, deptno
FROM emp
WHERE sal > ANY (3500,4000,4500);

ʹ�ú������߱��ʽ��Ϊ��������
SELECT ename, sal, job 
FROM emp 
WHERE ename = UPPER('scott');

SELECT ename, sal, job 
FROM emp 
WHERE sal * 12 >50000;

DISTINCT�ؼ���
�Խ������ָ���ֶ�ֵ�ظ��ļ�¼����
ȥ��

�鿴��˾����Щְλ?
SELECT DISTINCT job
FROM emp

���ֶ�ȥ��,�Ƕ���Щ�ֶ�ֵ�����
����ȥ��
SELECT DISTINCT job,deptno
FROM emp

����
ORDER BY�Ӿ�
ORDER BY���Ը������ָ����
�ֶζԽ�������ո��ֶε�ֵ����
������߽�������.
ASC:����,��дĬ�Ͼ�������
DESC:����.

�鿴��˾�Ĺ�������:
SELECT ename,sal
FROM emp
ORDER BY sal DESC

ORDER BY���ն���ֶ�����
ORDER BY���Ȱ��յ�һ���ֶε�����
��ʽ�Խ������������,����һ���ֶ�
���ظ�ֵʱ�Żᰴ�յڶ����ֶ�����
��ʽ��������,�Դ�����.ÿ���ֶζ�����
����ָ������ʽ.
SELECT ename,deptno,sal
FROM emp
ORDER BY deptno DESC,sal DESC

������ֶ��к���NULLֵ,NULL������
���ֵ.
SELECT ename,comm
FROM emp
ORDER BY comm DESC

�ۺϺ���
�ۺϺ����нж��к���,���麯��
�ۺϺ����ǶԽ����ĳЩ�ֶε�ֵ����ͳ�Ƶ�.

MAX,MIN
������ֶε����ֵ����Сֵ

�鿴��˾����߹�������͹����Ƕ���?
SELECT MAX(sal),MIN(sal)
FROM emp

AVG,SUM
��ƽ��ֵ���ܺ�
SELECT AVG(sal),SUM(sal)
FROM emp

COUNT����
COUNT�������ǶԸ������ֶε�ֵ����
ͳ�Ƶ�,���ǶԸ����ֶβ�ΪNULL�ļ�¼
��ͳ�Ƶ�.
ʵ�������оۺϺ���������NULLֵͳ��.

SELECT COUNT(ename)
FROM emp

ͨ���鿴��ļ�¼������ʹ��COUNT(*)
SELECT COUNT(*) FROM emp


�鿴ƽ����Ч
SELECT AVG(NVL(comm,0)),SUM(comm)
FROM emp


����
GROUP BY �Ӿ�
GROUP BY���Խ�������������ָ��
���ֶ�ֵ��ͬ�ļ�¼����һ��,Ȼ�����
�ۺϺ������и�ϸ�ֵ�ͳ�ƹ���.

�鿴ÿ�����ŵ�ƽ������?
SELECT AVG(sal),deptno
FROM emp
GROUP BY deptno

�鿴ÿ��ְλ����߹���?
SELECT MAX(sal),job
FROM emp
GROUP BY job

GROUP BYҲ���Ը��ݶ���ֶη���
����ԭ��Ϊ�⼸���ֶ�ֵ����ͬ�ļ�¼����һ��

�鿴ͬ����ְͬλ��ƽ������?
SELECT AVG(sal),job,deptno
FROM emp
GROUP BY job,deptno

��SELECT�Ӿ��к��оۺϺ���ʱ,��ô��
���ھۺϺ����е����������ֶζ��������
��GROUP BY�Ӿ���,���������Ǳ����.


�鿴���ŵ�ƽ������,ǰ���Ǹò��ŵ�ƽ��
���ʸ���2000
SELECT AVG(sal),deptno
FROM emp
WHERE AVG(sal)>2000
GROUP BY deptno

WHERE�в���ʹ�þۺϺ�����Ϊ����
����,ԭ���ǹ���ʱ������.
WHERE�������ݿ������������ʱ,��
�������������Ծ����Ƿ��ѯ��������
ʱʹ�õ�,����WHERE����ȷ�������
������.

ʹ�þۺϺ����Ľ����Ϊ��������,��ô
һ�������ݴӱ��в�ѯ���(WHERE�ڲ�ѯ
�����з�������)�õ������,���ҷ������
�Ž��оۺϺ���ͳ�ƽ��,�õ���ſ��Զ�
������й���,�ɴ˿ɼ�,�������ʱ������
WHERE֮����е�.

�ۺϺ����Ĺ�������Ҫ��HAVING�Ӿ���ʹ��
HAVING�������GROUP BY�Ӿ�֮��.HAVING
���������˷����.

SELECT AVG(sal),deptno
FROM emp
GROUP BY deptno
HAVING AVG(sal)>2000

�鿴ƽ�����ʸ���2000�Ĳ��ŵ�
��߹��ʺ���͹��ʷֱ��Ƕ���?
SELECT MAX(sal),MIN(sal),deptno
FROM emp
GROUP BY deptno
HAVING AVG(sal)>2000


������ѯ
�Ӷ��ű��в�ѯ��Ӧ��¼����Ϣ
������ѯ���ص�������Щ���еļ�¼
�Ķ�Ӧ��ϵ,�����ϵҲ��Ϊ��������

�鿴ÿ��Ա���������Լ������ڲ��ŵ�����?
SELECT e.ename,d.dname,e.deptno
FROM emp e,dept d
WHERE e.deptno=d.deptno

�����ű���ͬ���ֶ�ʱ,SELECT�Ӿ���
������ȷָ�����ֶ��������ű�.�ڹ���
��ѯ��,����Ҳ������ӱ���,�������Լ�
SELECT���ĸ��Ӷ�


������ѯҪ�����������,���������ѿ�����
�ѿ�����ͨ����һ��������Ľ����,���ļ�¼
�������в����ѯ�ı�ļ�¼���˻��Ľ��.
Ҫ�������,��������ʱ���׳����ڴ����������.
N�ű������ѯҪ������N-1����������.
SELECT e.ename,d.dname,e.deptno
FROM emp e,dept d


�鿴��NEW YORK������Ա��?
SELECT e.ename,d.deptno
FROM emp e,dept d
WHERE e.deptno=d.deptno
AND d.loc='NEW YORK'

�鿴���ʸ���3000��Ա��������
����,�������Լ����ڵ�?
SELECT e.ename,e.sal,
       d.dname,d.loc
FROM emp e,dept d
WHERE e.deptno=d.deptno
AND e.sal>3000

�鿴SALES���ŵ�Ա�������Լ����ŵ�����
SELECT e.ename,d.dname
FROM emp e JOIN dept d
ON e.deptno=d.deptno
WHERE d.dname='SALES'

���������������ļ�¼�ǲ����ڹ���
��ѯ�б���ѯ������.

������
�����ӳ��˻Ὣ�������������ļ�¼��ѯ
����֮��,���Ὣ���������������ļ�¼Ҳ
��ѯ����.
�����ӷ�Ϊ:
��������:��JOIN������Ϊ������(�������ݶ���
        ����ѯ����),��ô���ñ��е�ĳ����¼��
        ������������ʱ�����Ҳ���е��ֶ�ȫ��
        ��NULL.
��������:
ȫ������:

SELECT e.ename,d.dname
FROM emp e 
  LEFT|RIGHT|FULL OUTER JOIN 
     dept d
ON e.deptno=d.deptno

SELECT e.ename,d.dname
FROM emp e JOIN dept d
ON e.deptno(+)=d.deptno


������
�����Ӽ�:��ǰ���һ����¼���Զ�Ӧ
��ǰ���Լ��Ķ�����¼
��������Ϊ�˽��ͬ�������ݵ����ִ���
���¼���ϵ����״�ṹ����ʱʹ��.

�鿴ÿ��Ա���Լ����쵼������?
SELECT e.ename,m.ename
FROM emp e,emp m
WHERE e.mgr=m.empno

�鿴SMITH����˾���ĸ����й���?
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




