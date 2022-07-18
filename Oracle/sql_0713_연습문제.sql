/*
 * [[[[���� �뿩 ó�� ����]]]]
 * - ȸ���� �� 1���� å�� �뿩�� �� �ִ�.
 * - �뿩�Ѵ� : rent_date�� �뿩����, exp_date�� �ݳ����������̸� rent_date + 14  
 * - �ݳ��Ѵ� : return_date�� �ݳ�����, delay_days�� ��ü�ϼ� return date - exp date
 * return_date �� null�̸� �뿩��, null�� �ƴϸ� �ݳ��� ����
 */

--1) ������ �߰��մϴ�. ��B1102�� , ����Ʈ����ũ �����⡯, ����ö���� ,��KBO�� , ��2020-11-10����

INSERT INTO tbl_book(bcode,title,writer,publisher,pdate) VALUES ('B1102','��Ʈ����ũ ������','��ö��','KBO',to_date('20/11/10','YY/MM/DD'));

--2) �ݳ��� ������ ��ü�ϼ��� ����Ͽ� delay_days �÷����� update �մϴ�.

UPDATE TBL_BOOKRENT SET DELAY_DAYS = RETURN_DATE - EXP_DATE 
WHERE RETURN_DATE IS NOT NULL;
SELECT * FROM TBL_BOOKRENT tb ;	

--3) ���� ���� ������ ��ü�ϼ��� ����Ͽ� ȸ��IDX, �����ڵ�, ��ü�ϼ� ��ȸ�ϱ�
--   ���ó�¥ sysdate�� ����� ������ �������� �ʾ� �׳��ϸ� long������ ����.
SELECT mem_idx, bcode, to_date(to_char(SYSDATE,'yyyy-MM-dd')) - exp_date FROM TBL_BOOKRENT tb WHERE RETURN_DATE IS NULL;

--4) ���� ��ü ���� ȸ���� �̸�,��ȭ��ȣ�� �˻��մϴ�. ���� ��¥ sysdate �������� Ȯ���ϱ�
--   ����������� ��ü ���� ���� �ݳ����� < ���糯¥
SELECT name, tel FROM BOOK_MEMBER bm JOIN TBL_BOOKRENT tb 
ON bm.MEM_IDX = tb.MEM_IDX AND SYSDATE > exp_date AND RETURN_date IS NULL;

--5) ���� �������� ������ �������ڵ�� ������ �˻��մϴ�.

SELECT tb.BCODE , title FROM TBL_BOOK tb JOIN TBL_BOOKRENT tb2
ON tb.BCODE = tb2.BCODE AND RETURN_date IS NULL;

--6) ���� ������ �뿩�� ȸ���� IDX�� ȸ���̸��� �˻��մϴ�.

SELECT bm.mem_idx , name FROM BOOK_MEMBER bm JOIN TBL_BOOKRENT tb 
ON bm.MEM_IDX = tb.MEM_IDX AND return_date IS NULL;

--7) �������� ������ ȸ���̸�, ������, �ݳ����� �˻��մϴ�.

SELECT bm.name, tb.title, tb2.exp_date FROM BOOK_MEMBER bm , TBL_BOOK tb , TBL_BOOKRENT tb2 
WHERE bm.MEM_IDX  = tb2.MEM_IDX  AND tb.bcode = tb2.BCODE AND tb2.RETURN_DATE IS NULL;

-- �Ǵ�

SELECT name, title, exp_date FROM TBL_BOOKRENT tb 
JOIN TBL_BOOK tb2 ON tb2.BCODE = tb.BCODE 
JOIN BOOK_MEMBER bm ON tb.MEM_IDX = bm.MEM_IDX 
WHERE RETURN_DATE IS NULL;

--8) ���� ��ü ���� ������ ȸ��IDX, �����ڵ�, �ݳ������� �˻��մϴ�.

SELECT mem_idx,bcode,exp_date FROM TBL_BOOKRENT tb 
WHERE SYSDATE > exp_date;

--9) ȸ��  IDX ��10002���� ���� ������ �������� ���ν����� �ۼ��մϴ�.

	-- ��ȸ������ �����ϴ� ���ν���
DECLARE
	vcnt NUMBER;
BEGIN
	SELECT count(*) 
	INTO vcnt	-- SELECT ��ȸ ��� ������ ����. ������ , �� ������ �� ����.
	FROM TBL_BOOKRENT tb 
	WHERE MEM_IDX = 10002 AND RETURN_DATE IS NULL;	--rcnt �� 0�϶��� �뿩����
	IF (vcnt = 0) THEN
		DBMS_OUTPUT.put_line('å �뿩 �����մϴ�.');
	ELSE 
		DBMS_OUTPUT.put_line('�뿩 ���� å�� �ݳ��ؾ� �����մϴ�.');
	END IF;
