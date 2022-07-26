from django.shortcuts import render

# Create your views here.

def sample_01(request) :
    return render(
        request,
        "project2app/01_sample.html",
        {}
    )
    
def index_01(request) :
    return render(
        request,
        "project2app/01_index.html",
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
    map = folium.Map(
            location=[34.9007274, 126.9571667],
            zoom_start=10,
            tiles = "OpenStreetMap", 
            width='100%',
            height='100%',)
    markerObjects = folium.Marker(location= [34.5,126.5], popup = "This is a marker!")
    
    #지도에 마커 추가
    markerObjects.add_to(map)
    
    maps=map._repr_html_()  #지도를 템플릿에 삽입하기위해 iframe이 있는 문자열로 반환 

    return render(
        request,
        "project2app/01_smartfarm_center.html",
        {'map' : maps}
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