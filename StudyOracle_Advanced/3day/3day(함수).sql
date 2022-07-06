-- �Լ�(Function)

-- ��ǰ�ڵ庰 ���ż����� ���� �ִ밪, �ּҰ�, ��հ�, �հ�, ���� ��ȸ�ϱ�
-- ��ȸ�÷� ��ǰ�ڵ�, �ִ밪, �ּҰ�, ��հ�, �հ�, ���� ��ȸ�ϱ�
-- 1. cart

SELECT cart_prod, MAX(cart_qty) AS mqty, 
                  MIN(cart_qty) AS mqty, 
                  ROUND(AVG(cart_qty), 2) AS aqty, 
                  SUM(cart_qty) AS sqty, 
                  COUNT(cart_qty) AS cqty
  FROM cart
 GROUP BY cart_prod;

-- [����] 2005�⵵ 7�� 11���̶� �����ϰ� ��ٱ������̺� �߻��� �߰� �ֹ���ȣ�� �˻��Ͻÿ�
-- ��ȸ�÷� : ���� ������ �ֹ���ȣ, �߰� �ֹ���ȣ

SELECT MAX(cart_no) AS mno, MAX(cart_no)+1 AS mpno
  FROM cart
 WHERE SUBSTR(cart_no,1,8) = 20050711;

SELECT MAX(cart_no) AS mno, MAX(cart_no)+1 AS mpno
  FROM cart
 WHERE SUBSTR(cart_no,1,8) LIKE '20050711%';
 
-- [����2] ȸ�����̺��� ȸ����ü�� ���ϸ��� ���, ���ϸ��� �հ�, 
-- �ְ� ���ϸ���, �ּ� ���ϸ���, �ο����� �˻��Ͻÿ� 

SELECT ROUND(AVG(mem_mileage),2) AS am, 
       SUM(mem_mileage) AS sm, 
       MAX(mem_mileage) AS mm,
       MIN(mem_mileage) AS mim, 
       COUNT(mem_mileage) AS cm
  FROM member;
  
-- [����]
-- ��ǰ���̺��� �ŷ�ó��, ��ǰ�з��ڵ庰��,
-- �ǸŰ��� ���� �ְ�, �ּ�, �ڷ��, ���, �հ踦 ��ȸ���ּ���
-- ������ �ڷ���� �������� ��������

SELECT prod_buyer, prod_lgu, 
        MAX(prod_sale) AS ms,
        MIN(prod_sale) AS mis, 
        COUNT(prod_sale) AS cs, 
        ROUND(AVG(prod_sale),2) AS asl, 
        SUM(prod_sale) AS sum_s
  FROM prod
 GROUP BY prod_buyer, prod_lgu
 ORDER BY cs DESC;
 
-- [����2]
-- ��ǰ���̺��� �ŷ�ó��, ��ǰ�з��ڵ庰��,
-- �ǸŰ��� ���� �ְ�, �ּ�, �ڷ��, ���, �հ踦 ��ȸ���ּ���
-- ������ �ڷ���� �������� ��������
--  + �߰���, �ŷ�ó��, ��ǰ�з��� ��ȸ
-- 1. prod

SELECT prod_buyer, prod_lgu, 
        MAX(prod_sale) AS ms,
        MIN(prod_sale) AS mis, 
        COUNT(prod_sale) AS cs, 
        ROUND(AVG(prod_sale),2) AS asl, 
        SUM(prod_sale) AS sum_s,
        (SELECT DISTINCT buyer_name
           FROM buyer 
          WHERE buyer_id = prod_buyer) AS bname,
        (SELECT DISTINCT lprod_nm
           FROM lprod 
          WHERE lprod_gu = prod_lgu) AS pname
  FROM prod
 GROUP BY prod_buyer, prod_lgu
 ORDER BY cs DESC;
 
-- [����3]
-- ��ǰ���̺��� �ŷ�ó��, ��ǰ�з��ڵ庰��,
-- �ǸŰ��� ���� �ְ�, �ּ�, �ڷ��, ���, �հ踦 ��ȸ���ּ���
-- ������ �ڷ���� �������� ��������
-- 2. �߰���, �ŷ�ó��, ��ǰ�з��� ��ȸ
-- 3. ��, �հ谡 100 �̻��� ��

SELECT prod_buyer, prod_lgu, 
        MAX(prod_sale) AS ms,
        MIN(prod_sale) AS mis, 
        COUNT(prod_sale) AS cs, 
        ROUND(AVG(prod_sale),2) AS asl, 
        SUM(prod_sale) AS sum_s,
        (SELECT DISTINCT buyer_name
           FROM buyer 
          WHERE buyer_id = prod_buyer) AS bname,
        (SELECT DISTINCT lprod_nm
           FROM lprod 
          WHERE lprod_gu = prod_lgu) AS pname
  FROM prod
 GROUP BY prod_buyer, prod_lgu
 HAVING SUM(prod_sale) >= 100
 ORDER BY cs DESC;
 
-- NULL
UPDATE buyer 
   SET buyer_charger = NULL
 WHERE buyer_charger LIKE '��%';
 
UPDATE buyer 
   SET buyer_charger = ''
 WHERE buyer_charger LIKE '��%';
 
 SELECT buyer_charger  
   FROM buyer
  WHERE buyer_charger is NULL;
  
SELECT buyer_name, buyer_charger
  FROM buyer
 WHERE buyer_charger IS NULL;
 
SELECT buyer_name, buyer_charger
  FROM buyer
 WHERE buyer_charger IS NOT NULL;

SELECT buyer_name, 
       NVL(buyer_charger, '����') AS charger
  FROM buyer;
-- NVL(col, ��ü��)
  
-- �� DECODE(���ǹ� �Լ�) = IF
IF SUBSTR(prod_lgu, 1, 2) == 'P1':
    PRINT('��ǻ��/������ǰ')
ELIF SUBSTR(prod_lgu, 1, 2) == 'P2':
    PRINT('�Ƿ�')


SELECT prod_lgu,
       DECODE (SUBSTR(prod_lgu, 1, 2),
               'P1', '��ǻ��/������ǰ',
               'P2', '�Ƿ�',
               'P3', '��ȭ',
               '��Ÿ') AS lgu_nm
  FROM prod;
  
-- EXITS(�Ѱ��� TABLE ��ȸ)
SELECT prod_id, prod_name, prod_lgu
  FROM prod
 WHERE EXISTS (
        SELECT lprod_gu
          FROM lprod
         WHERE lprod_gu = prod_lgu);
         
