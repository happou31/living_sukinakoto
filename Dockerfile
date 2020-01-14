FROM nginx:1.17.6
FROM node:13.6-buster

LABEL maintainer "happou31 <happo31@gmail.com>"

USER root

RUN mkdir -p /usr/share/nginx/html/letsencrypt \
  && mkdir ~/scripts \
  && apt-get update \
  && apt-get install -y certbot python-certbot-nginx

ADD conf/nginx/ssl-site.conf.in /etc/nginx/conf.d/
ADD .env /tmp/env/
