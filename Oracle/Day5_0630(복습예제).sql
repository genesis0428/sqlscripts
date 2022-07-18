CREATE TABLE tbl_custom (
	custom_id varchar2(20) PRIMARY KEY,
	name nvarchar2(20) NOT NULL,
	email varchar2(20),
	age number(3),
	reg_date DATE DEFAULT sysdate
);

-- ��ǰ ���̺� : ī�װ� ���� A1 : ������ǰ, B1 : ��ǰ

CREATE TABLE tbl_product(
	pcode varchar2(20) PRIMARY KEY,
	category char(2) NOT NULL,
	pname nvarchar2(20) NOT NULL,
	price number(9) NOT NULL
);

-- ���� ���̺� : ��� ���� ���� ��ǰ�� �����ϴ°�?

CREATE TABLE tbl_buy(
	custom_id varchar2(20) NOT NULL,
	pcode varchar2(20) NOT NULL,
	quantity number(5) NOT NULL, -- ����
	buy_date DATE DEFAULT sysdate
); 
--Date ���Ŀ� �����Ǵ� ���� �����ϱ� -> insert �Ҷ� to_date �Լ� ��������
-- ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

INSERT INTO TBL_CUSTOM VALUES ('mina012','��̳�','kimm@gmail.com',20,to_date('2022-03-10 14:23:25','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO TBL_CUSTOM VALUES ('hongGD','ȫ�浿','gil@korea.com',32,to_date('2021-10-21','yyyy-mm-dd hh24:mi'));
INSERT INTO TBL_CUSTOM VALUES ('twice','�ڸ��','momo@daum.net',29,to_date('2021-12-25 19:23:45','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO TBL_CUSTOM VALUES ('wonder','�̳���','lee@naver.com',40,sysdate);

INSERT INTO TBL_PRODUCT VALUES ('IPAD011', 'A1', '�����е�10',880000);
INSERT INTO TBL_PRODUCT VALUES ('DOWON123a', 'B1', '������ġ������Ʈ',54000);
INSERT INTO TBL_PRODUCT VALUES ('dk_143', 'A2', '��ǵ���ũ',234500);

INSERT INTO tbl_buy VALUES ('mina012','IPAD011',1,to_date('2022-02-06', 'yyyy-mm-dd hh24:mi'));
INSERT INTO tbl_buy VALUES ('hongGD','IPAD011',2,to_date('2022-06-29 20:37:47', 'yyyy-mm-dd hh24:mi:ss'));
INSERT INTO tbl_buy VALUES ('wonder','DOWON123a',3,to_date('2022-02-06', 'yyyy-mm-dd hh24:mi'));
INSERT INTO tbl_buy VALUES ('mina012','dk_143',1,sysdate);
INSERT INTO tbl_buy VALUES ('twice','DOWON123a',2,to_date('2022-02-06 08:49:5', 'yyyy-mm-dd hh:mi:ss'));

ALTER TABLE tbl_buy ADD buyno number(8);

UPDATE tbl_buy SET buyno = 1001;
UPDATE tbl_buy SET buyno = 1002 WHERE CUSTOM_ID = 'hongGD';
UPDATE tbl_buy SET buyno = 1003 WHERE CUSTOM_ID = 'wonder';
UPDATE tbl_buy SET buyno = 1004 WHERE pcode = 'dk_143';
UPDATE tbl_buy SET buyno = 1005 WHERE CUSTOM_ID ='twice';

ALTER TABLE tbl_buy ADD CONSTRAINT pk PRIMARY KEY(buyno);

ALTER TABLE tbl_buy ADD CONSTRAINT fk_custom FOREIGN KEY (custom_id)
		REFERENCES tbl_custom(custom_id);
ALTER TABLE tbl_buy ADD CONSTRAINT fk_product FOREIGN KEY (pcode)
		REFERENCES tbl_product(pcode);
	
CREATE SEQUENCE tblbuy_seq START WITH 1006;

INSERT INTO tbl_buy VALUES ('wonder','IPAD011',1,to_date('2022-05-15','yyyy-mm-dd'),tblbuy_seq.nextval);



SELECT * FROM tbl_custom WHERE age >= 30;
SELECT email FROM tbl_custom WHERE CUSTOM_ID = 'twice';
SELECT pname FROM tbl_product WHERE CATEGORY = 'A2';
SELECT MAX(price) FROM tbl_product;
SELECT sum(quantity) FROM tbl_buy WHERE pcode = 'IPAD011';
SELECT pcode, quantity, buy_date, buyno FROM tbl_buy WHERE CUSTOM_ID = 'mina012';
