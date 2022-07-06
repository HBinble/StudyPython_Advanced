-- 4day
-- [����1]
-- ��ǰ���̺�� ��ǰ�з����̺��� ��ǰ�з��ڵ尡 'P101'�� �Ϳ� ����
-- ��ǰ�з��ڵ�(��ǰ���̺� �ִ� �÷�), ��ǰ��, ��ǰ�з����� ��ȸ���ּ���
-- ������ ��ǰ���̵�� ��������

-- <�Ϲݹ��>
SELECT prod_lgu, prod_name, lprod_nm
  FROM prod, lprod
 WHERE prod_lgu = lprod_gu
   AND lprod_gu = 'P101'
 ORDER BY prod_id DESC;
 
-- <ǥ�ع��>
SELECT prod_lgu, prod_name, lprod_nm
  FROM lprod INNER JOIN prod
                ON (lprod_gu = prod_lgu)
               AND lprod_gu = 'P101'
 ORDER BY prod_id DESC;
 
-- [����2]
-- ������ ȸ���� ������ ��ǰ�� ����
-- �ŷ�ó ������ Ȯ���Ϸ��� �մϴ�.
-- �ŷ�ó�ڵ�, �ŷ�ó��, ȸ����������(���� or ��õ) ��ȸ
-- ��, ��ǰ�з��� �߿� ĳ�־� �ܾ ���Ե� ��ǰ�� ���ؼ���

-- <�Ϲ�>
SELECT buyer_id, buyer_name, SUBSTR(buyer_add1,1,2) AS add1
  FROM buyer, prod, lprod ,cart, member
 WHERE buyer_id = prod_buyer
   AND lprod_gu = prod_lgu
   AND cart_prod = prod_id
   AND cart_member = mem_id
   AND mem_name = '������'
   AND lprod_nm LIKE '%ĳ�־�%';
   
-- <ǥ��>  
SELECT buyer_id, buyer_name, SUBSTR(buyer_add1,1,2) AS add1
  FROM buyer INNER JOIN prod
                     ON (buyer_id = prod_buyer)
             INNER JOIN lprod
                     ON (lprod_gu = prod_lgu
                    AND lprod_nm LIKE '%ĳ�־�%')
             INNER JOIN cart
                     ON (cart_prod = prod_id)
             INNER JOIN member
                     ON (cart_member = mem_id
                    AND mem_name = '������');

-- [����3]                    
-- ��ǰ�з��� '����'�� ���Ե� ��ǰ�� ������ ȸ�� ��ȸ�ϱ�
-- ȸ�����̵�, ȸ���̸�, ��ǰ�з��� ��ȸ�ϱ�
-- ��, ��ǰ�� �Ｚ���ڰ� ���Ե� ��ǰ�� ������ ȸ����
--     ȸ���� ��̰� ������ ȸ��

-- 1. TABLE = lprod, prod, cart, member
SELECT mem_id, mem_name, lprod_nm
  FROM lprod, prod, cart, member
 WHERE lprod_gu = prod_lgu
   AND cart_prod = prod_id
   AND cart_member = mem_id
   AND lprod_nm LIKE '%����%'
   AND prod_name LIKE '%�Ｚ����%'
   AND mem_like = '����';

-- [����4]
-- ��ǰ�з����̺�� ��ǰ���̺�� �ŷ�ó���̺�� ��ٱ��� ���̺� ���
-- ��ǰ�з��ڵ尡 'P101' �ΰ��� ��ȸ
-- �׸���, ������ ��ǰ�з����� �������� ��������
--                ��ǰ���̵� �������� �������� �ϼ���
-- ��ǰ�з���, ��ǰ���̵�, ��ǰ�ǸŰ�, �ŷ�ó�����, ȸ�����̵�, �ֹ����� �� ��ȸ

-- 1. TABLE = lprod, prod, buyer, cart
-- 2. ����
-- lprod_gu = prod_lgu
-- buyer_id = prod_buyer
-- cart_prod = prod_id

-- <�Ϲ�>
SELECT lprod_nm, prod_id, prod_sale, buyer_charger, cart_member, cart_qty
  FROM lprod, prod, buyer, cart
 WHERE lprod_gu = prod_lgu
   AND buyer_id = prod_buyer
   AND cart_prod = prod_id
   AND lprod_gu = 'P101'
 ORDER BY lprod_nm DESC, prod_id ASC;

