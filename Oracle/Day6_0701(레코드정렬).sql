-- select �⺻����
-- select �÷�1, �÷�2, ... from ���̺�� where �˻����ǽ� 
--								order by �����÷� (���� : desc)

SELECT * FROM tbl_buy tb;
SELECT * FROM TBL_CUSTOM tc ;
SELECT * FROM TBL_CUSTOM tc ORDER BY CUSTOM_ID ;
SELECT * FROM TBL_buy tb WHERE CUSTOM_ID = 'mina012';
SELECT * FROM TBL_Buy tb WHERE CUSTOM_ID = 'mina012'
				ORDER BY BUY_DATE DESC;			-- WHERE , ORDER BY ���� ��Ű��.
-- ��ȸ�� �÷� ������ �� distinct Ű���� : �ߺ����� 1���� ��� ���
SELECT custom_id FROM TBL_BUY tb;
SELECT DISTINCT custom_id FROM tbl_buy tb ;			--�ߺ����� 1����	