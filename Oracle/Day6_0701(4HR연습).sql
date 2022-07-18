-- HR 스키마를 이용하여 조인과 group by 를 포함해서 select로 검색하는 문제를 10개 만들기
-- group by 결과로도 조인을 할 수 있습니다. 예시 : 부서인원이 가장 많은 부서는?

-- 주석으로 검색하는 내용 쓰고
-- select 쿼리 작성하세요

-- jobs 테이블
	--1)min salary 컬럼이 10000 이상인 Job_title 조회
		SELECT job_title FROM JOBS j WHERE MIN_SALARY >=10000;
	--2)job_title 컬럼이 programmer 인 행의 모든 컬럼 조회
		SELECT * FROM JOBS j WHERE job_title = 'programmer';
		SELECT * FROM JOBS j WHERE job_title = 'Programmer';
		-- 대소문자 상관없이 조건 검색한다면 문자열 관련 오라클 함수 : upper(), lower() 이용합니다.
		SELECT * FROM JOBS j WHERE upper(job_title) = 'Programmer';
		SELECT * FROM JOBS j WHERE lower(job_title) = 'programmer';
	
	--3)max_salary 필드값의 최대 컬럼값 조회
		SELECT max(max_salary) FROM JOBS j ;
	

--locations 테이블
	--1)city 컬럼이 London 인 postal_code 조회
		SELECT postal_code FROM LOCATIONS l WHERE city = 'London';
		SELECT postal_code FROM LOCATIONS l WHERE city = 'Seattle';
	
	--2)LOCATIONAL_ID 컬럼이 1700, 2700, 2500이 아니고 city 컬럼이 Tokyo인 행의 모든 컬럼 조회
	SELECT * FROM LOCATIONS l WHERE LOCATION_ID NOT IN (1700, 2700, 2500) AND city ='Tokyo';



-- Jonathon Taylor 의 근무 이력 확인하기
SELECT * FROM EMPLOYEES e JOIN JOB_HISTORY jh ON e.EMPLOYEE_ID =jh.EMPLOYEE_ID 
AND FIRST_NAME = 'Jonathon' AND LAST_NAME = 'Taylor';

-- 통계 함수(집계함수) : employees 테이블
SELECT count(*) FROM EMPLOYEES e ;		-- 총개수 : 107
SELECT count(*) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';		-- 조건 job_id 직원수 : 5

