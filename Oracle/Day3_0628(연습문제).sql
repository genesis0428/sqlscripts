CREATE TABLE students#(
	st_number char(7) PRIMARY KEY,
	st_name nvarchar2(100) NOT NULL,
	st_age number(3),
	st_addr nvarchar2(100)
);

INSERT INTO "STUDENTS#" VALUES (2021001,'����',16,'���ʱ�');
INSERT INTO "STUDENTS#" VALUES (2019019,'������',18,'������');


CREATE TABLE scores#(
	st_nubmer char(7) NOT NULL,
	subject nvarchar2(100) NOT NULL,
	score NUMBER(3) NOT NULL,
	sub_teacher nvarchar2(100) NOT NULL,
	semester varchar2(10) NOT NULL
	);
	
INSERT INTO "SCORES#" VALUES (2021001,'����',89,'�̳���','2022_1');
INSERT INTO "SCORES#" VALUES (2021001,'����',78,'��浿','2022_1');
INSERT INTO "SCORES#" VALUES (2021001,'����',89,'�ڼ���','2021_2');
INSERT INTO "SCORES#" VALUES (2019019,'����',92,'�̳���','2019_2');
INSERT INTO "SCORES#" VALUES (2019019,'����',85,'������','2019_2');
INSERT INTO "SCORES#" VALUES (2019019,'����',88,'�ڼ���','2020_1');
INSERT INTO "SCORES#" VALUES (2019020,'����',88,'�̳���','2020_1');