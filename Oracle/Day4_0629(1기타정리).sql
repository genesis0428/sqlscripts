-- DDL : create, alter, drop, TRUNCATE 
-- (����� user, table, sequence, view ... �� truncate �� ���̺� ���)
-- DML : insert, update, delete

DROP TABLE SCORES0;		-- ���� : students0 ���̺� ���� �����ϸ�
		-- ���� : �ܷ� Ű�� ���� �����Ǵ� ����/�⺻ Ű�� ���̺� �ֽ��ϴ�.
DROP TABLE STUDENTS0;

-- UPDATE ���̺�� SET �÷��� = ��, �÷��� = ��, �÷��� = ��, ... 
-- WHERE �����÷� �����
--delete from ���̺�� where �����÷������
-- ������ �� : update�� delete�� where ���� ����ϴ� ���� ������ ����.
--				truncate�� ������ ����� �� ���� ������ ddl�� ���մϴ�.
-- update, delete, select ���� where�� �÷��� �⺻Ű �����̸� 
-- ����Ǵ� ����  �ִ� 1��
-- �⺻Ű�� ������ ���̺��� ���� ����� ����(�ĺ�)�ϴ°�.
UPDATE STUDENTS0 SET age = 17 WHERE STUNO = 2021001;

-- rollback commit �׽�Ʈ (�����ͺ��̽� �޴����� Ʈ����� ��带 manual�� �����մϴ�.)
UPDATE STUDENTS0 SET ADDRESS = '���ϱ�', age =16 WHERE STUNO = 2021001;
ROLLBACK;	--���� UPDATE ������ ���
SELECT * FROM STUDENTS0 ;	-- ektl '���ʱ�' 17���� ����
UPDATE STUDENTS0 SET address = '���ϱ�', age = 16 WHERE stuno = 2021001;
COMMIT;
SELECT * FROM STUDENTS0 ;	-- '���ϱ�', 16���� �ݿ���.
ROLLBACK;
SELECT * FROM students0 ; 	-- �̹� COMMIT�� �� ��ɾ�� ROLLBACK ����
----------------------------------------------------�������
-- Ʈ����� ������� : rollback, commit



DELETE FROM SCORES0 ;
ROLLBACK;
SELECT * FROM SCORES0 ;
DELETE FROM SCORES0 WHERE stuno = 2019019;
SELECT * FROM SCORES0 ;
--38���� ����������
-- �� ������� Ʈ����� ���� ����̰� ���� â������ select ����� 2019019�� �����ϴ�.
-- �ٸ� ������� �ٸ� Ŭ���̾�Ʈ�̹Ƿ� ���� ����(���� Ŀ���� ����)�� �������ϴ�.
ROLLBACK;
SELECT * FROM SCORES0 ;
------------------------------------------------------������� �ι�° ����
TRUNCATE TABLE SCORES0 ;			-- ��� �����͸� �����. rollback�� �ǳ�? �� : �ѹ� �Ұ�
ROLLBACK;
SELECT * FROM SCORES0 ;				-- ��� �����͸� ������� Ȯ���ϸ� �ٸ��͵�� ������ �ѹ���� �ʰ� Ȯ���ϰ� TRUNCATE �ض�.
--------------------------------------------
/*
 * INSERT
 * DELETE
 * COMMIT;		(1) ���� 50 51
 * UPDATE
 * DELETE;
 * ROLLBACK;	(2) ���� 53 54
 * INSERT;
 * INSERT;
 * ROLLBACK;	(3) ���� 56 57
 * INSERT
 * UPDATE;
 * COMMIT;		(4) ���� 59 60
 * 
 */
 
SELECT * FROM STUDENTS0 s ;