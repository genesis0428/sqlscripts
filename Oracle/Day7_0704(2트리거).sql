-- 데이터베이스 트리거 : insert, update, delete 할 때 동작하는 프로시저
-- 			특정 테이블에 속해있는 객체

CREATE OR REPLACE TRIGGER secure_custom
BEFORE UPDATE OR DELETE ON tbl_custom
BEGIN
	IF to_char(sysdate, 'HH24:MI') BETWEEN '13:00' AND '15:00' THEN
		raise_application_error(-20000, '지금 오후 1시~3시는 작업할 수 없습니다.');
	END IF;
END;
--트리거 동작 테스트
DELETE FROM TBL_CUSTOM tc WHERE CUSTOM_ID ='momo';

-- 트리거 비활성화 : disable, 활성화 : enable
ALTER TRIGGER secure_custom enable;

-- 트리거에 필요한 테이블 사전에 생성
CREATE table tbl_temp
AS
SELECT * FROM tbl_buy WHERE CUSTOM_ID ='0';
-- 트리거 정의(생성)
CREATE OR REPLACE TRIGGER cancel_buy
AFTER DELETE ON tbl_buy
FOR EACH ROW		-- 만족(적용)히는 행이 여러 개일때, : OLD UPDATE 또는 DELETE 하기 전 값, : NEW는 INSERT 한 값
BEGIN 
	-- 구매 취소(tbl_buy 테이블에서 삭제)한 데이터 tbl_temp 임시테이블에 insert : 여러 행에 대한 작업(행 트리거)
	INSERT INTO tbl_temp
	VALUES
	(:OLD.custom_id, :OLD.pcode, :OLD.quantity, :OLD.buy_date, :OLD.buyno);
END;
-- 트리거 동작 테스트
DELETE FROM TBL_BUY tb WHERE CUSTOM_ID = 'wonder';
SELECT * FROM TBL_TEMP;



-- 추가 view 생성 연습
-- grant resource, connect to c##idev -> 여기는 view 생성 권한이 없습니다.
-- grant create view to c##idev;	-> 뷰 생성권한 없는 오류 생기면 권한 부여해준다.
CREATE VIEW v_buy
AS

SELECT tb.CUSTOM_ID , tb.pcode , tc.name, tc.email,tb.QUANTITY 
FROM tbl_buy tb, tbl_custom tc
WHERE tb.CUSTOM_ID = tc.CUSTOM_ID ;
