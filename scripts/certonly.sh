#!/bin/bash
PORT=${PORT:-10080}
email=${1:-}
domains=("${@:1}")

if (( $# < 2 )); then
  echo "Usage: $0 email domain [domains...]"
  exit 1
fi

if [[ -n $email ]]; then
  email_opts+=( --email "$email" )
else
  email_opts+=( --register-unsafely-without-email )
fi

domains_opts=()
for domain in ${domains[@]}; do
  domains_opts+=(-d "$domain" )
done

docker run \
  --rm \
  -p "$PORT:80" \
  -v /etc/letsencrypt:/etc/letsencrypt \
  -v /var/log/letsencrypt:/var/log/letsencrypt \
  deliverous/certbot certonly \
  --standalone \
  --non-interactive \
  --agree-tos \
  --renew-by-default \
  --preferred-challenges http \
  "${email_opts[@]}" \
  "${domains_opts[@]}"
