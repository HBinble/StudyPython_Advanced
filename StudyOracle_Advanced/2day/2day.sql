-- 2day

-- ȸ������ ��ü ��ȸ
SELECT * 
  FROM member ;

-- ��̰� ������ ȸ���� �߿� 
-- ���ϸ����� ���� 1000 �̻��� 
-- ȸ�����̵�, ȸ���̸�, ȸ�����, ȸ�����ϸ��� ��ȸ
-- ������ ȸ���̸� ���� ��������
SELECT mem_id, mem_name, mem_like, mem_mileage
  FROM member
 WHERE mem_like = '����' 
   AND mem_mileage >= 1000
 ORDER BY mem_name ASC;
 
-- ������ ȸ���� ������ ��̸� ������
-- ȸ�����̵�, ȸ���̸�, ȸ����� ��ȸ�ϱ�
SELECT mem_id, mem_name, mem_like
  FROM member
 WHERE mem_like = (SELECT mem_like 
                     FROM member 
                    WHERE mem_name = '������');

-- �ֹ������� �ִ� ȸ���� ���� ������ ��ȸ�Ϸ� �մϴ�.
-- ȸ�����̵�, ȸ���̸�, �ֹ���ȣ, �ֹ����� ��ȸ�ϱ� (column ��������)
SELECT cart_member, cart_no, cart_qty,
        (SELECT mem_name
           FROM member
          WHERE mem_id = cart_member) as name 
  FROM cart;

-- �ֹ������� �ִ� ȸ���� ���� ������ ��ȸ�Ϸ� �մϴ�.
-- ȸ�����̵�, ȸ���̸�, �ֹ���ȣ, �ֹ�����, ��ǰ�� ��ȸ�ϱ�
SELECT cart_member, cart_no, cart_qty,
        (SELECT mem_name
           FROM member
          WHERE mem_id = cart_member) as name,
        (SELECT prod_name
           FROM prod
          WHERE prod_id = cart_prod) as prod_name
  FROM cart;

-- a001 ȸ���� �ֹ��� ��ǰ�� ���� 
-- ��ǰ�з��ڵ�, ��ǰ�з��� ��ȸ�ϱ�
SELECT lprod_gu, lprod_nm
  FROM lprod
 WHERE lprod_gu IN (SELECT prod_lgu
                      FROM prod
                     WHERE prod_id IN (SELECT cart_prod
                                         FROM cart
                                        WHERE cart_member = 'a001'));   

-- �̻��̶�� ȸ���� �ֹ��� ��ǰ �߿�
-- ��ǰ�з��ڵ尡 P201�̰�,
-- �ŷ�ó�ڵ尡 P20101��
-- ��ǰ�ڵ�, ��ǰ���� ��ȸ���ּ���
SELECT prod_id, prod_name
  FROM prod
 WHERE prod_lgu = 'P201'
   AND prod_buyer = 'P20101'
   AND prod_id IN (
        SELECT cart_prod
          FROM cart
         WHERE cart_member IN (
               SELECT mem_id
                 FROM member
                WHERE mem_name = '�̻���'));

-- ��������(SubQuery) ����
--(���1) SELECT ��ȸ �÷� ��ſ� ����ϴ� ���
--   : ���� �÷��� �����ุ ��ȸ

--(���2) WHERE ���� ����ϴ� ���
--   IN () : �����÷��� ������ �Ǵ� ������ ��ȸ ����
--   =     : �����÷��� �����ุ ��ȸ ����


-- LIKE '����' �Ǵ� NOT LIKE '����'
SELECT prod_id ��ǰ�ڵ�, prod_name ��ǰ�� 
  FROM prod
 WHERE prod_name LIKE '��%'; --ó������ '��'���� �����ϴ� ��� ���� ã�ƶ�

SELECT prod_id ��ǰ�ڵ�, prod_name ��ǰ��
  FROM prod
 WHERE prod_name LIKE '_��%'; --�ι�°����'��'���� �����ϴ� ��� ��
 
