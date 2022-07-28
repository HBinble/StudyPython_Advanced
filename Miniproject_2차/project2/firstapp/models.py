from django.db import models

# Create your models(=Tables) here.

# class name == Table name(Curriculum Table 이름)
class Curriculum(models.Model) :
    # 변수 이름 == 컬럼 이름
    name = models.CharField(max_length=255)