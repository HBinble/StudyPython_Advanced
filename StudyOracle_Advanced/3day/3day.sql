-- 3day
-- [��ȸ ��� ����]
-- ��ǰ�з� �߿� '����'�� ���Ե� ��ǰ�� ������ ȸ�� ��ȸ�ϱ�
-- ȸ�����̵�, ȸ���̸� ��ȸ�ϱ�
-- ��, ��ǰ�� �Ｚ���ڰ� ���Ե� ��ǰ�� ������ ȸ��
--      �׸���, ȸ���� ��̰� ������ ȸ��

-- 1. ���̺� ã��
--  - ���õ� �÷����� �Ҽ� ã��
--  ex) lprod, cart, member, prod


-- 2. ���̺� ���� ���� ã��
--  - ERD���� ����� ������� PK�� FK�÷� �Ǵ�, 
--  - ������ ���� ������ ������ �� �ִ� �÷� ã��
-- ex) lprod_gu = prod_lgu
-- ex) prod_id = cart_prod
-- ex) cart_member = mem_id


-- 3. �ۼ� ���� ���ϱ�
--  - ��ȸ�ϴ� �÷��� ���� ���̺��� ���� ��! 1����!
--  - 1���� ���̺���� ERD ������� �ۼ�
--  - ������ : �ش� �÷��� ���� ���̺��� ���� ó��
-- ex) member > cart > prod > lprod

-- 4. ���� �Է��ϱ�
-- ex) WHERE ���� ������ ���� �Է�


SELECT mem_id, mem_name 
  FROM member
 WHERE mem_like = '����'
   AND mem_id IN (
        SELECT cart_member
          FROM cart
         WHERE cart_prod IN (
            SELECT prod_id
              FROM prod
             WHERE prod_name LIKE '%�Ｚ����%'
                    AND prod_lgu IN (
                     SELECT lprod_gu
                       FROM lprod
                      WHERE lprod_nm LIKE '%����%')));
                      
                      
-- [����]
-- ������ ȸ���� ������ ��ǰ�� ����
-- �ŷ�ó ������ Ȯ���Ϸ��� �մϴ�.
-- �ŷ�ó�ڵ�, �ŷ�ó��, ����(���� or ��õ), �ŷ�ó ��ȭ��ȣ ��ȸ
-- ��, ��ǰ�з��� �߿� ĳ�־� �ܾ ���Ե� ��ǰ�� ���ؼ��� ��ȸ

-- 1. table
-- member, cart, prod, buyer, lprod

-- 2. ����
-- mem_id = cart_member / cart_prod = prod_id / prod_lgu = lprod_gu / 
-- prod_buyer = buyer_id / buyer_lgu = lprod_gu

-- 3. 
-- buyer > prod > cart > member
-- buyer > iprod


--1�� �Ѻ�
SELECT buyer_id, buyer_name, SUBSTR(buyer_add1,1,2), buyer_comtel
  FROM buyer
 WHERE buyer_id IN(
        SELECT prod_buyer
          FROM prod
         WHERE prod_id IN (
                SELECT cart_prod
                  FROM cart
                 WHERE cart_member IN (
                        SELECT mem_id
                          FROM member
                          WHERE mem_name = '������')))
  AND buyer_lgu IN(
        SELECT lprod_gu
          FROM lprod
         WHERE lprod_nm LIKE '%ĳ�־�%');
         
-- 2�� �Ѻ�
SELECT buyer_id, buyer_name, SUBSTR(buyer_add1,1,2), buyer_comtel
  FROM buyer
 WHERE buyer_id IN(
        SELECT prod_buyer
          FROM prod
         WHERE prod_lgu IN(
                SELECT lprod_gu
                  FROM lprod
                 WHERE lprod_nm LIKE '%ĳ�־�%')         
           AND prod_id IN (
                SELECT cart_prod
                  FROM cart
                 WHERE cart_member IN (
                        SELECT mem_id
                          FROM member
                          WHERE mem_name = '������')));
                          
-- ����(�����)
-- 1. member, cart, buyer, lprod, prod
-- 2. mem_id = cart_member
--    cart_prod = prod_id
--    prod_buyer = buyer_id
--    prod_lgu = lprod_gu
-- 3. 

SELECT buyer_id, buyer_name, SUBSTR(buyer_add1,1,2), buyer_comtel
  FROM buyer
 WHERE buyer_id IN(
            SELECT prod_buyer
              FROM prod
             WHERE prod_lgu IN(
                    SELECT lprod_gu        
                      FROM lprod
                     WHERE lprod_nm LIKE '%ĳ�־�%')
               AND prod_id IN(
                    SELECT cart_prod
                      FROM cart
                     WHERE cart_member IN(
                            SELECT mem_id
                              FROM member
                             WHERE mem_name = '������')));
                             
-- ������ ȸ���� ������ ��ǰ�߿�
-- ��ǰ�з��� ���ڰ� ���ԵǾ��ְ�
-- �ŷ�ó ������ ������
-- ��ǰ�ڵ�, ��ǰ�� ��ȸ�Ͻÿ�

-- 1. prod, buyer, lprod, cart, member
-- 2. prod_id = cart_prod
--    prod_buyer = buyer_id
--    prod_lgu = lprod_gu

SELECT prod_id, prod_name
  FROM prod
 WHERE prod_buyer IN (
        SELECT buyer_id
          FROM buyer
         WHERE SUBSTR(buyer_add1, 1, 2) = '����')
   AND prod_lgu IN (
        SELECT lprod_gu
          FROM lprod
         WHERE lprod_nm LIKE '%����%')
   AND prod_id IN (
        SELECT cart_prod
          FROM cart
         WHERE cart_member IN (
                SELECT mem_id
                  FROM member
                 WHERE MOD(SUBSTR(mem_REGNO2,1,1),2) = 0));
 
-- ����(�����)
-- 1. member, cart, lprod, buyer, prod
-- 2. mem_id = cart_member
--    cart_prod = prod_id
--    prod_lgu = lprod_gu
--    prod_buyer = buyer_id
-- 3. prod > cart > member
--    prod > lprod
--    prod > buyer
                   
SELECT prod_id, prod_name
  FROM prod   
 WHERE prod_id IN(
    SELECT cart_prod
      FROM cart
     WHERE cart_member IN (
        SELECT mem_id
          FROM member
         WHERE MOD(SUBSTR(mem_regno2,1,1), 2) = 0))
   AND prod_lgu IN (
        SELECT lprod_gu
          FROM lprod
         WHERE lprod_nm LIKE '%����%')
   AND prod_buyer IN (
        SELECT buyer_id
          FROM buyer
         WHERE SUBSTR(buyer_add1, 1, 2) = '����');        
         