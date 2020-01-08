FROM nginx:1.17.6

LABEL maintainer "happou31 <happo31@gmail.com>"

USER root

ADD conf/nginx/acme-challenge.conf /etc/nginx/conf.d/
ADD conf/nginx/ssl-site.conf.in /etc/nginx/conf.d/

RUN touch /tmp/once \
  && mkdir /usr/share/nginx/html/letsencrypt \
  && mkdir ~/scripts \
  && apt-get update \
  && apt-get install -y certbot python-certbot-nginx
