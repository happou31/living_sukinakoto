#!/bin/bash
. ./.env
PWD=$(pwd)
ARGS=$@
OPTS=""
EXEC=""

for i in ${ARGS[@]}; do
  if [[ $i =~ -.* ]] ; then
    OPTS+="$i "
  else
    EXEC=$i
  fi
done

docker run \
  --rm \
  $OPTS \
  -p $HTTP_PORT:80 \
  -p $HTTPS_PORT:443 \
  -v $PWD/.env:/tmp/env/.env \
  -v $PWD/.etc/letsencrypt:/etc/letsencrypt \
  -v $PWD/.etc/nginx:/usr/share/nginx \
  -v $PWD/scripts/:/tmp/scripts \
  nginx_with_ssl:latest \
  $EXEC
