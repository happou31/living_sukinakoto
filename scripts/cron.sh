#!/bin/bash
PORT=${PORT:-10080}
docker run \
  --rm \
  -p "$PORT:80" \
  -v /etc/letsencrypt:/etc/letsencrypt \
  -v /var/log/letsencrypt:/var/log/letsencrypt \
  deliverous/certbot renew
