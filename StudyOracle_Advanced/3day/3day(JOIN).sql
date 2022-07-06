-- JOIN : ������ ���̺� ����

-- CROSS JOIN : FROM ���� ','�� ����(�Ϲݹ��)
SELECT *
  FROM lprod, prod;
-- ǥ�ع��
SELECT *
  FROM lprod CROSS JOIN prod;
  
-- INNER JOIN ����
-- PK�� FK�� �־�� �մϴ�.
-- �������� ���� : PK = FK
-- ���������� ����: FROM���� ���õ� (���̺��� ���� -1��)

-- ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �з����� ��ȸ
-- 1. prod, lprod
-- 2. prod_lgu = lprod_gu (PK = FK)
-- 3. lprod > prod(�и� ����)

-- <�Ϲݹ��>
SELECT prod_id, prod_name, lprod_nm, buyer_name, cart_qty, mem_name
  FROM lprod, prod, buyer,cart, member
-- �������ǽ�
 WHERE lprod_gu = prod_lgu
   AND buyer_id = prod_buyer
   AND prod_id = cart_prod
   AND mem_id = cart_member
   AND mem_id = 'a001';
   
-- <����ǥ�ع��>
SELECT prod_id, prod_name, lprod_nm, buyer_name, cart_qty, mem_name
  FROM lprod INNER JOIN prod
                ON(lprod_gu = prod_lgu)
             INNER JOIN buyer
                ON(buyer_id = prod_buyer)
             INNER JOIN cart
                ON(prod_id = cart_prod)
             INNER JOIN member
                ON(mem_id = cart_member
                   AND mem_id = 'a001');

-- ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �з���, �ŷ�ó��, �ŷ�ó�ּҸ� ��ȸ
-- 1) �ǸŰ����� 10���� �����̰�
-- 2) �ŷ�ó �ּҰ� �λ��� ��쿡�� ��ȸ
-- �Ϲݹ��, ǥ�ع�� ��� �غ���
-- 1. ���̺� ã��
-- 2. �������ǽ� ã��
-- 3. ���� ���ϱ�

-- 1. ���̺� ã��
-- prod, lprod, buyer
-- 2. �������ǽ� ã��
-- prod_lgu = lprod_gu 
-- prod_buyer = buyer_id
-- 3. �������ϱ�

-- <�Ϲݹ��>
SELECT prod_id, prod_name, lprod_nm, buyer_name, buyer_add1
  FROM prod, lprod, buyer
 WHERE lprod_gu = prod_lgu
   AND buyer_id = prod_buyer
   AND prod_sale <= 100000
   AND SUBSTR(buyer_add1,1,2) = '�λ�';
--   AND buyer_add1 LIKE '�λ�%';  

-- <ǥ�ع��>
SELECT prod_id, prod_name, lprod_nm, buyer_name, buyer_add1
  FROM prod INNER JOIN lprod
               ON(prod_lgu = lprod_gu 
                  AND prod_sale <= 100000)
            INNER JOIN buyer
               ON(prod_buyer = buyer_id
                  AND SUBSTR(buyer_add1,1,2) = '�λ�');

-- [����]
-- ��ǰ�з���, ��ǰ��, ��ǰ����, ���Լ���, �ֹ�����, �ŷ�ó���� ��ȸ
-- ��, ��ǰ�з� �ڵ尡 P101, P201, P301�ΰ�
--     ���Լ����� 15�� �̻��� ��
--     ���￡ ��� �ִ� ȸ�� �߿� ������ 1974����� ȸ��
-- ������ ȸ�� ���̵� ���� ��������, ���Լ��� ���� ��������
-- �Ϲݹ��, ǥ�ع��

-- 1. ���̺� ã��
-- lprod, prod, buyprod, cart, buyer
-- 2. �������ǽ� ã��
-- lprod_gu = prod_lgu
-- prod_buyer = buyer_id
-- cart_prod = prod_id
-- buy_prod = prod_id
-- cart_member = mem_id
-- 3. ���� ���ϱ�

