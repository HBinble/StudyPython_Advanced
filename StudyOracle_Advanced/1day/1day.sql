-- LPROD TABLE ����
CREATE TABLE lprod
(
    lprod_id number(5) NOT NULL,
    lprod_gu char(4) NOT NULL,
    lprod_nm varchar2(40) NOT NULL,
    Constraint pk_lprod Primary Key(lprod_gu)
) ;

-- ��ȸ
SELECT * 
  FROM lprod;

-- ����
INSERT INTO lprod (lprod_id,lprod_gu,lprod_nm)
    VALUES(1,'P101','��ǻ����ǰ') ;
INSERT INTO lprod (lprod_id,lprod_gu,lprod_nm)
    VALUES(1,'P102','��ǻ����ǰ') ;  
    
SELECT lprod_gu, lprod_nm 
  FROM lprod;
    
COMMIT;
--ROLLBACK;

-- ȸ������ ���̺�
SELECT *
  FROM member ;

-- �ֹ��������� ���̺�
SELECT *
  FROM cart ;
    
-- ��ǰ���� ���̺�
SELECT *
  FROM prod ;

-- ��ǰ�з����� ���̺�
SELECT *
  FROM lprod ;

-- �ŷ�ó���� ���̺�
SELECT *
  FROM buyer ;
    
-- �԰��ǰ����(���) ���̺�
SELECT *
  FROM buyprod ;    
    
    
-- ȸ�����̺��� ȸ�����̵�, ȸ���̸� ��ȸ�ϱ�
SELECT mem_id, mem_name 
  FROM member;

-- ��ǰ�ڵ�� ��ǰ�� ��ȸ�ϱ�
SELECT prod_id, prod_name
  FROM prod;

-- ��ǰ�ڵ�, ��ǰ��, �Ǹűݾ� ��ȸ�ϱ�
-- ��, �Ǹűݾ�=�ǸŰ� * 55 �� ����ؼ� ��ȸ�մϴ�.
-- �Ǹűݾ��� 4�鸸 �̻��� �����͸� ��ȸ�ϱ�
-- ������ �Ǹűݾ��� �������� ��������


-- SELECT > FROM ���̺� > WHERE > �÷���ȸ > ORDER BY (ORDER BY���� ��Ī��� ����, �� �������� ��� �Ұ�)
SELECT prod_id, prod_name, 
        (prod_sale * 55) as sale
  FROM prod
 WHERE (prod_sale*55) >= 4000000 
 ORDER BY sale DESC;
            
-- ��ǰ�������� �ŷ�ó�ڵ带 ��ȸ���ּ���
-- ��, �ߺ��� �����ϰ� ��ȸ���ּ���

SELECT prod_buyer
  FROM  prod 
 GROUP BY prod_buyer;

SELECT DISTINCT prod_buyer
  FROM  prod ;
    
-- ��ǰ�߿� �ǸŰ����� 17������ ��ǰ ��ȸ�ϱ�
SELECT prod_id, prod_sale
  FROM prod
 WHERE prod_sale = 170000;

-- ��ǰ�߿� �ǸŰ����� 17������ �ƴ� ��ǰ ��ȸ�ϱ�
SELECT prod_id, prod_sale
  FROM prod
 WHERE prod_sale != 170000;
        
-- ��ǰ�߿� �ǸŰ����� 17���� �̻��̰� 20���� ������ ��ǰ ��ȸ�ϱ�
SELECT prod_id, prod_sale
  FROM prod
 WHERE prod_sale >= 170000 AND prod_sale <= 200000; 

-- ��ǰ�߿� �ǸŰ����� 17���� �̻� �Ǵ� 20���� ������ ��ǰ ��ȸ�ϱ�
SELECT prod_id, prod_sale
  FROM prod
 WHERE prod_sale >= 170000 OR prod_sale <= 200000; 

-- ��ǰ �ǸŰ����� 10���� �̻��̰�
-- ��ǰ �ŷ�ó(���޾�ü) �ڵ尡 P30203 �Ǵ� P10201 ��
-- ��ǰ�ڵ�, �ǸŰ���, ���޾�ü �ڵ� ��ȸ�ϱ�
SELECT prod_id, prod_sale, prod_buyer
  FROM prod
 WHERE prod_sale >= 100000 
   AND (prod_buyer = 'P30203' 
    OR prod_buyer = 'P10201');
--
SELECT prod_id, prod_sale, prod_buyer
  FROM prod
 WHERE prod_sale >= 100000 
   AND prod_buyer IN('P30203','P10201');
--
SELECT prod_id, prod_sale, prod_buyer
  FROM prod
 WHERE prod_sale >= 100000 
   AND prod_buyer NOT IN('P30203','P10201');
--
SELECT DISTINCT prod_buyer
  FROM prod
 ORDER BY prod_buyer ASC;
--
SELECT *
  FROM buyer
 WHERE buyer_id IN(SELECT DISTINCT prod_buyer
                     FROM prod);
--
SELECT *
  FROM buyer
 WHERE buyer_id NOT IN(SELECT DISTINCT prod_buyer
                         FROM prod);

-- �ѹ��� �ֹ��� ���� ���� ȸ�� ���̵�, �̸��� ��ȸ���ּ���
SELECT mem_id, mem_name
  FROM member
 WHERE mem_id NOT IN(SELECT DISTINCT cart_member
                       FROM cart);
                            
-- ��ǰ�з� �߿� ��ǰ������ ���� �з��ڵ常 ��ȸ���ּ���
SELECT lprod_gu
  FROM lprod
 WHERE lprod_gu NOT IN (SELECT DISTINCT prod_lgu 
                          FROM prod) ;

-- ȸ���� �����߿� 75����� �ƴ� ȸ�����̵�, ���� ��ȸ�ϱ�
-- ������ ���� ���� ��������
SELECT mem_id, mem_regno1
  FROM member
 WHERE SUBSTR(mem_regno1, 1, 2) != '75'
 ORDER BY SUBSTR(mem_regno1, 1, 2) DESC;
            
SELECT mem_id, mem_bir
  FROM member
 WHERE TO_CHAR(mem_bir, 'YY') != '75'
 ORDER BY TO_CHAR(mem_bir, 'YY') DESC;
-- ����            
SELECT *
  FROM member
 WHERE mem_bir NOT BETWEEN '1975-01-01' AND '1975-12-31' ;

-- ȸ�����̵� a001�� ȸ���� �ֹ��� ��ǰ�ڵ带 ��ȸ���ּ���
-- ��ȸĮ���� ȸ�����̵�, ��ǰ�ڵ�
SELECT cart_member, cart_prod
  FROM cart
 WHERE cart_member IN (SELECT mem_id 
                                FROM member 
                                    WHERE mem_id = 'a001');

SELECT cart_member, cart_prod
  FROM cart
 WHERE cart_member IN (SELECT mem_id
                                FROM member 
                                    WHERE mem_id = 'a001');

-- ����    
SELECT cart_member, cart_prod
  FROM cart
 WHERE cart_member = 'a001';


