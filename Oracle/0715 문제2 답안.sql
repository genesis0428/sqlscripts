--�ۼ��� : �̱�ȣ

--������ �����ϱ�

INSERT INTO tbl_custom#(custom_id,name,email,age,reg_date) VALUES ('mina012','��̳�','kimm@gmail.com',20,'20220207150306');
INSERT INTO tbl_custom#(custom_id,name,email,age,reg_date) VALUES ('hongGD','ȫ�浿','gil@korea.com',32,'20220207150306');
INSERT INTO tbl_custom#(custom_id,name,email,age,reg_date) VALUES ('twice','�ڸ��','momo@daum.net',39,'20220205000000');
INSERT INTO tbl_custom#(custom_id,name,email,age,reg_date) VALUES ('wonder','�̳���','nana@korea.kr',23,'20220205000000');
INSERT INTO tbl_custom#(custom_id,name,email,age,reg_date) VALUES ('sana','�ֻ糪','unknown',22,'20220209151924');

INSERT INTO tbl_product#(pcode,category,pname,price) VALUES ('CJ-BABQ1','B1','CJ�޹�����SET',26000);
INSERT INTO tbl_product#(pcode,category,pname,price) VALUES ('DOWON123a','B1','������ġ������Ʈ',54000);
INSERT INTO tbl_product#(pcode,category,pname,price) VALUES ('dk_143','A2','��ǵ���ũ',234500);
INSERT INTO tbl_product#(pcode,category,pname,price) VALUES ('IPAD011','A1','�����е�10',880000);
INSERT INTO tbl_product#(pcode,category,pname,price) VALUES ('GAL0112','A1','������20',912300);
INSERT INTO tbl_product#(pcode,category,pname,price) VALUES ('CHR-J59','A2','Sü��',98700);

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

SELECT CUSTOM_ID , NAME , AGE FROM "TBL_CUSTOM#" , "TBL_BUY#" tb WHERE -- �� �𸣰ڽ��ϴ�.

--6)

SELECT buy_date, sum(quantity) -- �� �𸣰ڽ��ϴ�.