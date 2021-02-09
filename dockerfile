FROM nginx:alpine

COPY ./data/nginx/* /etc/nginx/conf.d/

ADD ./config/.htpasswd /etc/nginx/pass/

EXPOSE 80