SELECT prod_id ��ǰ�ڵ�, prod_name ��ǰ��
  FROM prod
 WHERE prod_name LIKE '%ġ'; -- 'ġ'�� ������ ��� ��

SELECT prod_id ��ǰ�ڵ�, prod_name ��ǰ��
  FROM prod
 WHERE prod_name NOT LIKE 'ġ%';
 
SELECT prod_id ��ǰ�ڵ�, prod_name ��ǰ��
  FROM prod
 WHERE prod_name LIKE '%����%';
 
SELECT lprod_gu �з��ڵ�, lprod_nm �з���
  FROM lprod
 WHERE lprod_nm LIKE '%ȫ\%' ESCAPE '\';

-- �Լ�(���ڿ�) 
SELECT 'a' || 'bcde'
  FROM dual;
  
SELECT mem_id || 'name is' || mem_name 
  FROM member;

-- TRIM
SELECT '<' || TRIM('   A   AA   ') || '>' TRIM1,
       '<' || TRIM(LEADING 'a' FROM 'aaAaBaAaa') || '>' TRIM2,
       '<' || TRIM('a' FROM 'aaAaBaAaa') || '>' TRIM3
FROM dual;

-- ��SUBSTR(c,m,[n] = c���ڿ� m��ġ n��ŭ ���� ����)
SELECT mem_id, SUBSTR(mem_name, 1, 1) ����
  FROM member;

-- ��ǰ���̺��� ��ǰ���� 4° �ڸ����� 2���ڰ� 'Į��'�� ��ǰ�� ��ǰ�ڵ�, ��ǰ���� �˻��Ͻÿ�
SELECT prod_id, prod_name, SUBSTR(prod_name, 4, 2) AS subNM
  FROM prod
 WHERE SUBSTR(prod_name, 4, 2) = 'Į��';
 
-- REPLACE(c1,c2,[c3] = c1�� ���Ե� c2���ڸ� c3������ ġȯ
SELECT buyer_name, REPLACE(buyer_name, '��', '��') "��->��"
  FROM buyer;
-- ȸ�����̺��� ȸ������ �� '��' �� ���� '��' �� ������ ġȯ �˻��Ͻÿ� (������ �ٲ� �� �̸���ȸ)
SELECT REPLACE(SUBSTR(mem_name,1,1), '��', '��') ||
               SUBSTR(mem_name,2,2) "�� -> ��"
  FROM member;
  
-- ��ǰ�з� �߿� '����'�� ���Ե� ��ǰ�� ������ ȸ�� ��ȸ�ϱ�
-- ȸ�����̵�, ȸ���̸� ��ȸ�ϱ�
-- ��, ��ǰ�� �Ｚ���ڰ� ���Ե� ��ǰ�� ������ ȸ��
-- �׸���, ȸ���� ��̰� ������ ȸ��
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
                       AND prod_lgu IN(
                        SELECT lprod_gu
                          FROM lprod
                         WHERE lprod_nm LIKE '%����%')));
                         
--�Լ�(���ڿ�)
-- ROUND(n,l) = (�÷���, ��ġ) : �ݿø�
-- ROUND(n,l) = (�÷���, ��ġ) : ����
-- ȸ�� ���̺��� ���ϸ����� 12�� ���� ���� �˻� 
-- (�Ҽ�3°�ڸ� �ݿø�, ����)
SELECT mem_mileage, (mem_mileage / 12),
        ROUND(mem_mileage / 12, 2),
        TRUNC(mem_mileage / 12, 2)
  FROM member;

-- MOD(c,n)= n���� ���� ������
SELECT MOD(10,3)
  FROM dual;
  
-- ȸ����ȸ, ���� = 1 ���� = 0 ���� ��ȸ  
SELECT mem_id, mem_name, mem_regno1, mem_regno2, 
        MOD(SUBSTR(mem_regno2,1,1), 2) as sex
  FROM member;
  
