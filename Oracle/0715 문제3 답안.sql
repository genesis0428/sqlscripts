--�ۼ��� : �̱�ȣ

--1)

INSERT INTO TBL_POSTCODE(postcode, area1) VALUES (137964, '����Ư���� ���ʱ� ����2��');
INSERT INTO TBL_POSTCODE(postcode, area1) VALUES (138761, '����Ư���� ���ı� ������ 409880');
INSERT INTO TBL_POSTCODE(postcode, area1) VALUES (412510, '��⵵ ���� ���籸 ������');
INSERT INTO TBL_POSTCODE(postcode, area1) VALUES (409880, '��õ������ ������ �ڿ���');

--2)

UPDATE tbl_custom# SET postcode = 137964 WHERE CUSTOM_ID = 'mina012';
UPDATE tbl_custom# SET postcode = 412510 WHERE CUSTOM_ID = 'hongGD';
UPDATE tbl_custom# SET postcode = 409880 WHERE CUSTOM_ID = 'wonder';
UPDATE tbl_custom# SET postcode = 138761 WHERE CUSTOM_ID = 'sana';

--3)

CREATE VIEW v_custom_info
	AS SELECT tc.CUSTOM_ID , tc.POSTCODE , tp.AREA1 FROM "TBL_CUSTOM#" tc , TBL_POSTCODE tp WHERE tc.POSTCODE = tp.POSTCODE ;
	
SELECT * FROM v_custom_info;