FROM nginx:1.17.6
FROM node:13.6-buster

LABEL maintainer "happou31 <happo31@gmail.com>"

USER root

ADD conf/nginx/acme-challenge.conf /etc/nginx/conf.d/
ADD conf/nginx/ssl-site.conf.in /etc/nginx/conf.d/

RUN mkdir -p /usr/share/nginx/html/letsencrypt \
  && mkdir ~/scripts \
  && apt-get update \
  && apt-get install -y certbot python-certbot-nginx