-- <ǥ��>
SELECT lprod_nm, prod_id, prod_sale, buyer_charger, cart_member, cart_qty
  FROM lprod INNER JOIN prod
                ON (lprod_gu = prod_lgu)
                AND lprod_gu = 'P101'
             INNER JOIN buyer
                ON (buyer_id = prod_buyer)
             INNER JOIN cart
                ON (cart_prod = prod_id)
 ORDER BY lprod_nm DESC, prod_id ASC;

--[����5]
-- ��ǰ�ڵ庰 ���ż����� ���� �ִ밪, �ּҰ�, ��հ�, �հ�, ���� ��ȸ�ϱ�
-- ��, ��ǰ�� �Ｚ�� ���Ե� ��ǰ�� ������ ȸ���� ���ؼ���
-- ��ȸ�÷� ��ǰ�ڵ�, �ִ밪, �ּҰ�, ��հ�, �հ�, ����

-- <�Ϲ�>
SELECT cart_prod, MAX(cart_qty) AS mqty,
                  MIN(cart_qty) AS minqty,
                  ROUND(AVG(cart_qty), 2) AS aqty,
                  SUM(cart_qty) AS sqty,
                  COUNT(cart_qty) AS cqty
  FROM prod, cart
 WHERE prod_id = cart_prod
   AND prod_name LIKE '%�Ｚ%'
 GROUP BY cart_prod;

-- <ǥ��>
SELECT cart_prod, MAX(cart_qty) AS mqty,
                  MIN(cart_qty) AS minqty,
                  ROUND(AVG(cart_qty), 2) AS aqty,
                  SUM(cart_qty) AS sqty,
                  COUNT(cart_qty) AS cqty
  FROM prod INNER JOIN cart
               ON (prod_id = cart_prod)
              AND prod_name LIKE '%�Ｚ%'
 GROUP by cart_prod; 
 
-- [����6]
-- �ŷ�ó�ڵ� �� ��ǰ�з��ڵ庰��,
-- �ǸŰ��� ���� �ְ�, �ּ�, �ڷ��, ���, �հ踦 ��ȸ���ּ���
-- ��ȸ�÷�, �ŷ�ó�ڵ�, �ŷ�ó��, ��ǰ�з��ڵ�, ��ǰ�з���,
--           �ǸŰ��� ���� �ְ�, �ּ�, �ڷ��, ���, �հ�
-- ������ ����� �������� ��������
-- ��, �ǸŰ��� ����� 100 �̻��� ��

-- 1. table = buyer, lprod, prod(prod_sale)
-- 2. lprod_gu = prod_lgu / buyer_id = prod_buyer

--   
SELECT buyer_id, buyer_name, lprod_gu, lprod_nm,
        MAX(prod_sale) AS maxs,
        MIN(prod_sale) AS mins,
        COUNT(prod_sale) AS cs,
        ROUND(AVG(prod_sale), 2) AS asl,
        SUM(prod_sale) AS ss
  FROM buyer, lprod, prod
 WHERE buyer_id = prod_buyer
   AND lprod_gu = prod_lgu
 GROUP BY buyer_id, buyer_name, lprod_gu, lprod_nm
HAVING ROUND(AVG(prod_sale), 2) >= 100
 ORDER BY asl DESC;

-- �������� ��� 
SELECT buyer_id, 
        (SELECT DISTINCT buyer_name
           FROM buyer 
          WHERE buyer_id = prod_buyer) AS bname,
       lprod_gu, 
        (SELECT DISTINCT lprod_nm
           FROM lprod 
          WHERE lprod_gu = prod_lgu) AS pname,
        MAX(prod_sale) AS maxs,
        MIN(prod_sale) AS mins,
        COUNT(prod_sale) AS cs,
        ROUND(AVG(prod_sale), 2) AS asl,
        SUM(prod_sale) AS ss
  FROM buyer, lprod, prod
 WHERE buyer_id = prod_buyer
   AND lprod_gu = prod_lgu
 GROUP BY buyer_id, lprod_gu
 HAVING ROUND(AVG(prod_sale), 2) >= 100
 ORDER BY asl DESC;
  
-- [����7]
/*
-- �ŷ�ó���� group�� ��� ���Աݾ��� ���� �˻��ϰ��� �մϴ�.
-- ������ ��ǰ�԰����̺��� 2005�⵵ 1���� ��������(�԰�����) �ΰ͵�
-- ���Աݾ� = ���Լ��� * ���Աݾ�
-- ��ȸ�÷� : �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ��� ��
-- (���Աݾ��� ���� NULL�� ��� 0���� ��ȸ)
-- ������ �ŷ�ó �ڵ� �� �ŷ�ó���� �������� ��������
*/

