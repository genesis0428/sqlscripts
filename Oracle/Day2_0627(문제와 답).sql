/*
���� ���̺� : ����_ID, �̸�, ��, �̸���, ����ȣ, �������, ����_ID, �޿�, �Ŵ���_ID, �μ�_ID

1. hire_date�� 2006�� 1�� 1�� ������ ������ �̸�,��,�̸���

2. lastname�� 'Jones' �� ������ ��� �÷�

3. salary �� 5000 �̻��� ������ �̸�,��,JOB_ID ��ȸ

4. JOB_ID �� ACCOUNT �� ���� ������ �̸�,��,salary ��ȸ

5. �μ�_ID �� 50 ,60, 80,90 �� ������ ����_ID, �̸�,�� ��ȸ

*/

--1�� ����

SELECT first_name, last_name, email FROM EMPLOYEES e WHERE HIRE_DATE < '2006-01-01';

--2�� ����

SELECT*FROM EMPLOYEES e WHERE LAST_NAME = 'Jones';
-- ��ҹ��� �˻�� ���ǽĿ��� �����ؾ� �մϴ�.
-- �÷����� ��ҹ��� ��ȯ �� ���ǰ� ��
SELECT*FROM EMPLOYEES e WHERE UPPER(LAST_NAME) = 'JONES';
SELECT*FROM EMPLOYEES e WHERE LOWER(LAST_NAME) = 'jones';
--3�� ����

SELECT first_name, last_name, job_id FROM EMPLOYEES e WHERE SALARY >= 5000;

--4�� ����

SELECT first_name, last_name, salary FROM EMPLOYEES e WHERE JOB_ID LIKE '%ACCOUNT%';

--5�� ����
-- 5 : ������ Ÿ�� ��ȯ
SELECT employee_id, first_name, last_name FROM EMPLOYEES e WHERE DEPARTMENT_ID IN (50,60,80,90);

SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 60;
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = '60';	-- �÷� ���Ŀ� ���� number�� ��ȯ

-- ��� �Լ� : count, avg,max,min. ����Լ��� �׷��Լ���� �մϴ�.
--			�ش� �Լ� ������� ���ϱ� ���� Ư�� �÷� ����Ͽ� ���� �����͸� �׷�ȭ���� ����.

SELECT count(*) FROM EMPLOYEES e;		-- ���̺� ��ü ������ ���� : 107
SELECT max(salary) FROM EMPLOYEES e ;	-- salary �÷��� �ִ밪 : 24000
SELECT min(salary) FROM EMPLOYEES e ;	--				�ּҰ� : 2100
SELECT avg(salary) FROM EMPLOYEES e ;	--				��հ� : 6461.83....
SELECT sum(salary) FROM EMPLOYEES e ;	--				�հ� : 691416

-- �� 5�� ����Լ��� JOB_ID = 'IT_PROG' ���� ���ǽ����� �Ȱ��� �����غ���
SELECT count(*) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';	--5
SELECT max(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';	-- salary �÷��� �ִ밪 : 9000
SELECT min(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';	--				�ּҰ� : 4200
SELECT avg(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';	--				��հ� : 5760....
SELECT sum(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';	--				�հ� : 28800

-- ����Լ� ����� �ٸ� �÷����� ���� ��ȸ ���մϴ�. (�׷��Լ��̱� �����Դϴ�.)
SELECT JOB_ID,count(*) FROM EMPLOYEES e 
WHERE JOB_ID = 'IT_PROG';	-- ���� : ���� �׷��� �׷� �Լ��� �ƴմϴ�.

-- ������ ��� : create table, insert into, select~ where ~ �⺻ ����

-- ����
SELECT * FROM EMPLOYEES e ;		-- EMPLOYESS ���̺��� ��Ī e
SELECT * FROM DEPARTMENTS d ;	-- DEPARTMENTS ���̺��� ��Ī DELETE 
--�������� ���� ��Ī�� �ʿ�����ϴ�. �׷��� ������ �����ϰ� ���ϴ�.