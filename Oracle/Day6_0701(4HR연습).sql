-- HR ��Ű���� �̿��Ͽ� ���ΰ� group by �� �����ؼ� select�� �˻��ϴ� ������ 10�� �����
-- group by ����ε� ������ �� �� �ֽ��ϴ�. ���� : �μ��ο��� ���� ���� �μ���?

-- �ּ����� �˻��ϴ� ���� ����
-- select ���� �ۼ��ϼ���

-- jobs ���̺�
	--1)min salary �÷��� 10000 �̻��� Job_title ��ȸ
		SELECT job_title FROM JOBS j WHERE MIN_SALARY >=10000;
	--2)job_title �÷��� programmer �� ���� ��� �÷� ��ȸ
		SELECT * FROM JOBS j WHERE job_title = 'programmer';
		SELECT * FROM JOBS j WHERE job_title = 'Programmer';
		-- ��ҹ��� ������� ���� �˻��Ѵٸ� ���ڿ� ���� ����Ŭ �Լ� : upper(), lower() �̿��մϴ�.
		SELECT * FROM JOBS j WHERE upper(job_title) = 'Programmer';
		SELECT * FROM JOBS j WHERE lower(job_title) = 'programmer';
	
	--3)max_salary �ʵ尪�� �ִ� �÷��� ��ȸ
		SELECT max(max_salary) FROM JOBS j ;
	

--locations ���̺�
	--1)city �÷��� London �� postal_code ��ȸ
		SELECT postal_code FROM LOCATIONS l WHERE city = 'London';
		SELECT postal_code FROM LOCATIONS l WHERE city = 'Seattle';
	
	--2)LOCATIONAL_ID �÷��� 1700, 2700, 2500�� �ƴϰ� city �÷��� Tokyo�� ���� ��� �÷� ��ȸ
	SELECT * FROM LOCATIONS l WHERE LOCATION_ID NOT IN (1700, 2700, 2500) AND city ='Tokyo';



-- Jonathon Taylor �� �ٹ� �̷� Ȯ���ϱ�
SELECT * FROM EMPLOYEES e JOIN JOB_HISTORY jh ON e.EMPLOYEE_ID =jh.EMPLOYEE_ID 
AND FIRST_NAME = 'Jonathon' AND LAST_NAME = 'Taylor';

-- ��� �Լ�(�����Լ�) : employees ���̺�
SELECT count(*) FROM EMPLOYEES e ;		-- �Ѱ��� : 107
SELECT count(*) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';		-- ���� job_id ������ : 5

