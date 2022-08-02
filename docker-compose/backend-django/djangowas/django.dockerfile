FROM python:3.10.5
# python 3.7.7 버전의 컨테이너 이미지를 base이미지

MAINTAINER  backend-django <wskyland@gmail.com>
# Docker의 컨테이너를 생성 및 관리 하는 사람의 정보를 기입해줍니다.
RUN apt-get update \
    && apt-get install -y --no-install-recommends  

RUN pip3 install --upgrade pip \&& rm -rf /var/lib/apt/lists/*
 
#  django를 pip를 통해 설치합니다.
RUN pip3 install django

WORKDIR /usr/src/app 

COPY requirements.txt ./
RUN python -m pip install --upgrade pip
RUN pip uninstall numpy
RUN pip install -r requirements.txt

COPY . .

EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]




# docker build -f django.dockerfile  -t backend-django:1.0 .

#docker rm -f $(docker ps -aq)
#docker rmi $(docker images -q)