SELECT avg(salary) FROM EMPLOYEES e ;		-- 직원 평균 급여 : 6461.83
SELECT avg(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';		-- 조건 job_id 평균급여 : 5760

SELECT max(salary) FROM EMPLOYEES e ;		-- 직원 중 최고 급여 : 24,000
SELECT max(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';		-- 조건 job_id 최고급여 : 9000

SELECT min(salary) FROM EMPLOYEES e ;		-- 직원 중 최소 급여 : 2,100
SELECT min(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';		-- 조건 job_id 최고급여 : 4200


-- 부서 테이블과 직원 테이블 join
SELECT count(*) FROM EMPLOYEES e2, DEPARTMENTS d2 WHERE e2.DEPARTMENT_ID = d2.DEPARTMENT_ID ;
SELECT count(*) FROM EMPLOYEES e JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID ;

-- 부서명 'Sales' 의 직원들 인원수 조회하기
SELECT count(*) FROM EMPLOYEES e JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 
AND department_name = 'Sales';

-- jobs 테이블 : min_salary 가 평균보다 작은 job에 대한 정보
SELECT avg(MIN_SALARY) FROM JOBS j ;
SELECT job_id, job_title, MIN_SALARY FROM JOBS j 
WHERE MIN_SALARY < (SELECT avg(MIN_SALARY) FROM JOBS j);

-- 아래 명령은 오류 -> 그룹함수는 반드시 select 문으로 사용합니다. *
SELECT job_id, job_title, MIN_SALARY FROM JOBS j 
WHERE MIN_SALARY < avg(MIN_SALARY);

-- 서브 쿼리 필요한 예시 : 동일한 테이블 대상
-- 최소 급여를 받는 사람의 first_name, last_name 컬럼 조회하기
SELECT first_name, last_name, SALARY FROM EMPLOYEES e 
WHERE SALARY = (SELECT min(SALARY) FROM EMPLOYEES e WHERE job_id = 'IT_PROG');


SELECT min(SALARY) FROM EMPLOYEES e WHERE job_id = 'IT_PROG';
--job_id 가 'IT_PROG'가 아닌 것 조회
SELECT min(SALARY) FROM EMPLOYEES e WHERE JOB_ID <> 'IT_PROG';
SELECT MIN(SALARY) FROM EMPLOYEES e WHERE NOT JOB_ID = 'IT_PROG';	--** 


--부서별 평균급여롤 조회합니다. 정렬은 평균급여 내림차순으로 부서_ID, 부서명, 평균급여 (소수점 1자리로 반올림)
--오라클 소수점 관련 함수 : round(반올림), trunc(버림), ceil(내림)

--그룹함수 조회할 때 group by 를 써야 그룹바이에 쓴 컬럼을 select로 조회할 수 있습니다.
--		그룹바이 컬럼외에는 다른 컬럼 select 할 수 없습니다. -> join, 서브쿼리
--1단계 : 사용할 그룹함수 실행하기
SELECT DEPARTMENT_ID , avg(salary) FROM EMPLOYEES e GROUP BY DEPARTMENT_ID ;

--2단계 : 조인하기
SELECT * FROM DEPARTMENTS d JOIN
		(SELECT DEPARTMENT_ID, avg(salary) cavg FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
		ON d.DEPARTMENT_ID = tavg.DEPARTMENT_ID;

--3단계 : 컬럼 지정하기
SELECT d.DEPARTMENT_ID, d.DEPARTMENT_NAME, round(tavg.cavg,1) FROM DEPARTMENTS d 
		JOIN
		(SELECT DEPARTMENT_ID, avg(salary) cavg FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
		ON d.DEPARTMENT_ID = tavg.DEPARTMENT_ID
		ORDER BY tavg.cavg DESC;

--4단계 : 정렬한 결과로 특정 위치 지정 : first n은 상위 n개를 조회
SELECT d.DEPARTMENT_ID ,d.DEPARTMENT_NAME ,round(tavg.cavg,1) FROM DEPARTMENTS d 
		JOIN
		(SELECT DEPARTMENT_ID, avg(salary) cavg FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
		ON d.DEPARTMENT_ID = tavg.DEPARTMENT_ID
		ORDER BY tavg.cavg DESC
		FETCH FIRST 1 ROWS ONLY;
	
--다른 예시
	SELECT d.DEPARTMENT_ID did, d.department_name ,e.cnt
	FROM DEPARTMENTS d 
	JOIN 
		(SELECT DEPARTMENT_ID, count(*) cnt FROM EMPLOYEES 
		GROUP BY DEPARTMENT_ID) e
		ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
		ORDER BY cnt DESC
		FETCH FIRST 1 ROWS ONLY;
	
	
-- rownum은 가상의 컬럼으로 조회된 결과에 순차적으로 오라클이 부여하는 값입니다.
-- 			가상 컬럼 사용을 위해 join이 한번 더 필요합니다.
SELECT rownum, tcnt.*FROM
(SELECT department_id , count(*) cnt FROM EMPLOYEES 
GROUP BY DEPARTMENT_ID ORDER BY cnt DESC ) tcnt
WHERE rownum < 5 ;


SELECT rownum, tcnt.*FROM
(SELECT department_id , count(*) cnt FROM EMPLOYEES 
GROUP BY DEPARTMENT_ID ORDER BY cnt DESC ) tcnt
WHERE rownum = 1 ;

-- rownum 사용할때 결과 확인이 안되는 예시 : rownum 1부터 시작해서 찾아갈 수 있는 조건식만 가능.
-- where rownum = 3;
-- where rownum > 5;
-- 그래서 한번 더 rownum 을 포함한 조회 결과로 select 를 합니다. 이때 rownum 은 별칭부여.
SELECT *FROM
	(SELECT rownum rn,tcnt.*FROM
		(SELECT department_id, count(*) cnt FROM EMPLOYEES 
			GROUP BY DEPARTMENT_ID ORDER BY cnt DESC ) tcnt)
WHERE rn BETWEEN 5 AND 9;






--1. 직원(employee) 테이블을 이용하여 업무별(job_id) 인원수 및 그들의 총급여를 구하고 총급여가 많은 순으로 정렬하라.

SELECT job_id, count(*), sum(salary) FROM EMPLOYEES e 
	GROUP BY job_id
	ORDER BY sum(SALARY) DESC;
	
--2. 1번 문제에서 총급여가 5만 이상인 업무를 고르고 인원이 많은 순서대로 정렬하라.

SELECT job_id, count(*) cnt, sum(salary) FROM EMPLOYEES e 
	GROUP BY job_id
	HAVING sum(salary) >=50000
	ORDER BY cnt DESC;
	

--3. 직원 테이블에서 부서별 인원이 7명 이상인 부서의 총급여와 인원수를 구하고 인원수가 많은 순으로 정렬하라.

SELECT department_id, count(*), sum(salary) FROM EMPLOYEES e 
	GROUP BY DEPARTMENT_ID 
	HAVING count(DEPARTMENT_ID) > 7
	ORDER BY cnt DESC;
	

--4. 직원 테이블에서 업무별 급여의 평균이 9000 이상인 업무의 총급여와 급여 평균을 구하고 평균 급여가 높은 순서대로 정렬하여라.

SELECT job_id, count(*), avg(salary), sum(salary) FROM EMPLOYEES e 
	GROUP BY JOB_ID 
	HAVING avg(salary) >=9000
	ORDER BY avg(salary) desc;
	

--5. 직원 이력 테이블과 부서 테이블을 조인하고 이를 직원 id 오름차순으로 정렬해보자.
SELECT * FROM JOB_HISTORY jh 
JOIN DEPARTMENTS d 
ON jh.DEPARTMENT_ID = d.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID DESC;


-- 창의력 부족인지 여기서 더 문제를 만들지는 못했습니다...