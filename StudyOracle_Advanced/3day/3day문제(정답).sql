--3�� [����1]  
-- 1974�� 7�� ���� 1980�� 12�� ���� �¾ ������ �����Ͽ���,
-- �ŷ�ó ����ڰ� �������� �ʰų� �ּҰ� �λ��� �ƴϸ�, 
-- �԰����ڰ� 4�� �̻��̰� 
-- ���Լ����� 10 �̻��̰ų� ���Դܰ��� 200000�� ������ ��ǰ �߿���
-- ũ�Ⱑ L�� ��ǰ�� 2�� ���Ե� ��ǰ�� ��ȸ�ϰ�
-- ������ ���� ���� �� ��ǰ�� ��ǰ��, �ǸŰ�, ������(2��°�ڸ�����),����� 
-- 1~5� ��Ÿ���ÿ�!
-- ��, ������������ �̿��ؼ�!

-- 1. table
-- member, buyer, buyprod, prod, cart

-- 2. ����
-- mem_id = cart_member / cart_prod = prod_id / 
-- prod_lgu = lprod_gu / 
-- prod_buyer = buyer_id / buyer_lgu = lprod_gu

-- 3. 
-- buyer > prod > cart > member
-- buyer > iprod


------------------------------------------------------------
-- <����>
SELECT prod_name, prod_sale, 
        ROUND(((prod_price - prod_sale)/prod_price * 100),2) AS discount_rate, 
        DECODE (prod_size,
               's', 'S',
               'M', 'M',
               'L', 'L',
               'XL', 'XL', 
               '30', 'M',
               '32', 'L',
               '34', 'XL',
               '66', 'M',
               '77', 'L',
               '88', 'XL') AS prod_size_RE
  FROM prod
 WHERE DECODE (prod_size,
               's', 'S',
               'M', 'M',
               'L', 'L',
               'XL', 'XL', 
               '30', 'M',
               '32', 'L',
               '34', 'XL',
               '66', 'M',
               '77', 'L',
               '88', 'XL') = 'L'
   AND prod_name LIKE '%2%'
   AND prod_buyer IN (
                SELECT buyer_id
                  FROM buyer
                 WHERE buyer_charger IS NOT NULL
                   OR SUBSTR(buyer_add1,1,2) != '�λ�')
    AND prod_id IN (
                    SELECT buy_prod
                      FROM buyprod
                     WHERE TO_CHAR(buy_date, 'MM') >= 4
                       AND buy_qty >= 10
                       OR buy_cost <= 200000)
    AND prod_id IN (
                    SELECT cart_prod
                      FROM cart
                     WHERE cart_member IN(
                                           SELECT mem_id
                                              FROM member
                                             WHERE (SUBSTR(mem_regno1,1,4) >= 7407 AND SUBSTR(mem_regno1,1,4) <=8012)
                                               AND MOD(SUBSTR(mem_regno2,1,1),2) = 0 ))
     AND ROWNUM <= 5
   ORDER BY discount_rate DESC;
    




--------------------------------------------------------------------
-- <����>
SELECT mem_id
  FROM member
 WHERE (SUBSTR(mem_regno1,1,4) >= 7407 AND SUBSTR(mem_regno1,1,4) <=8012)
   AND MOD(SUBSTR(mem_regno2,1,1),2) = 0;
   
SELECT prod_name, prod_cost, prod_price, prod_sale, 
        ROUND(((prod_price - prod_sale)/prod_price * 100),2) AS discount_rate, 
        DECODE (prod_size,
               's', 'S',
               'M', 'M',
               'L', 'L',
               'XL', 'XL', 
               '30', 'M',
               '32', 'L',
               '34', 'XL',
               '66', 'M',
               '77', 'L',
               '88', 'XL') AS prod_size_RE
  FROM prod
 WHERE DECODE (prod_size,
               's', 'S',
               'M', 'M',
               'L', 'L',
               'XL', 'XL', 
               '30', 'M',
               '32', 'L',
               '34', 'XL',
               '66', 'M',
               '77', 'L',
               '88', 'XL') = 'L'
   AND prod_name LIKE '%2%';
  
SELECT *
  FROM buyer
 WHERE buyer_charger IS NOT NULL
   AND SUBSTR(buyer_add1,1,2) != '�λ�';
   
SELECT * 
  FROM buyprod
 WHERE TO_CHAR(buy_date, 'MM') >= 4
   AND buy_qty >= 10
   AND buy_cost <= 200000;
   
