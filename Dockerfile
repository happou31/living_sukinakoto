FROM nginx:1.17.6
FROM node:12.14.0

USER root

RUN echo 8.8.8.8 >> /etc/resolv.conf \
  && echo 8.8.4.4 >> /etc/resolv.conf \
  && apt-get update \
  && apt-get install -y --no-install-recommends wget \
  && apt-get -y clean \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://dl.eff.org/certbot-auto \
  && mv certbot-auto /usr/local/bin/certbot-auto \
  && chown root /usr/local/bin/certbot-auto \
  && chmod 0755 /usr/local/bin/certbot-auto \
  && mkdir -p /var/www/html/.well-known/acme-challenges/ \
  && chown -R nginx:nginx /var/www/html/.well-known \
  && /usr/local/bin/certbot-auto --nginx \
      --standalone \
      --non-interactive \
      --agree-tos \
      --renew-by-default \
      --preferred-challenges http \
  && echo "0 0,12 * * * root python -c 'import random; import time; time.sleep(random.random() * 3600)' && /usr/local/bin/certbot-auto renew" | sudo tee -a /etc/crontab > /dev/null
RUN apt remove wget

USER nginx
