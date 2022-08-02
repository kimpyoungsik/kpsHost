FROM nginx

COPY html /usr/share/nginx/html 
RUN pip install gunicorn
#RUN pip install -r requirements.txt

#EXPOSE 8000  

#docker build -f nginx.Dockerfile -t front-nginx:1.0 .

#docker rm -f $(docker ps -aq)
#docker rmi $(docker images -q)