SELECT avg(salary) FROM EMPLOYEES e ;		-- ���� ��� �޿� : 6461.83
SELECT avg(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';		-- ���� job_id ��ձ޿� : 5760

SELECT max(salary) FROM EMPLOYEES e ;		-- ���� �� �ְ� �޿� : 24,000
SELECT max(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';		-- ���� job_id �ְ�޿� : 9000

SELECT min(salary) FROM EMPLOYEES e ;		-- ���� �� �ּ� �޿� : 2,100
SELECT min(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';		-- ���� job_id �ְ�޿� : 4200


-- �μ� ���̺�� ���� ���̺� join
SELECT count(*) FROM EMPLOYEES e2, DEPARTMENTS d2 WHERE e2.DEPARTMENT_ID = d2.DEPARTMENT_ID ;
SELECT count(*) FROM EMPLOYEES e JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID ;

-- �μ��� 'Sales' �� ������ �ο��� ��ȸ�ϱ�
SELECT count(*) FROM EMPLOYEES e JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 
AND department_name = 'Sales';

-- jobs ���̺� : min_salary �� ��պ��� ���� job�� ���� ����
SELECT avg(MIN_SALARY) FROM JOBS j ;
SELECT job_id, job_title, MIN_SALARY FROM JOBS j 
WHERE MIN_SALARY < (SELECT avg(MIN_SALARY) FROM JOBS j);

-- �Ʒ� ����� ���� -> �׷��Լ��� �ݵ�� select ������ ����մϴ�. *
SELECT job_id, job_title, MIN_SALARY FROM JOBS j 
WHERE MIN_SALARY < avg(MIN_SALARY);

-- ���� ���� �ʿ��� ���� : ������ ���̺� ���
-- �ּ� �޿��� �޴� ����� first_name, last_name �÷� ��ȸ�ϱ�
SELECT first_name, last_name, SALARY FROM EMPLOYEES e 
WHERE SALARY = (SELECT min(SALARY) FROM EMPLOYEES e WHERE job_id = 'IT_PROG');


SELECT min(SALARY) FROM EMPLOYEES e WHERE job_id = 'IT_PROG';
--job_id �� 'IT_PROG'�� �ƴ� �� ��ȸ
SELECT min(SALARY) FROM EMPLOYEES e WHERE JOB_ID <> 'IT_PROG';
SELECT MIN(SALARY) FROM EMPLOYEES e WHERE NOT JOB_ID = 'IT_PROG';	--** 


--�μ��� ��ձ޿��� ��ȸ�մϴ�. ������ ��ձ޿� ������������ �μ�_ID, �μ���, ��ձ޿� (�Ҽ��� 1�ڸ��� �ݿø�)
--����Ŭ �Ҽ��� ���� �Լ� : round(�ݿø�), trunc(����), ceil(����)

--�׷��Լ� ��ȸ�� �� group by �� ��� �׷���̿� �� �÷��� select�� ��ȸ�� �� �ֽ��ϴ�.
--		�׷���� �÷��ܿ��� �ٸ� �÷� select �� �� �����ϴ�. -> join, ��������
--1�ܰ� : ����� �׷��Լ� �����ϱ�
SELECT DEPARTMENT_ID , avg(salary) FROM EMPLOYEES e GROUP BY DEPARTMENT_ID ;

--2�ܰ� : �����ϱ�
SELECT * FROM DEPARTMENTS d JOIN
		(SELECT DEPARTMENT_ID, avg(salary) cavg FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
		ON d.DEPARTMENT_ID = tavg.DEPARTMENT_ID;

--3�ܰ� : �÷� �����ϱ�
SELECT d.DEPARTMENT_ID, d.DEPARTMENT_NAME, round(tavg.cavg,1) FROM DEPARTMENTS d 
		JOIN
		(SELECT DEPARTMENT_ID, avg(salary) cavg FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
		ON d.DEPARTMENT_ID = tavg.DEPARTMENT_ID
		ORDER BY tavg.cavg DESC;

--4�ܰ� : ������ ����� Ư�� ��ġ ���� : first n�� ���� n���� ��ȸ
SELECT d.DEPARTMENT_ID ,d.DEPARTMENT_NAME ,round(tavg.cavg,1) FROM DEPARTMENTS d 
		JOIN
		(SELECT DEPARTMENT_ID, avg(salary) cavg FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
		ON d.DEPARTMENT_ID = tavg.DEPARTMENT_ID
		ORDER BY tavg.cavg DESC
		FETCH FIRST 1 ROWS ONLY;
	
--�ٸ� ����
	SELECT d.DEPARTMENT_ID did, d.department_name ,e.cnt
	FROM DEPARTMENTS d 
	JOIN 
		(SELECT DEPARTMENT_ID, count(*) cnt FROM EMPLOYEES 
		GROUP BY DEPARTMENT_ID) e
		ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
		ORDER BY cnt DESC
		FETCH FIRST 1 ROWS ONLY;
	
	
-- rownum�� ������ �÷����� ��ȸ�� ����� ���������� ����Ŭ�� �ο��ϴ� ���Դϴ�.
-- 			���� �÷� ����� ���� join�� �ѹ� �� �ʿ��մϴ�.
SELECT rownum, tcnt.*FROM
(SELECT department_id , count(*) cnt FROM EMPLOYEES 
GROUP BY DEPARTMENT_ID ORDER BY cnt DESC ) tcnt
WHERE rownum < 5 ;


SELECT rownum, tcnt.*FROM
(SELECT department_id , count(*) cnt FROM EMPLOYEES 
GROUP BY DEPARTMENT_ID ORDER BY cnt DESC ) tcnt
WHERE rownum = 1 ;

-- rownum ����Ҷ� ��� Ȯ���� �ȵǴ� ���� : rownum 1���� �����ؼ� ã�ư� �� �ִ� ���ǽĸ� ����.
-- where rownum = 3;
-- where rownum > 5;
-- �׷��� �ѹ� �� rownum �� ������ ��ȸ ����� select �� �մϴ�. �̶� rownum �� ��Ī�ο�.
SELECT *FROM
	(SELECT rownum rn,tcnt.*FROM
		(SELECT department_id, count(*) cnt FROM EMPLOYEES 
			GROUP BY DEPARTMENT_ID ORDER BY cnt DESC ) tcnt)
WHERE rn BETWEEN 5 AND 9;






--1. ����(employee) ���̺��� �̿��Ͽ� ������(job_id) �ο��� �� �׵��� �ѱ޿��� ���ϰ� �ѱ޿��� ���� ������ �����϶�.

SELECT job_id, count(*), sum(salary) FROM EMPLOYEES e 
	GROUP BY job_id
	ORDER BY sum(SALARY) DESC;
	
--2. 1�� �������� �ѱ޿��� 5�� �̻��� ������ ���� �ο��� ���� ������� �����϶�.

SELECT job_id, count(*) cnt, sum(salary) FROM EMPLOYEES e 
	GROUP BY job_id
	HAVING sum(salary) >=50000
	ORDER BY cnt DESC;
	

--3. ���� ���̺��� �μ��� �ο��� 7�� �̻��� �μ��� �ѱ޿��� �ο����� ���ϰ� �ο����� ���� ������ �����϶�.

SELECT department_id, count(*), sum(salary) FROM EMPLOYEES e 
	GROUP BY DEPARTMENT_ID 
	HAVING count(DEPARTMENT_ID) > 7
	ORDER BY cnt DESC;
	

--4. ���� ���̺��� ������ �޿��� ����� 9000 �̻��� ������ �ѱ޿��� �޿� ����� ���ϰ� ��� �޿��� ���� ������� �����Ͽ���.

SELECT job_id, count(*), avg(salary), sum(salary) FROM EMPLOYEES e 
	GROUP BY JOB_ID 
	HAVING avg(salary) >=9000
	ORDER BY avg(salary) desc;
	

--5. ���� �̷� ���̺�� �μ� ���̺��� �����ϰ� �̸� ���� id ������������ �����غ���.
SELECT * FROM JOB_HISTORY jh 
JOIN DEPARTMENTS d 
ON jh.DEPARTMENT_ID = d.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID DESC;


-- â�Ƿ� �������� ���⼭ �� ������ �������� ���߽��ϴ�...