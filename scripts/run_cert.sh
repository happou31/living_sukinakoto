#!/bin/bash

. /tmp/env/.env

# nginxのSSL用設定ファイルが存在しない場合のみ実行する
if [ -e /etc/letsencrypt/live/$DOMAIN ]; then
  echo "Certification files exists in /etc/letsencrypt/live/$DOMAIN, skip certbot."
else
  certbot --nginx \
      --non-interactive \
      --agree-tos \
      --renew-by-default \
      --preferred-challenges http \
      -m "$EMAIL" \
      -d "$DOMAIN" \

  echo "0 0,12 * * * root python -c 'import random; import time; time.sleep(random.random() * 3600)' && certbot renew" | tee -a /etc/crontab > /dev/null

fi

cat /etc/nginx/conf.d/ssl-site.conf.in | sed -e "s/@@domain_name@@/$DOMAIN/" > /etc/nginx/conf.d/ssl-site.conf
rm /etc/nginx/conf.d/ssl-site.conf.in

cd /bin/app/
node ./index.js 1> /var/log/nodejs/access.log 2> /var/log/nodejs/error.log &
nginx -g 'daemon off;'