END;

	-- ���ν��� ����Ŭ ��ü
	CREATE OR REPLACE PROCEDURE check_member(
			arg_mem IN book_member.MEM_IDX%TYPE,	--���ν��� ������ �� ���� ���� �Ű�����
			isOK OUT varchar2						-- �ڹ��� ���ϰ��� �ش��ϴ� �κ�.
	)
	IS 
			vcnt NUMBER;
			vname varchar2(100);
	BEGIN
		-- �Է¸Ű������� ���� ȸ���ΰ��� Ȯ���ϴ� sql�� exception ó��. arg_mem���� ȸ�����̺��� name ��ȸ
		--		������ exception ó��
			SELECT name INTO vname
				FROM BOOK_MEMBER bm WHERE MEM_IDX = arg_mem;
		
			SELECT count(*) 
			INTO vcnt
			FROM TBL_BOOKRENT tb 
			WHERE MEM_IDX = arg_mem AND RETURN_DATE IS NULL;	--vcnt �� 0�϶��� �뿩����
			IF (vcnt = 0) THEN
				DBMS_OUTPUT.put_line('å �뿩 �����մϴ�.');
				isOK :='����';
			ELSE 
				DBMS_OUTPUT.put_line('�뿩 ���� å�� �ݳ��ؾ� �����մϴ�.');
				isOK :='�Ұ���';
			END IF;
		EXCEPTION
		WHEN no_data_found THEN   
		DBMS_OUTPUT.PUT_LINE('ã�� ȸ���� �����ϴ�.');
		isOK :='no match';
	END;

	-- ���ν��� �����ϱ�
	DECLARE
		vresult varchar2(20);
	BEGIN
		CHECK_member(10004,vresult);
		DBMS_OUTPUT.put_line('��� : ' || vresult);
	END;


--10) ������ ���佺Ʈ�� ��� ���ڰ� ���� ������ �˻��Ͽ� ���� ������ �������� ���ν����� �ۼ��մϴ�. ���ν����̸��� check_book

DECLARE
	v_bcode varchar2(100);
	v_cnt NUMBER;
BEGIN
	SELECT bcode INTO v_bcode	-- v_bcode�� 'A1102'
		FROM TBL_BOOK tb WHERE title = '�佺Ʈ';
	SELECT count(*) INTO v_cnt		-- v_cnt ���� 1�̸� v_bcode å�� ������
	FROM TBL_BOOKRENT tb2 WHERE BCODE = v_bcode AND RETURN_DATE IS NULL;
	IF (v_cnt = 1) THEN
		DBMS_OUTPUT.put_line('�뿩 ���� å�Դϴ�.');
	ELSE
		DBMS_OUTPUT.put_line('å �뿩 �����մϴ�');
	END IF;
END;


--

-- ���ν��� ����Ŭ ��ü
	CREATE OR REPLACE PROCEDURE check_book(
			arg_book IN tbl_book.title%TYPE,	--���ν��� ������ �� ���� ���� �Ű�����
			isOK OUT varchar2						-- �ڹ��� ���ϰ��� �ش��ϴ� �κ�.
	)
	IS 
			v_bcode varchar2(100);
			v_cnt NUMBER;
	BEGIN
		SELECT bcode  INTO v_bcode		-- v_bcode�� 'A1102'
			FROM TBL_BOOK tb WHERE title = arg_book; 
		-- ���� å�̸� �Է��ϸ� ����. bcode ���� �˻��� �ȵ˴ϴ�. -> Exception 
		SELECT count(*) INTO v_cnt		-- v_cnt ���� 1�̸� v_bcode å�� ������
				FROM TBL_BOOKRENT tb2 WHERE BCODE = v_bcode AND return_date IS NULL;
			IF (v_cnt = 1) THEN
				DBMS_OUTPUT.put_line('�뿩 ���� å�Դϴ�.');
				isOK :='FALSE';
			ELSE 
				DBMS_OUTPUT.put_line('å �뿩 �����մϴ�.');
				isOK :='TRUE';
		END IF;
		EXCEPTION		-- ����(����)ó��
	WHEN no_data_found THEN   
		DBMS_OUTPUT.PUT_LINE('ã�� å�� �����ϴ�.');
		isOK :='no match';

	
	-- ���� å�� isOK :='no match';
	END;

-- ���ν��� �����ϱ�
	DECLARE
		vresult varchar2(100);
	BEGIN
		check_book('��Ʈ����ũ',vresult);				-- �ڽ���, Ǫ������ �ʹϴϴ� FALSE
		DBMS_OUTPUT.put_line('��� : ' || vresult);
	END;