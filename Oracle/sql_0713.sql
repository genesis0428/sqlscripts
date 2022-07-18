create table book_member(
    mem_idx number(5) primary key,
    name varchar2(20) not null,
    email varchar2(20) not null,
    tel varchar2(20) unique,
    password varchar2(10)
    );

create table tbl_book(
    bcode char(5) primary key,
    title varchar2(30) not null,
    writer varchar2(20),
    publisher varchar2(20),
    pdate date
    );

create table tbl_bookrent(
   rent_no number(5) not null primary key,
   mem_idx number(5) not null,
   bcode char(5) not null,
   rent_date date not null,
   exp_date date not null,
   return_date date,
   delay_days number(3),
   foreign key(mem_idx) references book_member(mem_idx),
   foreign key(bcode) references tbl_book(bcode)
   );

create sequence memberindex_seq start with 10001;
create sequence rentnumber_seq start with 1;


insert into book_member(mem_idx,name,email,tel,password) values (memberindex_seq.nextval,'���ϴ�','honey@naver.com','010-9889-0567',1122);

insert into book_member(mem_idx,name,email,tel,password) values (memberindex_seq.nextval,'�̼���','jong@daum.net','010-2354-6773',2345);

insert into book_member(mem_idx,name,email,tel,password) values (memberindex_seq.nextval,'�����','lucky@korea.com','010-5467-8792',9876);

insert into book_member(mem_idx,name,email,tel,password) values (memberindex_seq.nextval,'���浿','nadong@kkk.net','010-3456-8765',3456);

insert into book_member(mem_idx,name,email,tel,password) values (memberindex_seq.nextval,'������','haha@korea.net','010-3987-9087',1234);



insert into tbl_book(bcode,title,writer,publisher,pdate) values ('A1101','�ڽ���','Į���̰�','���̾𽺺Ͻ�',to_date('06/12/01','YY/MM/DD'));

insert into tbl_book(bcode,title,writer,publisher,pdate) values ('B1101','��Ŀ������','����Ŀ','��Ŀ����',to_date('18/07/10','YY/MM/DD'));

insert into tbl_book(bcode,title,writer,publisher,pdate) values ('C1101','Ǫ������ �ʹϴ�','����','â��',to_date('15/06/20','YY/MM/DD'));

insert into tbl_book(bcode,title,writer,publisher,pdate) values ('A1102','�佺Ʈ','�˺���Ʈ �','������',to_date('11/03/01','YY/MM/DD'));



insert into tbl_bookrent(rent_no,mem_idx,bcode,rent_date,exp_date,return_date) values (rentnumber_seq.nextval,10001,'B1101','2021-09-01','2021-09-15','2021-09-14');

insert into tbl_bookrent(rent_no,mem_idx,bcode,rent_date,exp_date,return_date) values (rentnumber_seq.nextval,10002,'C1101','2021-09-12','2021-09-26','2021-09-29');

insert into tbl_bookrent(rent_no,mem_idx,bcode,rent_date,exp_date,return_date) values (rentnumber_seq.nextval,10003,'B1101','2021-09-03','2021-09-17','2021-09-17');

insert into tbl_bookrent(rent_no,mem_idx,bcode,rent_date,exp_date) values (rentnumber_seq.nextval,10004,'C1101','2022-06-30','2022-07-14');

insert into tbl_bookrent(rent_no,mem_idx,bcode,rent_date,exp_date) values (rentnumber_seq.nextval,10001,'A1101','2022-07-04','2022-07-18');

insert into tbl_bookrent(rent_no,mem_idx,bcode,rent_date,exp_date,return_date) values (rentnumber_seq.nextval,10003,'A1102','2022-07-06','2022-07-20','2022-07-13');


-- �����ϱ� : '�뿩' �⺻���� ������ �뿩��¥�� ����, �ݳ������� ����+14�� �⺻������ �� �� �ֵ��� �մϴ�.
-- ALTER TABLE "C##IDEV".TBL_BOOKRENT MODIFY RENT_DATE DEFAULT sysdate;
-- ALTER TABLE "C##IDEV".TBL_BOOKRENT MODIFY EXP_DATE DEFAULT sysdate+14;
-- INSERT INTO TBL_BOOKRENT (rent_no,MEM_IDX,BCODE)
-- values(bookrent_seq.nextval,10002,'A1102');


-- �÷� ����Ʈ �� ���ְ� ���� ��
-- ALTER TABLE "C##IDEV".TBL_BOOKRENT MODIFY RENT_DATE DATE DEFAULT NULL;