FROM nginx:latest

COPY html /usr/share/nginx/html 
COPY nginx.conf /etc/nginx/nginx.conf
COPY frontend.conf /etc/nginx/sites-enabled/

WORKDIR /srv
RUN mkdir letter_web
RUN mkdir ./letter_web/uwsgi
WORKDIR /srv/letter_web
COPY uwsgi ./uwsgi
#RUN pip install gunicorn
#RUN pip install -r requirements.txt

#EXPOSE 8000  

#docker build -f nginx.Dockerfile -t front-nginx:1.0 .
# docker run -dp 9300:8000 -t front-nginx:1.0
#docker rm -f $(docker ps -aq)
#docker rmi $(docker images -q)
#docker ps -a
#docker images
#docker exec -it 155f2fd3ab54 bash
#docker exec -i -t --user root 155f2fd3ab54 bash
CMD ["nginx", "-g", "daemon off;"]
