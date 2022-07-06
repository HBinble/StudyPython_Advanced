--<<1������>>
-- ��ǰ�̸��� ������ �������� �����ϴ� ��ǰ�� ������ �Ҹ��� ���ð� ����� �����ϼ���
-- �Ҹ������ð��� �ֹ��� - ������
-- �Ҹ��� ���ð��� 0 ������ ������ ����
-- ���ð� ����� �Ҽ��� ��°�ڸ������� ��Ÿ�����ּ���
-- alias���� ������ǰ, �Ҹ������ð����� ��Ÿ�����ּ���

SELECT SUBSTR(prod_name, 1,2) AS ������ǰ,
   ROUND(AVG((CAST(SUBSTR(cart_no, 1, 8) AS date) - buy_date)),2) AS �Ҹ������ð�
  FROM prod, cart, buyprod
 WHERE buy_prod = prod_id
   AND cart_prod = prod_id
   AND (prod_name LIKE '����%' OR prod_name LIKE '����%')
   AND (CAST(SUBSTR(cart_no, 1, 8) AS date) - buy_date) > 0
 GROUP BY SUBSTR(prod_name, 1,2);
 
 

-- ���1
SELECT SUBSTR(prod_name, 1,2) AS ������ǰ, 
       AVG(SUBSTR(cart_no,1,8)- TO_CHAR(buy_date, 'yyyymmdd'))
  FROM prod, cart, buyprod
 WHERE buy_prod = prod_id
   AND cart_prod = prod_id
   AND (prod_name LIKE '����%' OR prod_name LIKE '����%')
   AND (SUBSTR(cart_no,1,8)- TO_CHAR(buy_date, 'yyyymmdd')) >0 
 GROUP BY SUBSTR(prod_name, 1,2);

-- ���2    
SELECT SUBSTR(prod_name, 1,2) AS ������ǰ,
   ROUND(AVG((SUBSTR(cart_no,1,8)- TO_CHAR(buy_date, 'yyyymmdd'))),2) AS �Ҹ������ð�
  FROM prod, cart, buyprod
 WHERE buy_prod = prod_id
   AND cart_prod = prod_id
   AND (prod_name LIKE '����%' OR prod_name LIKE '����%')
   AND (SUBSTR(cart_no,1,8)- TO_CHAR(buy_date, 'yyyymmdd')) > 0
 GROUP BY SUBSTR(prod_name, 1,2);


/*
 1. ���ݱ��� ȸ������ �����ߴ� �ֹ��� ���ϸ����� �������ִ� �̺�Ʈ�� �Ѵٰ� �մϴ�.
������� ������ ��ǰ ������ŭ ���ϸ����� ����, ������ �ִ� ���ϸ����� ���ؼ� ȸ����ȣ ���� ���� ������ �����ּ���
��ȸ�ϴ� �÷��� ȸ����ȣ, ȸ����, ������ �ִ� ���ϸ���, 
�̺�Ʈ�� �����Ǵ� ���ϸ���(�÷����� eve_mile�� ��Ī), ���� ���ϸ���(�÷����� total�� ��Ī)
��ǰ ���̺��� ��ǰ ���ϸ��� �÷��� ������Ʈ�Ͽ� �̿����ּ���.(���ϸ��� �������� 5%)
�������� ��ȣ�� ���ؼ� ȸ������ �߰� ���ڴ� *�� �ٲ��ּ���
ȸ����ȣ ������ �������� ����
*/

SELECT *
  FROM prod;

















