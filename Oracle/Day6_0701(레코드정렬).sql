-- select 기본형식
-- select 컬럼1, 컬럼2, ... from 테이블명 where 검색조건식 
--								order by 기준컬럼 (내림 : desc)

SELECT * FROM tbl_buy tb;
SELECT * FROM TBL_CUSTOM tc ;
SELECT * FROM TBL_CUSTOM tc ORDER BY CUSTOM_ID ;
SELECT * FROM TBL_buy tb WHERE CUSTOM_ID = 'mina012';
SELECT * FROM TBL_Buy tb WHERE CUSTOM_ID = 'mina012'
				ORDER BY BUY_DATE DESC;			-- WHERE , ORDER BY 순서 지키기.
-- 조회할 컬럼 지정할 때 distinct 키워드 : 중복값은 1번만 결과 출력
SELECT custom_id FROM TBL_BUY tb;
SELECT DISTINCT custom_id FROM tbl_buy tb ;			--중복값은 1번만	