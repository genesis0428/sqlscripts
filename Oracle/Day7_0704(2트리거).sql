-- �����ͺ��̽� Ʈ���� : insert, update, delete �� �� �����ϴ� ���ν���
-- 			Ư�� ���̺� �����ִ� ��ü

CREATE OR REPLACE TRIGGER secure_custom
BEFORE UPDATE OR DELETE ON tbl_custom
BEGIN
	IF to_char(sysdate, 'HH24:MI') BETWEEN '13:00' AND '15:00' THEN
		raise_application_error(-20000, '���� ���� 1��~3�ô� �۾��� �� �����ϴ�.');
	END IF;
END;
--Ʈ���� ���� �׽�Ʈ
DELETE FROM TBL_CUSTOM tc WHERE CUSTOM_ID ='momo';

-- Ʈ���� ��Ȱ��ȭ : disable, Ȱ��ȭ : enable
ALTER TRIGGER secure_custom enable;

-- Ʈ���ſ� �ʿ��� ���̺� ������ ����
CREATE table tbl_temp
AS
SELECT * FROM tbl_buy WHERE CUSTOM_ID ='0';
-- Ʈ���� ����(����)
CREATE OR REPLACE TRIGGER cancel_buy
AFTER DELETE ON tbl_buy
FOR EACH ROW		-- ����(����)���� ���� ���� ���϶�, : OLD UPDATE �Ǵ� DELETE �ϱ� �� ��, : NEW�� INSERT �� ��
BEGIN 
	-- ���� ���(tbl_buy ���̺��� ����)�� ������ tbl_temp �ӽ����̺� insert : ���� �࿡ ���� �۾�(�� Ʈ����)
	INSERT INTO tbl_temp
	VALUES
	(:OLD.custom_id, :OLD.pcode, :OLD.quantity, :OLD.buy_date, :OLD.buyno);
END;
-- Ʈ���� ���� �׽�Ʈ
DELETE FROM TBL_BUY tb WHERE CUSTOM_ID = 'wonder';
SELECT * FROM TBL_TEMP;



-- �߰� view ���� ����
-- grant resource, connect to c##idev -> ����� view ���� ������ �����ϴ�.
-- grant create view to c##idev;	-> �� �������� ���� ���� ����� ���� �ο����ش�.
CREATE VIEW v_buy
AS

SELECT tb.CUSTOM_ID , tb.pcode , tc.name, tc.email,tb.QUANTITY 
FROM tbl_buy tb, tbl_custom tc
WHERE tb.CUSTOM_ID = tc.CUSTOM_ID ;
