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
  -v $PWD/conf/nginx/sites-enabled:/etc/nginx/sites-enabled \
  -v $PWD/.etc/letsencrypt:/etc/letsencrypt \
  -v $PWD/scripts/:/tmp/scripts \
  -v $PWD/build/:/bin/app \
  -v $PWD/node_modules/:/bin/app/node_modules \
  nginx_with_ssl:latest \
  $EXEC
