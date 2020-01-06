FROM nginx:1.17.6

USER root

ADD .env /tmp
ADD conf/nginx/acme-challenge.conf /etc/nginx/conf.d/


RUN mkdir /usr/share/nginx/html/letsencrypt \
  && apt-get update \
  && apt-get install -y certbot python-certbot-nginx

RUN . /tmp/.env \
  && rm /tmp/.env \
  && certbot certonly \
      --nginx \
      --non-interactive \
      --agree-tos \
      --renew-by-default \
      --preferred-challenges http \
      -m "$EMAIL" \
      -d "$DOMAIN" \
  && echo "0 0,12 * * * root python -c 'import random; import time; time.sleep(random.random() * 3600)' && /usr/local/bin/certbot-auto renew" | sudo tee -a /etc/crontab > /dev/null
