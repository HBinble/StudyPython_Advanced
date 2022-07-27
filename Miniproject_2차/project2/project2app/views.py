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