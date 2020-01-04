FROM nginx:1.17.6

ADD .env /tmp

USER root

RUN . /tmp/.env \
  && rm /tmp/.env \
  && apt-get update \
  && apt-get install -y certbot \
  && certbot certonly \
      --non-interactive \
      --agree-tos \
      --renew-by-default \
      --preferred-challenges http \
      -m "$EMAIL" \
      -d "$DOMAIN" \
  && echo "0 0,12 * * * root python -c 'import random; import time; time.sleep(random.random() * 3600)' && /usr/local/bin/certbot-auto renew" | sudo tee -a /etc/crontab > /dev/null
RUN apt remove wget

USER nginx
