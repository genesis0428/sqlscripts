CREATE TABLE students0(
	stuno char(7) PRIMARY KEY,
	name nvarchar2(20) NOT NULL,
	age number(3) CHECK (age BETWEEN 10 AND 30),
	address nvarchar2(50)
);

INSERT INTO students0(stuno,name,age,address)
VALUES ('2021001','����',16,'���ʱ�');
INSERT INTO students0(stuno,name,age,address)
VALUES ('2019019','������',18,'������');

CREATE TABLE scores0(
	stuno char(7) NOT null,
	subject nvarchar2(20) NOT NULL,
	jumsu number(3) NOT NULL,	
	teacher nvarchar2(20) NOT NULL,
	term char(6) NOT NULL
);

-- atler table ~ add constraint
ALTER TABLE SCORES0
		ADD CONSTRAINT pk_scores PRIMARY KEY (STUNO,SUBJECT);
ALTER TABLE SCORES0
		ADD CONSTRAINT fk_scores FOREIGN KEY (STUNO)
		REFERENCES students0(STUNO);
	
	
INSERT INTO scores0(stuno,subject,jumsu,teacher,term)
VALUES ('2021001','����',89,'�̳���','2022_1');
INSERT INTO scores0(stuno,subject,jumsu,teacher,term)
VALUES ('2021001','����',78,'��浿','2022_1');
INSERT INTO scores0(stuno,subject,jumsu,teacher,term)
VALUES ('2021001','����',67,'�ڼ���','2021_2');
INSERT INTO scores0(stuno,subject,jumsu,teacher,term)
VALUES ('2019019','����',92,'�̳���','2019_2');
INSERT INTO scores0(stuno,subject,jumsu,teacher,term)
VALUES ('2019019','����',85,'������','2019_2');
INSERT INTO scores0(stuno,subject,jumsu,teacher,term)
VALUES ('2019019','����',88,'�ڼ���','2020_1');
