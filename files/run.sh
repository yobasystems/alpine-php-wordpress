#!/bin/ash

[ -f /run-pre.sh ] && /run-pre.sh

if [ ! -d /etc/nginx/html ] ; then
  mkdir -p /etc/nginx/html
  chown -R nginx:www-data /etc/nginx/html
else
  chown -R nginx:www-data /etc/nginx/html
fi

chown -R nginx:www-data /etc/nginx/html

# start php-fpm
mkdir -p /usr/logs/php-fpm
php-fpm

# start nginx
mkdir -p /tmp/nginx
chown nginx /tmp/nginx
nginx
