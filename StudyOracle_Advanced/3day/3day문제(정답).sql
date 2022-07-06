--3조 [문제1]  
-- 1974년 7월 이후 1980년 12월 이전 태어난 여성이 구입하였고,
-- 거래처 담당자가 존재하지 않거나 주소가 부산이 아니며, 
-- 입고일자가 4월 이상이고 
-- 매입수량이 10 이상이거나 매입단가가 200000원 이하인 상품 중에서
-- 크기가 L인 상품명에 2가 포함된 제품을 조회하고
-- 할인이 가장 많이 된 상품의 상품명, 판매가, 할인율(2번째자리까지),사이즈를 
-- 1~5등만 나타내시오!
-- 단, 서브쿼리만을 이용해서!

-- 1. table
-- member, buyer, buyprod, prod, cart

-- 2. 관계
-- mem_id = cart_member / cart_prod = prod_id / 
-- prod_lgu = lprod_gu / 
-- prod_buyer = buyer_id / buyer_lgu = lprod_gu

-- 3. 
-- buyer > prod > cart > member
-- buyer > iprod


------------------------------------------------------------
-- <정답>
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
                   OR SUBSTR(buyer_add1,1,2) != '부산')
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
-- <과정>
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
   AND SUBSTR(buyer_add1,1,2) != '부산';
   
SELECT * 
  FROM buyprod
 WHERE TO_CHAR(buy_date, 'MM') >= 4
   AND buy_qty >= 10
   AND buy_cost <= 200000;
   