-- 1. TABLE = buyer, buyprod, prod
-- 2. buyer_id = prod_buyer / prod_id = buy_prod

SELECT buyer_id, buyer_name, 
        SUM(NVL(buy_qty * buy_cost, 0)) AS SUMCOST
  FROM buyer, prod, buyprod
 WHERE buyer_id = prod_buyer
   AND prod_id = buy_prod
   AND buy_date BETWEEN '05/01/01' AND '05/01/31'
 GROUP BY buyer_id, buyer_name
 ORDER BY buyer_id DESC, buyer_name DESC ;

-- [����8]
/*
-- �ŷ�ó���� group�� ��� ���Աݾ��� ���� ����Ͽ�
-- ���Աݾ��� ���� 1õ���� �̻��� ��ǰ�ڵ�, ��ǰ���� �˻��ϰ��� �մϴ�.
-- ������ ��ǰ�԰����̺��� 2005�⵵ 1���� ��������(�԰�����) �ΰ͵�
-- ���Աݾ� = ���Լ��� * ���Աݾ�
-- (���Աݾ��� ���� NULL�� ��� 0���� ��ȸ)
-- ��ȸ�÷� : ��ǰ�ڵ�, ��ǰ��
-- ������ ��ǰ���� �������� ��������
*/

-- <��������>
SELECT prod_id, prod_name
  FROM prod
 WHERE prod_buyer IN( 
        SELECT buyer_id
          FROM buyer, prod, buyprod
         WHERE buyer_id = prod_buyer
           AND prod_id = buy_prod
           AND buy_date BETWEEN '05/01/01' AND '05/01/31'
         GROUP BY buyer_id
         HAVING SUM(NVL(buy_qty * buy_cost, 0)) >= 10000000)      
 ORDER BY prod_name ASC;

-- <JOIN>
SELECT prod_id, prod_name
  FROM buyer, prod, buyprod
 WHERE buyer_id = prod_buyer
   AND prod_id = buy_prod
   AND buy_date BETWEEN '05/01/01' AND '05/01/31'
 GROUP BY prod_id, prod_name
HAVING SUM(NVL(buy_qty * buy_cost, 0)) >= 10000000
 ORDER BY prod_name ASC;

-- 
/*
-- �ŷ�ó���� group�� ��� ���Աݾ��� ���� �˻��ϰ��� �մϴ�.
-- ������ ��ǰ�԰����̺��� 2005�⵵ 1���� ��������(�԰�����) �ΰ͵�
-- ���Աݾ� = ���Լ��� * ���Աݾ�
-- ��ȸ�÷� : �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ��� ��
-- (���Աݾ��� ���� NULL�� ��� 0���� ��ȸ)
-- ������ �ŷ�ó �ڵ� �� �ŷ�ó���� �������� ��������

-- ���� ����� �̿��Ͽ�
-- ���Աݾ��� ���� 1õ���� �̻��� ��ǰ�ڵ�, ��ǰ���� �˻�
*/

-- <WHERE�� ��������>
SELECT prod_id, prod_name
  FROM prod
 WHERE prod_buyer IN( 
        SELECT buyer_id
          FROM buyer, prod, buyprod
         WHERE buyer_id = prod_buyer
           AND prod_id = buy_prod
           AND buy_date BETWEEN '05/01/01' AND '05/01/31'
         GROUP BY buyer_id
         HAVING SUM(NVL(buy_qty * buy_cost, 0)) >= 10000000)
 ORDER BY prod_name ASC;
 
-- <FROM�� ��������>
SELECT prod_id, prod_name
  FROM (SELECT buyer_id, buyer_name, 
                SUM(NVL(buy_qty * buy_cost, 0)) AS SUMCOST
          FROM buyer, prod, buyprod
         WHERE buyer_id = prod_buyer
           AND prod_id = buy_prod
           AND buy_date BETWEEN '05/01/01' AND '05/01/31'
         GROUP BY buyer_id, buyer_name
         ORDER BY buyer_id DESC, buyer_name DESC) A, prod P
 WHERE prod_buyer = A.buyer_id
   AND A.sumcost >= 10000000
 ORDER BY prod_name ASC;
                 
-- <OUTER JOIN>                
