FROM nginx:alpine

COPY ./data/nginx/* /etc/nginx/conf.d/

EXPOSE 80