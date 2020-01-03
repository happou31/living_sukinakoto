#!/bin/sh

source .env

if [ $DOMAIN = ''  || $EMAIL = '' || $HTTP_PORT = '' || $HTTPS_PORT = '' ]; then
  echo 'You must set environment vars in .env, exit....'
  exit
fi

DIR=(pwd)

docker run \
    --rm \
    -p "$PORT:80" \
    -v $DIR/.etc/letsencrypt:/etc/letsencrypt \
    -v $DIR/.etc/nginx:/etc/nginx \
    -v $DIR/.log:/var/log \
    nginx_with_ssl
