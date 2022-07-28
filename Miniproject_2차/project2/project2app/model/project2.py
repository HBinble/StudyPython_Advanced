import pandas as pd
import cx_Oracle 


# 오라클 연결 및 접속하기
def getConnection() :
    # 오라클 연결하기
    dsn = cx_Oracle.makedsn("localhost", 1521, "orcl")
    
    # 오라클 접속하기
    conn = cx_Oracle.connect("busan_06", "dbdb", dsn)
    return conn

# 커서 받기
def getCursor(conn) :
    cursor = conn.cursor()
    return cursor

# 접속정보 및 커서 반납하기
def dbClose(cursor, conn) :
    # 커서 반납 먼저
    cursor.close()
    # 마지막에 접속정보 반납
    conn.close()
    
### 딕셔너리 주문내역 전체조회
def getDBTest() :
    conn = getConnection()
    cursor = getCursor(conn)
    
    sql = """ SELECT * FROM cart """
    cursor.execute(sql)
    
    row = cursor.fetchall()
    
    dbClose(cursor, conn)
    
    return row

############# smartfarm 테이블 생성하기 #############
def createTableSmartfarm() :
    conn = getConnection()
    cursor = getCursor(conn)
    
    sql = """Create Table smartfarm
            (
                rnums number(15) not null,
                sido varchar2(20),
                sigu varchar2(20),
                product varchar2(20) not null,
                leng number(15) not null,
                lfleng number(15) not null,
                lfwidth number(15) not null,
                stalkleng number(15) not null,
                lfcnt number(15) not null,
                pulpdia number(15) not null,
                flwrcnt number(15) not null,
                fruitcnt varchar2(50) not null,
                Constraint pk_rnums Primary key(rnums)
            )"""
    
    cursor.execute(sql)
    
    dbClose(cursor, conn)
    
# 설문 입력하기
def setSmartfarmInsert(psido, psigu, pproduct, pleng, plfleng, plfwidth, pstalkleng, plfcnt, ppulpdia, pflwrcnt, pfruitcnt) : 
    conn = getConnection()
    cursor = getCursor(conn)
    
    # rnums 자동 생성하기
    sql = """SELECT nvl(max(rnums)+1, 1) as max_no
                FROM smartfarm"""   
    cursor.execute(sql)
    rs_max_no = cursor.fetchone()
    no = rs_max_no[0]
    
    # 저장하기
    sql = """INSERT INTO smartfarm(
                rnums, sido, sigu, product, leng, lfleng, lfwidth, stalkleng, lfcnt, pulpdia, flwrcnt, fruitcnt
                ) values(
                    :rnums, :sido, :sigu, :product, :leng, :lfleng, :lfwidth, :stalkleng, :lfcnt, :pulpdia, :flwrcnt, :fruitcnt
                )"""
    cursor.execute(sql,
                    rnums = no,
                    sido = psido,
                    sigu = psigu,
                    product = pproduct,
                    leng = pleng,
                    lfleng = plfleng,
                    lfwidth = plfwidth,
                    stalkleng = pstalkleng,
                    lfcnt = plfcnt,
                    pulpdia = ppulpdia,
                    flwrcnt = pflwrcnt,
                    fruitcnt = pfruitcnt,
                    )
    conn.commit()
    
    dbClose(cursor, conn)
    return "OK"

def getSmartfarmList() :
    conn = getConnection()
    cursor = getCursor(conn)
    
    sql = """ SELECT * FROM smartfarm """
    cursor.execute(sql)
    
    row = cursor.fetchall()
    
    # 컬럼명 조회하기
    colname = cursor.description
    col = []
    for i in colname :
        col.append(i[0].lower())
    
    dbClose(cursor, conn)
    
    # 데이터 프레임에 조회 결과 넣기
    df = pd.DataFrame(row, columns = col)
    
    return df