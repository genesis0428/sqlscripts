CREATE TABLE students#(
	st_number char(7) PRIMARY KEY,
	st_name nvarchar2(100) NOT NULL,
	st_age number(3),
	st_addr nvarchar2(100)
);

INSERT INTO "STUDENTS#" VALUES (2021001,'김모모',16,'서초구');
INSERT INTO "STUDENTS#" VALUES (2019019,'강다현',18,'강남구');


CREATE TABLE scores#(
	st_nubmer char(7) NOT NULL,
	subject nvarchar2(100) NOT NULL,
	score NUMBER(3) NOT NULL,
	sub_teacher nvarchar2(100) NOT NULL,
	semester varchar2(10) NOT NULL
	);
	
INSERT INTO "SCORES#" VALUES (2021001,'국어',89,'이나연','2022_1');
INSERT INTO "SCORES#" VALUES (2021001,'영어',78,'김길동','2022_1');
INSERT INTO "SCORES#" VALUES (2021001,'과학',89,'박세리','2021_2');
INSERT INTO "SCORES#" VALUES (2019019,'국어',92,'이나연','2019_2');
INSERT INTO "SCORES#" VALUES (2019019,'영어',85,'박지성','2019_2');
INSERT INTO "SCORES#" VALUES (2019019,'과학',88,'박세리','2020_1');
INSERT INTO "SCORES#" VALUES (2019020,'국어',88,'이나연','2020_1');