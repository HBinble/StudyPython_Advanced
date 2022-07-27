from django.shortcuts import render
from django.http import HttpResponse

# Create your views here.
def index1(request) :
    return HttpResponse("<u>Hello...</u>")

def index_farm(request) :
    return render(
        request,
        "firstapp/index.html",
        {}
    )
    