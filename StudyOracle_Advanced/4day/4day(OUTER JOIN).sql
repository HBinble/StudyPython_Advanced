-- <OUTER JOIN>                
-- ��ü �з��� ��ǰ�ڷ� ���� �˻� ��ȸ

-- 1. �з����̺� ��ȸ
SELECT *
  FROM lprod;

-- 2. �Ϲ� JOIN
SELECT lprod_gu,
       lprod_nm,
       COUNT(prod_lgu)
  FROM lprod, prod
 WHERE lprod_gu = prod_lgu
 GROUP BY lprod_gu, lprod_nm;
 
-- 3. OUTER JOIN ��� Ȯ�� = �������ǽĿ� -> (+) �ִ� �� : ������ �ִ´�� ������ ���´�� / �ݴ��� : ��ü 
SELECT lprod_gu,
       lprod_nm,
       COUNT(prod_lgu)
  FROM lprod, prod
 WHERE lprod_gu = prod_lgu(+)
 GROUP BY lprod_gu, lprod_nm
 ORDER BY lprod_gu;
 
-- OUTER JOIN�� ��INNER JOIN�� �����ϰ� ���ǽĿ� ��ü �ݴ뿡 (+) �ֱ�
-- ������ �� ���� ���̱� ������ NVL�� ���� ����Ѵ�.

-- ANSI ���� = ǥ�ع��
-- LEFT, RIGHT, FULL �� ��ġ�� ���� ������.
-- (+) ���� ��Ȯ�ϰ� ����� ���´�.
-- LEFT : ���� ��ü�� ���̺��� ��ȸ�ϰڴ�.
SELECT lprod_gu,
       lprod_nm,
       COUNT(prod_lgu)
  FROM lprod LEFT OUTER JOIN prod
                     ON (lprod_gu = prod_lgu)
 GROUP BY lprod_gu, lprod_nm
 ORDER BY lprod_gu;
 
-- ��ü��ǰ�� 2005�� 1�� �԰������ �˻� ��ȸ

-- 1. �Ϲ� JOIN
SELECT prod_id,
       prod_name,
       SUM(buy_qty)
  FROM prod, buyprod
 WHERE prod_id = buy_prod
   AND buy_date BETWEEN '2005-01-01' AND '2005-01-31'
 GROUP BY prod_id, prod_name;
 
-- 2. OUTER JOIN ��� Ȯ�� -> (+) �� ��� ������ ���� �� �ִ�.
SELECT prod_id,
       prod_name,
       SUM(buy_qty)
  FROM prod, buyprod
 WHERE prod_id = buy_prod(+)
   AND buy_date BETWEEN '2005-01-01' AND '2005-01-31'
 GROUP BY prod_id, prod_name
 ORDER BY prod_id, prod_name;

-- 3. ǥ�ع�� -> LEFT OUTER JOIN�� ���������� �Ѵ�.(����!)
SELECT prod_id,
       prod_name,
       SUM(buy_qty)
  FROM prod LEFT OUTER JOIN buyprod
              ON (prod_id = buy_prod
                AND buy_date BETWEEN '2005-01-01' AND '2005-01-31')
 GROUP BY prod_id, prod_name
 ORDER BY prod_id, prod_name;
 
-- SELF JOIN (A�� ����, B�� �ɷ���)
-- �ŷ�ó�ڵ尡 'P30203(����)'�� ���������� ���� �ŷ�ó�� �˻� ��ȸ
SELECT B.buyer_id,
       B.buyer_name,
       B.buyer_add1 ||''|| B.buyer_add2
  FROM buyer A, buyer B
 WHERE A.buyer_id = 'P30203'
   AND SUBSTR(A.buyer_add1,1,2) = SUBSTR(B.buyer_add1,1,2);
