-- Oracle 12���� �̻���ʹ� �Ʒ��� �����ؾ� �Ϲ����� ���� �ۼ��� ������.

Alter session set "_ORACLE_SCRIPT"=true;

-- ���� ������ �����ѹ� ����
-- ���� ������ϸ� �Ʒ�ó�� ������ �ۼ��ؾ���

Create User c##busan_06 Identified By dbdb;



-- ���ο� DB User ���� ����(system �������� �ǽ�)

-- 1. ����� �����ϱ�(���� �۾��� ����)
Create User busan_06 Identified By dbdb;

-- �н����� �����ϱ�
Alter User busan_06 Identified By �����н�����;

-- ����� �����ϱ�
Drop User busan_06;

-- 2. ���� �ο��ϱ�
Grant Connect, Resource, DBA to busan_06;

-- ���� ȸ���ϱ�
Revoke DBA From busan_06;

