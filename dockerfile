FROM nginx:alpine

COPY ./data/nginx/* /etc/nginx/conf.d/

ADD ./config/.htpasswd /etc/nginx/pass/

ADD ./data/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
