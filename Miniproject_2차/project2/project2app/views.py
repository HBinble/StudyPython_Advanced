from turtle import width
from django.http import HttpResponse
from django.shortcuts import render

from .model import project2


# Create your views here.

def sample_01(request) :
    return render(
        request,
        "project2app/01_sample.html",
        {}
    )
    
def pest_02(request) :
    return render(
        request,
        "project2app/02_pest.html",
        {}
    )

def factor_03(request) :
    return render(
        request,
        "project2app/03_factor.html",
        {}
    )
def factor_03_01(request) :
    return render(
        request,
        "project2app/03_factor_01.html",
        {}
    )
    
def factor_03_02(request) :
    return render(
        request,
        "project2app/03_factor_02.html",
        {}
    )
    
def factor_03_03(request) :
    return render(
        request,
        "project2app/03_factor_03.html",
        {}
    )    
    
def factor_03_04(request) :
    return render(
        request,
        "project2app/03_factor_04.html",
        {}
    )
    
def factor_03_05(request) :
    return render(
        request,
        "project2app/03_factor_05.html",
        {}
    )
    
def factor_03_06(request) :
    return render(
        request,
        "project2app/03_factor_06.html",
        {}
    )

def factor_03_07(request) :
    return render(
        request,
        "project2app/03_factor_07.html",
        {}
    )

def factor_03_08(request) :
    return render(
        request,
        "project2app/03_factor_08.html",
        {}
    )
                    
def index_02(request) :
    return render(
        request,
        "project2app/02_index_css.html",
        {}
    )
    
def index_03(request) :
    return render(
        request,
        "project2app/03_index_css.html",
        {}
    )
    
def index_04(request) :
    return render(
        request,
        "project2app/04_index_css.html",
        {}
    )
    
def index_05(request) :
    return render(
        request,
        "project2app/05_index_css.html",
        {}
    )
    
def index_06(request) :
    return render(
        request,
        "project2app/06_index_css.html",
        {}
    )

def smartfarm_01(request) :
    return render(
        request,
        "project2app/00_smartfarm.html",
        {}
    )

def foliumfarm(request) :
    return render(
        request,
        "project2app/01_foliumfarm.html",
        {}
    )
    
def smartfarm_center(request) :
    return render(
        request,
        "project2app/01_smartfarmcenter.html",
        {}
    )
    
def index_farm(request) :
    return render(
        request,
        "project2app/index.html",
        {}
    )
    
############################# 그래프 그리기, 이미지 저장 ################################

import pandas as pd
import scipy.stats as stats
import seaborn as sns
import matplotlib.pyplot as plt
import folium

## 시각화 및 저장하기(함수로 처리)
def home(request) :
    map = folium.Map(
        location=[34.9007274, 126.9571667],
        zoom_start=10,
        tiles = "OpenStreetMap", 
        width='100%',
        height='100%',)
    
    maps=map._repr_html_()  #지도를 템플릿에 삽입하기위해 iframe이 있는 문자열로 반환 

    return render(
        request,
        "project2app/01_home.html",
        {'map' : maps})
    
############################# DB 저장 ################################

# smartfarm 테이블 생성하기
def createTable(request) :
    project2.createTableSmartfarm()
    return HttpResponse("Create OK....")

# smartfarm 데이터 입력 테이스
def set_Smartfarm_Insert_test(request) :
    psido = "부산광역시"
    psigu = "금정구"
    pproduct = "딸기"
    pleng = 1
    plfleng = 1
    plfwidth = 1
    pstalkleng = 1
    plfcnt = 1
    ppulpdia = 1
    pflwrcnt = 1
    pfruitcnt = 1
    
    project2.setSmartfarmInsert(psido, psigu, pproduct, pleng, plfleng, plfwidth, pstalkleng, plfcnt, ppulpdia, pflwrcnt, pfruitcnt)
    
    return HttpResponse("Insert OK")

# smartfarm 전체 조회하기
def view_Smartfarm_List(request) :
    df = project2.getSmartfarmList()
    
    #return HttpResponse(df.to_html())
    context = {"df" : df.to_html()}
    
    return render(
        request,
        "project2app/list.html",
        context
    )
    
# smartfarm 참여하기 페이지 view
def view_Smartfarm(request) :
    return render(
        request,
        "project2app/smartfarmsurvey.html",
        {}
    )

