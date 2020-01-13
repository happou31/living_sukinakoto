#!/bin/bash

if [ -e /tmp/once ]; then
  . /tmp/env/.env

  certbot --nginx \
      --non-interactive \
      --agree-tos \
      --renew-by-default \
      --preferred-challenges http \
      -m "$EMAIL" \
      -d "$DOMAIN" \

  cat /etc/nginx/conf.d/ssl-site.conf.in | sed -e "s/@@domain_name@@/$DOMAIN/" > /etc/nginx/conf.d/ssl-site.conf
  rm /etc/nginx/conf.d/ssl-site.conf.in

  echo "0 0,12 * * * root python -c 'import random; import time; time.sleep(random.random() * 3600)' && certbot renew" | tee -a /etc/crontab > /dev/null

  rm /tmp/once
fi

nginx -g 'daemon off;'