from django.urls import path

from . import views

urlpatterns = [
    path('sample01/', views.sample_01),
    path('pest/', views.pest_02),
    path('factor/', views.factor_03),
    path('index_css02/', views.index_02),
    path('index_css03/', views.index_03),
    path('index_css04/', views.index_04),
    path('index_css05/', views.index_05),
    path('index_css06/', views.index_06),
    path('smartfarm01/', views.smartfarm_01),
    path('smartfarmcenter/', views.smartfarm_center),
    path('home/', views.home),
    path('foliumfarm/', views.foliumfarm),
    path('indexfarm/', views.index_farm),
    path('createtable/', views.createTable),
    path('insertTest/', views.set_Smartfarm_Insert_test),
    path('list/', views.view_Smartfarm_List),
    path('smartfarmsurvey/', views.view_Smartfarm),
    path('insert/', views.set_Smartfarm_Insert),
    # path('analysis/', views.survey_Analysis),
]
