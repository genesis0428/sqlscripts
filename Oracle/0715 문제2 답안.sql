--작성자 : 이광호

--데이터 삽입하기

INSERT INTO tbl_custom#(custom_id,name,email,age,reg_date) VALUES ('mina012','김미나','kimm@gmail.com',20,'20220207150306');
INSERT INTO tbl_custom#(custom_id,name,email,age,reg_date) VALUES ('hongGD','홍길동','gil@korea.com',32,'20220207150306');
INSERT INTO tbl_custom#(custom_id,name,email,age,reg_date) VALUES ('twice','박모모','momo@daum.net',39,'20220205000000');
INSERT INTO tbl_custom#(custom_id,name,email,age,reg_date) VALUES ('wonder','이나나','nana@korea.kr',23,'20220205000000');
INSERT INTO tbl_custom#(custom_id,name,email,age,reg_date) VALUES ('sana','최사나','unknown',22,'20220209151924');

INSERT INTO tbl_product#(pcode,category,pname,price) VALUES ('CJ-BABQ1','B1','CJ햇반잡곡밥SET',26000);
INSERT INTO tbl_product#(pcode,category,pname,price) VALUES ('DOWON123a','B1','동원참치선물세트',54000);
INSERT INTO tbl_product#(pcode,category,pname,price) VALUES ('dk_143','A2','모션데스크',234500);
INSERT INTO tbl_product#(pcode,category,pname,price) VALUES ('IPAD011','A1','아이패드10',880000);
INSERT INTO tbl_product#(pcode,category,pname,price) VALUES ('GAL0112','A1','갤럭시20',912300);
INSERT INTO tbl_product#(pcode,category,pname,price) VALUES ('CHR-J59','A2','S체어',98700);

INSERT INTO tbl_buy#(buy_seq,custom_id,pcode,quantity,buy_date) VALUES (29,'mina012','IPAD011',1,'220206000000');
INSERT INTO tbl_buy#(buy_seq,custom_id,pcode,quantity,buy_date) VALUES (30,'hongGD','IPAD011',2,'220208155508');
INSERT INTO tbl_buy#(buy_seq,custom_id,pcode,quantity,buy_date) VALUES (31,'wonder','DOWON123a',3,'220206000000');
INSERT INTO tbl_buy#(buy_seq,custom_id,pcode,quantity,buy_date) VALUES (32,'mina012','dk_143',1,'220208155508');
INSERT INTO tbl_buy#(buy_seq,custom_id,pcode,quantity,buy_date) VALUES (33,'twice','DOWON123a',2,'220207000000');
INSERT INTO tbl_buy#(buy_seq,custom_id,pcode,quantity,buy_date) VALUES (63,'hongGD','dk_143',1,'220211000000');
INSERT INTO tbl_buy#(buy_seq,custom_id,pcode,quantity,buy_date) VALUES (61,'twice','CHR-J59',2,'220212000000');
INSERT INTO tbl_buy#(buy_seq,custom_id,pcode,quantity,buy_date) VALUES (62,'hongGD','CJ-BABQ1',4,'220211000000');


--1)

SELECT buy_seq,custom_id,pcode,quantity,buy_date FROM tbl_buy# WHERE buy_date >= to_date('220211');

--2)

SELECT pcode, pname, price FROM tbl_product# WHERE price = (SELECT max(price) FROM tbl_product#);

--3)

SELECT category, max(price) FROM tbl_product# GROUP BY category ORDER BY category;

--4)

SELECT tc.CUSTOM_ID,tc.NAME ,tb.QUANTITY FROM "TBL_CUSTOM#" tc ,"TBL_BUY#" tb 
WHERE tc.CUSTOM_ID = tb.CUSTOM_ID AND pcode = 'IPAD011';

--5)

SELECT CUSTOM_ID , NAME , AGE FROM "TBL_CUSTOM#" , "TBL_BUY#" tb WHERE -- 잘 모르겠습니다.

--6)

SELECT buy_date, sum(quantity) -- 잘 모르겠습니다.