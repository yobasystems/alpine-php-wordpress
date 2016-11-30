# Wordpress Docker image running on Alpine Linux

[![Docker Layers](https://img.shields.io/badge/docker%20layers-8-blue.svg?maxAge=2592000?style=flat-square)](https://hub.docker.com/r/yobasystems/alpine-php-wordpress/) [![Docker Size](https://img.shields.io/badge/docker%20size-48%20MB-blue.svg?maxAge=2592000?style=flat-square)](https://hub.docker.com/r/yobasystems/alpine-php-wordpress/) [![Docker Stars](https://img.shields.io/docker/stars/yobasystems/alpine-php-wordpress.svg?maxAge=2592000?style=flat-square)](https://hub.docker.com/r/yobasystems/alpine-php-wordpress/) [![Docker Pulls](https://img.shields.io/docker/pulls/yobasystems/alpine-php-wordpress.svg?maxAge=2592000?style=flat-square)](https://hub.docker.com/r/yobasystems/alpine-php-wordpress/)

[![Alpine Version](https://img.shields.io/badge/alpine%20version-v3.4-green.svg?maxAge=2592000?style=flat-square)](http://alpinelinux.org/) [![Wordpress Version](https://img.shields.io/badge/wordpress%20version-vlatest-green.svg?maxAge=2592000?style=flat-square)](http://wordpress.org/en/)



This Docker image [(yobasystems/alpine-php-wordpress)](https://hub.docker.com/r/yobasystems/alpine-php-wordpress/) is based on the minimal [Alpine Linux](http://alpinelinux.org/) ready for running [WordPress](https://www.wordpress.org/). (Requires external database)

## Features

  * Minimal size only 48 MB and only 8 layers
  * Memory usage is minimal on a simple install
  * [PHP](http://pkgs.alpinelinux.org/package/main/x86/php) 7
  * [Nginx](http://pkgs.alpinelinux.org/package/main/x86/nginx) 1.11.4
  * Memory usage is around 55mb on a simple install.


## Creating an instance

    mkdir -p /data/{domain}/html

    docker run -e VIRTUAL_HOST={domain}.com,www.{domain}.com -v /data/{domain}/html:/usr/html -p 80:80 yobasystems/alpine-php-wordpress

    E.G

    mkdir -p /data/yobasystems/html

    docker run -e VIRTUAL_HOST=yobasystems.co.uk,www.yobasystems.co.uk -v /data/yobasystems/html:/usr/html -p 80:80 yobasystems/alpine-php-wordpress

Make sure you create the folder on the host before starting the container and obtain the correct permissions.

```bash

mkdir -p /data/{domain}/html

docker run -e VIRTUAL_HOST={domain}.com,www.{domain}.com -v /data/{domain}/html:/usr/html -p 80:80 yobasystems/alpine-php-wordpress

E.G

mkdir -p /data/yobasystems/html

docker run -e VIRTUAL_HOST=yobasystems.co.uk,www.yobasystems.co.uk -v /data/yobasystems/html:/usr/html -p 80:80 yobasystems/alpine-php-wordpress

```
The following user and group id are used, the files should be set to this:
User ID:
Group ID:

```bash
chown -R 100:101 /data/{domain}/html

E.G

chown -R 100:101 /data/yobasystems/html
```

Populate /data/{domain}/html with your WP files.


The following user and group id are used, the files should be set to this:
User ID:
Group ID:

```bash
chown -R 100:101 /data/{domain}/html
```



### Volume structure

* `/usr/html`: Webroot


### WP-CLI

This image now includes WP-CLI wpcli.org baked in... Its best to `su nginx` before executing anything or else you can potentially compromise your host.

```
docker exec -it <container_name> bash
su nginx
cd /usr/html
wp-cli core download --locale=en_GB

```

### Redis Cache

Edit the wp-config.php file and include the line;

    define('WP_REDIS_HOST', 'redis');

The next thing is to install the plugin [Redis Object Cache](https://wordpress.org/plugins/redis-cache/)


### SSL behind a proxy

If using SSL and running behind a proxy like HAproxy then the following needs to be added to the wp-config.php file (to stop infinite redirect);

```
define('FORCE_SSL_ADMIN', true);
if (strpos($_SERVER['HTTP_X_FORWARDED_PROTO'], 'https') !== false)
   $_SERVER['HTTPS']='on';
```

### Upload limit

The upload limit is 128 Megabytes.

### Change php.ini value
modify files/php-fpm.conf

To modify php.ini variable, simply edit php-fpm.ini and add php_flag[variable] = value.

```
php_flag[display_errors] = on
```

### PHP Modules
#### List of available modules in Alpine Linux, not all these are installed.
##### In order to install a php module do, (leave out the version number i.e. -5.6.11-r0
```
docker exec <image_id> apk add <pkg_name>
docker restart <image_name>
```
Example:

```
docker exec <image_id> apk add php7-soap
docker restart <image_name>
```

```
php7-soap-5.6.11-r0
php7-openssl-5.6.11-r0
php7-gmp-5.6.11-r0
php7-phar-5.6.11-r0
php7-embed-5.6.11-r0
php7-pdo_odbc-5.6.11-r0
php7-mysqli-5.6.11-r0
php7-common-5.6.11-r0
php7-ctype-5.6.11-r0
php7-fpm-5.6.11-r0
php7-shmop-5.6.11-r0
php7-xsl-5.6.11-r0
php7-curl-5.6.11-r0
php7-pear-net_idna2-0.1.1-r0
php7-json-5.6.11-r0
php7-dom-5.6.11-r0
php7-pspell-5.6.11-r0
php7-sockets-5.6.11-r0
php7-pear-mdb2-driver-pgsql-2.5.0b5-r0
php7-pdo-5.6.11-r0
phpldapadmin-1.2.3-r3
php7-pear-5.6.11-r0
php7-phpmailer-5.2.0-r0
phpmyadmin-doc-4.4.10-r0
php7-cli-5.6.11-r0
php7-zip-5.6.11-r0
php7-pgsql-5.6.11-r0
php7-sysvshm-5.6.11-r0
php7-imap-5.6.11-r0
php7-intl-5.6.11-r0
php7-embed-5.6.11-r0
php7-zlib-5.6.11-r0
php7-phpdbg-5.6.11-r0
php7-sysvsem-5.6.11-r0
phpmyadmin-4.4.10-r0
php7-mysql-5.6.11-r0
php7-sqlite3-5.6.11-r0
php7-cgi-5.6.11-r0
php7-apcu-4.0.7-r1
php7-snmp-5.6.11-r0
php7-pdo_pgsql-5.6.11-r0
php7-xml-5.6.11-r0
php7-wddx-5.6.11-r0
php7-sysvmsg-5.6.11-r0
php7-enchant-5.6.11-r0
php7-bcmath-5.6.11-r0
php7-pear-mail_mime-1.8.9-r0
php7-apache2-5.6.11-r0
php7-gd-5.6.11-r0
php7-pear-mdb2-driver-sqlite-2.5.0b5-r0
php7-xcache-3.2.0-r1
php7-odbc-5.6.11-r0
php7-mailparse-2.1.6-r2
php7-ftp-5.6.11-r0
perl-php7-serialization-0.34-r1
php7-exif-5.6.11-r0
php7-pdo_mysql-5.6.11-r0
php7-ldap-5.6.11-r0
php7-pear-mdb2-2.5.0b5-r0
php7-dbg-5.6.11-r0
php7-pear-net_smtp-1.6.2-r0
php7-opcache-5.6.11-r0
php7-pdo_sqlite-5.6.11-r0
php7-posix-5.6.11-r0
php7-dba-5.6.11-r0
php7-iconv-5.6.11-r0
php7-gettext-5.6.11-r0
php7-xmlreader-5.6.11-r0
php7-5.6.11-r0
php7-xmlrpc-5.6.11-r0
php7-bz2-5.6.11-r0
perl-php7-serialization-doc-0.34-r1
php7-mcrypt-5.6.11-r0
php7-memcache-3.0.8-r3
xapian-bindings-php7-1.2.21-r1
php7-pdo_dblib-5.6.11-r0
php7-phalcon-2.0.3-r0
php7-dev-5.6.11-r0
php7-doc-5.6.11-r0
php7-mssql-5.6.11-r0
php7-calendar-5.6.11-r0
php7-pear-mdb2-driver-mysqli-2.5.0b5-r0
php7-pear-mdb2-driver-mysql-2.5.0b5-r0
```

## Docker Compose example:

```yalm
wordpress:
  image: yobasystems/alpine-php-wordpress
  environment:
    VIRTUAL_HOST: example.co.uk
  expose:
    - "80"
  volumes:
    - /data/example/www:/usr/html
  restart: always
  links:
    - mysql:mysql
mysql:
  environment:
    MYSQL_DATABASE: wordpressdb
    MYSQL_PASSWORD: wordpresspass
    MYSQL_ROOT_PASSWORD: ''
    MYSQL_USER: wordpressuser
  image: yobasystems/alpine-mariadb
```

## Source Repository

* [Bitbucket - yobasystems/alpine-php-wordpress](https://bitbucket.org/yobasystems/alpine-php-wordpress/)

* [Github - yobasystems/alpine-php-wordpress](https://github.com/yobasystems/alpine-php-wordpress)

## Links

* [Yoba Systems](https://www.yobasystems.co.uk/)

* [Dockerhub - yobasystems](https://hub.docker.com/u/yobasystems/)