-- <�Ϲݹ��>
SELECT lprod_nm, prod_name, prod_color, buy_qty, cart_qty, buyer_name
  FROM lprod, prod, buyprod, cart, buyer, member
 WHERE lprod_gu = prod_lgu
   AND buyer_id = prod_buyer
   AND cart_prod = prod_id
   AND buy_prod = prod_id
   AND cart_member = mem_id
   AND lprod_gu IN ('P101','P201','P301')
   AND buy_qty >= 15
   AND SUBSTR(mem_add1, 1, 2) = '����' AND TO_CHAR(mem_bir,'YYYY') = 1974
 ORDER BY mem_id DESC, buy_qty ASC ;

-- <ǥ�ع��>
SELECT lprod_nm, prod_name, prod_color, buy_qty, cart_qty, buyer_name
  FROM lprod INNER JOIN prod
                ON (lprod_gu = prod_lgu
                    AND lprod_gu IN ('P101','P201','P301'))
             INNER JOIN buyprod
                ON (buy_prod = prod_id
                    AND buy_qty >= 15)
             INNER JOIN cart
                ON (cart_prod = prod_id)
             INNER JOIN member
                ON (cart_member = mem_id 
                AND SUBSTR(mem_add1, 1, 2) = '����' 
                AND TO_CHAR(mem_bir,'YYYY') = 1974)
             INNER JOIN buyer
                ON (buyer_id = prod_buyer)
 ORDER BY mem_id DESC, buy_qty ASC;
 
 --<�������� ��>
 --[����]
--��ǰ�з���, ��ǰ��, ��ǰ����, ���Լ���, �ֹ�����, �ŷ�ó���� ��ȸ
-- ��, ��ǰ�з� �ڵ尡 P101, P201, P301�� ��
--     ���Լ����� 15�� �̻��� ��
--     ���￡ ��� �ִ� ȸ�� �߿� ������ 1974����� ȸ��
-- ������ ȸ�����̵� ���� ��������, ���Լ��� ���� ��������
-- �Ϲݹ��, ǥ�ع��..
--1. ���̺�
-- prod, buyprod, cart, buyer, lprod, member
--2. ����
-- prod_id = buy_prod
-- prod_id = cart_prod
-- cart_member = mem_id
-- prod_buyer = buyer_id
-- prod_lgu = lprod_gu
--3. ����
--<�Ϲݹ��>
SELECT lprod_nm, prod_name, prod_color, buy_qty, cart_qty, buyer_name
  FROM prod, buyprod, cart, buyer, lprod, member
 WHERE prod_id = buy_prod
   AND prod_id = cart_prod
   AND cart_member = mem_id
   AND prod_buyer = buyer_id
   AND prod_lgu = lprod_gu
   AND prod_lgu IN ('P101', 'P201', 'P301')
   AND buy_qty >= 15
   AND mem_bir BETWEEN '74/01/01' AND '74/12/31'
   AND mem_add1 LIKE '����%'
 ORDER BY mem_id DESC, buy_qty ASC;
   
--<ǥ�ع��>
SELECT lprod_nm, prod_name, prod_color, buy_qty, cart_qty, buyer_name
  FROM prod INNER JOIN buyprod
                ON(prod_id = buy_prod
                    AND buy_qty >= 15)
            INNER JOIN cart
                ON(prod_id = cart_prod)
            INNER JOIN buyer
                ON(prod_buyer = buyer_id)
            INNER JOIN lprod
                ON(prod_lgu = lprod_gu
                    AND lprod_gu IN ('P101', 'P201', 'P301'))
            INNER JOIN member
                ON(cart_member = mem_id
                    AND mem_bir BETWEEN '74/01/01' AND '74/12/31'
                    AND mem_add1 LIKE '����%')
 ORDER BY mem_id DESC, buy_qty ASC;                