# 설문 데이터 입력 
def set_Smartfarm_Insert(request) :
    
    psido = request.POST.get("sido")
    psigu = request.POST.get("sigu")
    pproduct = request.POST.get("product")
    pleng = request.POST.get("leng")
    plfleng = request.POST.get("lfleng")
    plfwidth = request.POST.get("lfwidth")
    pstalkleng = request.POST.get("stalkleng")
    plfcnt = request.POST.get("lfcnt")
    ppulpdia = request.POST.get("pulpdia")
    pflwrcnt = request.POST.get("flwrcnt")
    pfruitcnt = request.POST.get("fruitcnt")

    rs = project2.setSmartfarmInsert(psido, psigu, pproduct, pleng, plfleng, plfwidth, pstalkleng, plfcnt, ppulpdia, pflwrcnt, pfruitcnt)
    
    msg = ""
    if rs == "OK" : 
        msg = """<script>
                    alert("입력 되었습니다!")
                    location.href = "/project2/list/"
                </script>"""
                
    return HttpResponse(msg)

# ############################# 설문분석하기 ################################

# # 설문 분석결과 보기
# def survey_Analysis(request) :
    
#     ## 설문 데이터 조회하기
#     df = survey.getSurveyList()
    
#     ## 설문 분석하기(함수로 처리)
#     # rs_df : 분석에 사용된 컬럼 추가된 최종본
#     # rs_ct : 교차표(crossTab) 데이터
#     # rs_msg : 해석결과
#     rs_df, rs_ct, rs_msg = get_Analysis(df)
    
#     ## 시각화 및 저장하기(함수로 처리)
#     view_Visualization(rs_df)
    
#     context = {
#         # 교차표(데이터프레임 형태)를 html로 전환하여 키 생성
#         "crossTab" : rs_ct.to_html(),
        
#         #해석내용
#         "results" : rs_msg
#     }
    
#     return render(
#         request, 
#         "chi2app/analysis.html",
#         context
#     )

# ############################# 그래프 그리기, 이미지 저장 ################################

# import pandas as pd
# import scipy.stats as stats
# import seaborn as sns
# import matplotlib.pyplot as plt


# ## 설문 분석하기
# def get_Analysis(df) :
#     # 성별을 숫자로...(람다 방식 사용...)
#     df["genNum"] = df["gender"].apply(lambda g:1 if g=="남" else 2)
    
#     # 커피숍 이름을 숫자로
#     df["coNum"] = df["co_survey"].apply(lambda c:1 if c == "스타벅스" \
#                     else 2 if c == "커피빈" \
#                     else 3 if c == "이디아" else 4)
    
#     # 교차표 (빈도표) 생성하기
#     crossTab = pd.crosstab(index = df["gender"], columns = df["co_survey"])
    
#     # 검증하기
#     chi, pv, _, _ = stats.chi2_contingency(crossTab)
    
#     # 검증결과
#     results = ""
    
#     if pv > 0.05 :
#         results = "p-value 값이 유의수준 <b>{:.3f} > 0.05</b> 이므로,"\
#                     "<br> 성별에 따라 선호하는 커피브랜드에는 "\
#                     "<b>차이가 없다.(귀무가설 채택)</b>".format(pv)
#     else :
#         results = "p-value 값이 유의수준 <b>{:.3f} <= 0.05</b> 이므로,"\
#                     "<br> 성별에 따라 선호하는 커피브랜드에는 "\
#                     "<b>차이가 있다.(대립가설 채택)</b>".format(pv)
    
#     return df, crossTab, results

# ## 시각화 및 저장하기(함수로 처리)
# def view_Visualization(df) :
#     # 한글 처리
#     plt.rc("font", family="Malgun Gothic")
    
#     # 그래프 사이즈
#     plt.figure(figsize=(18, 18))
    
#     # fig 객체 얻기 : gcf => figure와 같음
#     fig = plt.gcf()
    
#     # 그룹화 하기
#     gen_group = df["co_survey"].groupby(df["coNum"]).count()
    
#     # 그룹에 인덱스 이름 정의하기 (인덱스 번호를 한글 이름으로)
#     gen_group.index = ["스타벅스", "커피빈", "이디아", "탐앤탐스"]
    
#     # 막대그래프 그리기
#     # width = 막대 너비
#     gen_group.plot.bar(color = ["red","green","blue","orange"],
#                         width=0.3)
    
#     # 제목 정의
#     plt.title("커피샵 별 선호도", fontsize= 40)
#     plt.xlabel("커피샵", fontsize = 30)
#     plt.ylabel("선호도 건수", fontsize = 30)
    
#     # x축 y축에 들어가는 값들에 대한 폰트 사이즈 조정
#     # rotation : 기울기
#     plt.xticks(fontsize = 20, rotation = 70)
#     plt.yticks(fontsize = 20)
    
#     # 그래프 저장하기
#     fig.savefig("chi2app/static/chi2app/images/chi2.png")