-- SYSDATE(�ý��ۿ��� �����ϴ� ���� ��¥�� �ð� ��)
SELECT SYSDATE "����ð�",
       SYSDATE-1 "���� �̽ð�",
       SYSDATE+1 "���� �̽ð�"
  FROM dual;
-- ȸ�����̺��� ���ϰ� 12000��° �Ǵ� ���� �˻��Ͻÿ�?
SELECT mem_name, mem_bir, mem_bir + 12000 "12000��°"
  FROM member;
  
SELECT ADD_MONTHS(SYSDATE, 5)
  FROM dual;
  
SELECT NEXT_DAY(SYSDATE,'������'),
       LAST_DAY(SYSDATE)
  FROM dual;
  
SELECT LAST_DAY(SYSDATE) - SYSDATE
  FROM dual; 
 
-- ROUND = �ݿø�
SELECT ROUND(SYSDATE, 'YYYY'),
       ROUND(SYSDATE, 'Q')
  FROM dual;

-- EXTRACT (fmt FROM date) = ��¥���� �ʿ��� �κи� ���� - �⵵,��,��,�ð�,��,�� ���� ���� ����
-- fmt = YEAR, MONTH, DAY, HOUR, MINUTE, SECOND
SELECT EXTRACT(YEAR FROM SYSDATE) "�⵵",
       EXTRACT(MONTH FROM SYSDATE) "��",
       EXTRACT(DAY FROM SYSDATE) "��"
  FROM dual;
-- ������ 3���� ȸ���� �˻��Ͻÿ�?  
SELECT mem_id, mem_name, mem_bir
  FROM member
 WHERE EXTRACT(MONTH FROM mem_bir) = 3;
 
-- CAST(expr AS type) = ��������� �� ��ȯ
-- CHAR(�޸� ��ȿ�� : �����)
SELECT '[' || CAST('Hello' AS CHAR(30)) || ']' "����ȯ"
  FROM dual;
-- VARCHAR(�޸� ȿ�� : ������)
SELECT '[' || CAST('Hello' AS VARCHAR(30)) || ']' "����ȯ"
  FROM dual;  
  
-- 0000-00-00, 0000/00/00, 0000.00.00, 00000000,
--   00-00-00,  00/00/00,   00.00.00
SELECT CAST('1997/12/25' AS DATE)
  FROM dual;

-- TO_CHAR : ����,����,��¥�� ������ ������ ���ڿ� ��ȯ
-- TO_NUMBER : ���������� ���ڿ��� ���ڷ� ��ȯ
-- TO_
SELECT TO_CHAR(SYSDATE, 'AD YYYY,CC"����"')
  FROM dual;
--
SELECT
        TO_CHAR(CAST('2008-12-25' AS DATE),
                'YYYY.MM.DD HH24:MI')
  FROM dual;
-- ��ǰ���̺��� ��ǰ�԰����� "2008-09-28" �������� ������ �˻��Ͻÿ�
SELECT prod_insdate, TO_CHAR(prod_insdate, 'YYYY-MM-DD')
  FROM prod;
-- ȸ���̸��� ���Ϸ� ����ó�� ��µǰ� �ۼ��Ͻÿ�
-- ex) ��������� 1976�� 1�� ����̰� �¾ ������ �����
SELECT mem_name || '���� ' || TO_CHAR(mem_bir,'YYYY')|| '�� ' 
        || TO_CHAR(mem_bir, 'MM') || '�� ����̰� �¾ ������ ' 
        || TO_CHAR(mem_bir, 'DAY')
  FROM member;

-- ���� FORMAT
SELECT TO_CHAR(1234.6, '99,999.00'),
       TO_CHAR(1234.6, '9999.99'),
       TO_CHAR(1234.6, '999,999,999.99'),
       TO_CHAR(1234.6, '999.99')
  FROM dual;
  
