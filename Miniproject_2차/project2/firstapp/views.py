from django.shortcuts import render

from django.http import HttpResponse

from .models import Curriculum

# Create your views here.
# def index1(request) :
#     return HttpResponse("<u>Hello</u>")

# def index2(request) :
#     return HttpResponse("<p>index2 함수를 호출했습니다.</>")

def main(request) :
    return HttpResponse("<p>Main..</p>")

def home(request) :
    return HttpResponse("<p>Home</p>")

# insert 방식 3가지
def insert(request) :
    msg = ""    
    # 줄바꿈 <br>
    # 1-linux 입력
    Curriculum.objects.create(name='linux')
    msg += "1-linux 입력 성공 <br>"
    
    # 2-python 입력
    c = Curriculum(name='python')
    c.save()
    msg += "2-python 입력 성공 <br>"
    
    # 3-html/css/js 입력
    Curriculum(name='3=html/css/js').save()
    msg += "3-html/css/js 입력 성공 <br>"
    
    # 4-django 입력
    Curriculum(name='django').save()
    msg += "4-django 입력 성공 <br>"
    
    return HttpResponse(msg)

# 전체 조회
# first/show
def show(request) :
    data = Curriculum.objects.all()
    
    msg = ""
    for dt in data:
        msg += dt.name + "<br>"
        
    return HttpResponse(msg)

# 한건 조회
# first/oneshow
def oneshow(request) :
    onedata = Curriculum.objects.get(pk=3)
    return HttpResponse(onedata.name)


## html 호출
def show2(request) :
    return render(
        request,
        "firstapp/show2.html",
        {}
    )
# 전체 조회    
def show3(request) :
    data = Curriculum.objects.all()
    
    return render(
        request,
        "firstapp/show3.html",
        {"data" : data}
    )
    
def show4(request) :
    data = Curriculum.objects.all()
    
    return render(
        request,
        "firstapp/show4.html",
        {"data" : data}
    )

# 수정하기
def update(request) :
    data = Curriculum.objects.get(pk=1)
    data.name = "linux_update"
    data.save()
    return HttpResponse("수정 성공")

# 삭제하기
def delete(request) :
    data = Curriculum.objects.get(pk=1)
    data.delete()
    return HttpResponse("삭제 성공")