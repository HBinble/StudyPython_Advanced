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

# 한건 행에 대한 딕셔너리 만드는 함수 
def getDictType_FetchOne(col_name, row_one) :
    dict_row = {}
    
    for i in range(0, len(row_one), 1) :
        dict_row[col_name[i].lower()] = row_one[i] 
    return dict_row

# 한건 행에 대한 로그인 함수
def getLogin(id, pw) :
    conn = getConnection()
    cursor = getCursor(conn)
    
    sql = """ SELECT mem_id, mem_pass, mem_name
                FROM member 
                WHERE mem_id = :mem_id
                AND mem_pass = :mem_pass """
    cursor.execute(sql,
                    mem_id = id,
                    mem_pass = pw)
    
    # 한건 조회
    row = cursor.fetchone()
    
    # row의 값이 없는 경우 : 조회 결과가 없는 경우
    # 아이디 또는 패스워드가 틀린 경우 조회 결과 없음..
    # 조회결과 없으면 오류 발생
    if row == None :
        dbClose(cursor, conn)
        return {"rs" : "no"}
    
    # 컬럼명 조회하기
    colname = cursor.description
    col = []
    for i in colname :
        col.append(i[0])
    
    # 딕셔너리로 데이터 구성하기..
    dict_row = getDictType_FetchOne(col, row)
    dict_row["rs"] = "yes"
    
    dbClose(cursor,conn)
    
    return dict_row