SELECT TO_CHAR(-1234.6, 'L9999.00PR'),
       TO_CHAR(-1234.6, 'L9999.99PR')
  FROM dual;
  
-- ���� ��� ����
Alter User ����ڰ��� Account Unlock;
  
-- ������ ȸ���� ������ ��ǰ �߿�
-- ��ǰ�з��� ���ڰ� ���ԵǾ� �ְ�,
-- �ŷ�ó�� ������ ������
-- ��ǰ�ڵ�, ��ǰ�� ��ȸ�ϱ�

-- �� ��
SELECT prod_id, prod_name
  FROM prod
 WHERE prod_name LIKE '%����%'
     AND prod_buyer IN(
            SELECT buyer_id
              FROM buyer
             WHERE SUBSTR(buyer_add1, 1, 2) = '����')
     AND prod_id IN (
            SELECT cart_prod
              FROM cart
             WHERE cart_member IN (
                 SELECT mem_id
                  FROM member
                 WHERE MOD(SUBSTR(mem_regno2,1,1), 2) = 0));

-- ����     
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

-- ���� �Լ�(GROUP)
-- AVG(column) = DISTINCT �ߺ��� ���� / ALL : Defalut
SELECT ROUND(AVG(DISTINCT prod_cost),2) AS rnd1, 
        ROUND(AVG(ALL prod_cost), 2) AS rnd2, 
        ROUND(AVG(prod_cost), 3) AS rnd3
  FROM prod;
  
-- COUNT(col) , COUNT(*)
SELECT COUNT(DISTINCT prod_cost), COUNT(ALL prod_cost),
       COUNT(prod_cost), COUNT(*)
  FROM prod;
-- ȸ�����̺��� ������ COUNT �����Ͻÿ�
SELECT mem_job, 
    COUNT(mem_job), COUNT(*)
  FROM member
  GROUP BY mem_job;
  
-- �׷�(����) �Լ��� ����ϴ� ��쿡��
-- - GROUP BY ���� ������� �ʾƵ� ��.(������ ��ü column)
-- ��ȸ�� �Ϲ��÷��� ���Ǵ� ��쿡�� GROUP BY ���� ����ؾ� �մϴ�.
-- - GROUP BY ������ ��ȸ�� ���� �Ϲ� �÷��� ������ �־��ݴϴ�.
-- - �Լ��� ����� ��쿡�� �Լ��� ����� ���� �״�θ� �־��ݴϴ�.
-- ORDER BY ���� ����ϴ� �Ϲ��÷� �Ǵ� �Լ��� �̿��� �÷���
-- - ������ GROUP BY ���� �־��ݴϴ�.
-- SUM(), AVG(), MIN(), MAX(), COUNT()
SELECT COUNT(mem_job), COUNT(*)
  FROM member;

SELECT mem_job, mem_like,
    COUNT(mem_job) AS cnt1, COUNT(*) AS cnt2
  FROM member
 WHERE mem_mileage > 10
   AND mem_mileage >= 10
 GROUP BY mem_job, mem_like, mem_id
 ORDER BY cnt1, mem_id DESC;    
 
-- ������ ��̷� �ϴ� ȸ������
-- �ַ� �����ϴ� ��ǰ�� ���� ������ ��ȸ�Ϸ��� �մϴ�.
-- ��ǰ���� count �����մϴ�.
-- ��ȸ�÷�, ��ǰ��, ��ǰ count
-- ������ ��ǰ�ڵ带 �������� ��������.

SELECT prod_name, COUNT(prod_name) as cnt_name
  FROM prod
 WHERE prod_id IN (
    SELECT cart_prod
      FROM cart
     WHERE cart_member IN (
        SELECT mem_id
          FROM member
         WHERE mem_like = '����'))
 GROUP BY prod_name, prod_id
 ORDER BY prod_id DESC;
 
SELECT cart_prod
  FROM cart
 WHERE cart_member IN (
    SELECT mem_id
      FROM member
     WHERE mem_like = '����');
 
