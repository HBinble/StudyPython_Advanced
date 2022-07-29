from django.urls import path

from . import views

urlpatterns = [
    path('sample01/', views.sample_01),
    path('pest/', views.pest_02),
    path('factor/', views.factor_03),
    path('factor01/', views.factor_03_01),
    path('factor02/', views.factor_03_02),
    path('factor03/', views.factor_03_03),
    path('factor04/', views.factor_03_04),
    path('factor05/', views.factor_03_05),
    path('factor06/', views.factor_03_06),
    path('factor07/', views.factor_03_07),
    path('factor08/', views.factor_03_08),
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
]
