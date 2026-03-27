#!/bin/sh

[ -f /run-pre.sh ] && /run-pre.sh

for entrypoint in /entrypoint.d/*.sh; do
  [ -f "$entrypoint" ] || continue
  echo "[i] Sourcing $entrypoint..."
  . "$entrypoint"
done

echo "[i] Fixing permissions..."
chown -R nginx:www-data /usr/html

NGINX_ACCESS_LOG=${NGINX_ACCESS_LOG:-on}

case "$NGINX_ACCESS_LOG" in
[Oo][Ff][Ff] | [Ff][Aa][Ll][Ss][Ee] | 0 | [Nn][Oo])
  echo "[i] Disabling nginx access logs..."
  sed -i 's#access_log /dev/stdout blocked;#access_log off;#g' /etc/nginx/nginx.conf
  sed -i 's#access_log /dev/stdout;#access_log off;#g' /etc/nginx/nginx.conf
  ;;
esac

# start php-fpm
php-fpm84

# start nginx
chown nginx /tmp/nginx
nginx
