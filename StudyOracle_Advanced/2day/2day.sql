-- 2day

-- ȸ������ ��ü ��ȸ

SELECT * 
    FROM member ;

-- ��̰� ������ ȸ���� �߿� ���ϸ����� ���� 1000 �̻��� 
-- ȸ�����̵�, ȸ���̸�, ȸ�����, ȸ�����ϸ��� ��ȸ
-- ������ ȸ���̸� ���� ��������

SELECT mem_id, mem_name, mem_like, mem_mileage
    FROM member
        WHERE mem_mileage >= 1000
            ORDER BY mem_name ASC;