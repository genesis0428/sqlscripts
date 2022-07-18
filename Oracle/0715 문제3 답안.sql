--작성자 : 이광호

--1)

INSERT INTO TBL_POSTCODE(postcode, area1) VALUES (137964, '서울특별시 서초구 서초2동');
INSERT INTO TBL_POSTCODE(postcode, area1) VALUES (138761, '서울특별시 송파구 장지동 409880');
INSERT INTO TBL_POSTCODE(postcode, area1) VALUES (412510, '경기도 고양시 덕양구 벽제동');
INSERT INTO TBL_POSTCODE(postcode, area1) VALUES (409880, '인천광역시 옹진군 자월면');

--2)

UPDATE tbl_custom# SET postcode = 137964 WHERE CUSTOM_ID = 'mina012';
UPDATE tbl_custom# SET postcode = 412510 WHERE CUSTOM_ID = 'hongGD';
UPDATE tbl_custom# SET postcode = 409880 WHERE CUSTOM_ID = 'wonder';
UPDATE tbl_custom# SET postcode = 138761 WHERE CUSTOM_ID = 'sana';

--3)

CREATE VIEW v_custom_info
	AS SELECT tc.CUSTOM_ID , tc.POSTCODE , tp.AREA1 FROM "TBL_CUSTOM#" tc , TBL_POSTCODE tp WHERE tc.POSTCODE = tp.POSTCODE ;
	
SELECT * FROM v_custom_info;