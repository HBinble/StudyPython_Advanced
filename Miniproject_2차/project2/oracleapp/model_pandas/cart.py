import pandas
import cx_Oracle

# DB 연결
def getConnection() : 
    dsn = cx_Oracle.makedsn("localhost", 1521, "orcl")
    
    conn = cx_Oracle.connect("busan_06", "dbdb", dsn)
    
    return conn

def getCursor(conn) :
    cursor = conn.cursor()
    return cursor

def dbClose(cursor, conn) : 
    cursor.close()
    conn.close()

##### <실제 사용하는 함수> #####

### 주문내역 전체조회
def getCartList() :
    conn = getConnection()
    cursor = getCursor(conn)
    
    sql = """ SELECT * FROM cart """
    cursor.execute(sql)
    
    row = cursor.fetchall()
    
    return row

#######################################################################

# 여러건 행에 대한 리스트 + 딕셔너리 만드는 함수
def getDictType_FetchAll(col_name, row) :
    # [(1, 2, 3), (4, 5, 6)]
    # 첫번째 for문 : 리스트에서 튜플 가지고 오기
    # 두번째 for문 : 튜플에서 각각의 값을 가지고 오기
    list_row = []
    for tup in row :
        dict_row = {}
        
        for i in range(0, len(tup), 1) :
            dict_row[col_name[i].lower()] = tup[i]
            
        list_row.append(dict_row)
    return list_row


### 딕셔너리 주문내역 전체조회
def getCartListDict() :
    conn = getConnection()
    cursor = getCursor(conn)
    
    sql = """ SELECT * FROM cart """
    cursor.execute(sql)
    
    row = cursor.fetchall()
    
    # 컬럼명 조회하기
    colname = cursor.description
    col = []
    for i in colname :
        col.append(i[0])
    
    # 딕셔너리로 데이터 구성하기..
    row_list = getDictType_FetchAll(col, row)
    
    dbClose(cursor, conn)
    
    return row_list
    
##########################################################################

# 한건 행에 대한 딕셔너리 만드는 함수 
def getDictType_FetchOne(col_name, row_one) :
    dict_row = {}
    
    for i in range(0, len(row_one), 1) :
        dict_row[col_name[i].lower()] = row_one[i] 
    return dict_row

### 주문내역 상세조회 - 한건조회
def getCart(no, prod) : 
    conn = getConnection()
    cursor = getCursor(conn)
    
    sql = """ SELECT * FROM cart 
                WHERE cart_no = :cart_no
                AND cart_prod = :cart_prod """
    cursor.execute(sql,
                    cart_no=no,
                    cart_prod=prod)
    
    # 한건 조회
    row = cursor.fetchone()
    
    # 컬럼명 조회하기
    colname = cursor.description
    col = []
    for i in colname :
        col.append(i[0])
    
    # 딕셔너리로 데이터 구성하기..
    dict_row = getDictType_FetchOne(col, row)
    
    dbClose(cursor,conn)
    
    return dict_row

##########################################################################

# 주문내역 입력하기
def setCartInsert(id, prod, qty) :
    conn = getConnection()
    cursor = getCursor(conn)
    
    # 주문번호 생성을 위한 sql문 작성
    sql = """ SELECT DECODE(SUBSTR(MAX(cart_no),1,8),
                TO_CHAR(SYSDATE, 'YYYYMMDD'),
                MAX(cart_no)+1,
                TO_CHAR(SYSDATE, 'YYYYMMDD') || '00001') AS max_no
                FROM cart  """
    cursor.execute(sql)
    
    # 한건 조회
    max_no = cursor.fetchone()
    no = max_no[0]
    
    # 주문내역 입력을 위한 sql문 작성
    sql = """ INSERT INTO cart(cart_member, cart_no, cart_prod, cart_qty)
                    VALUES(:cart_member, :cart_no, :cart_prod, :cart_qty) """
    cursor.execute(sql,
                    cart_member = id,
                    cart_no = no,
                    cart_prod = prod,
                    cart_qty = qty)
    
    conn.commit()
    
    dbClose(cursor,conn)
    
    return "Y"

# 주문내역 삭제하기
def setCartDelete(no, prod) :
    conn = getConnection()
    cursor = getCursor(conn)
    
    
    # 주문내역 삭제를 위한 sql문 작성
    sql = """ DELETE FROM cart
                WHERE cart_no = :cart_no
                AND cart_prod = :cart_prod """
                
    cursor.execute(sql,
                    cart_no = no,
                    cart_prod = prod)
    
    conn.commit()
    
    dbClose(cursor,conn)
    
    return "Y"

# 주문내역 수정하기
def setCartUpdate(no, prod, qty) :
    conn = getConnection()
    cursor = getCursor(conn)
    
    
    # 주문내역 삭제를 위한 sql문 작성
    sql = """ UPDATE cart 
                SET cart_qty = :cart_qty
                WHERE cart_no = :cart_no
                AND cart_prod = :cart_prod """
                
    cursor.execute(sql,
                    cart_qty = qty,
                    cart_no = no,
                    cart_prod = prod)
    
    conn.commit()
    
    dbClose(cursor,conn)
    
    return "Y"

