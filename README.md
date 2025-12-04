# Wordpress Container image running on Alpine Linux

[![Docker Automated build](https://img.shields.io/docker/automated/yobasystems/alpine-php-wordpress.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/yobasystems/alpine-php-wordpress/)
[![Docker Pulls](https://img.shields.io/docker/pulls/yobasystems/alpine-php-wordpress.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/yobasystems/alpine-php-wordpress/)
[![Docker Stars](https://img.shields.io/docker/stars/yobasystems/alpine-php-wordpress.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/yobasystems/alpine-php-wordpress/)

[![Alpine Version](https://img.shields.io/badge/Alpine%20version-v3.23.0-green.svg?style=for-the-badge&logo=alpine-linux)](https://alpinelinux.org/)
[![Wordpress Version](https://img.shields.io/badge/Wordpress%20version-vlatest-green.svg?style=for-the-badge&logo=wordpress)](https://www.wordpress.org/en/)



This Container image [(yobasystems/alpine-php-wordpress)](https://hub.docker.com/r/yobasystems/alpine-php-wordpress/) is based on the minimal [Alpine Linux](http://alpinelinux.org/) ready for running [WordPress](https://www.wordpress.org/). (Requires external database)

### Alpine Version 3.23.0 (Released 2025-12-03)
##### Wordpress Version latest
##### PHP Version 8.4.15
##### Nginx Version 1.28.0

----


## Table of Contents

- [What is Alpine Linux?](#what-is-alpine-linux)
- [Features](#features)
- [Architectures](#architectures)
- [Tags](#tags)
- [Layers & Sizes](#layers--sizes)
- [How to use this image](#how-to-use-this-image)
- [Image contents & Vulnerability analysis](#image-contents--vulnerability-analysis)
- [Source Repositories](#source-repositories)
- [Container Registries](#container-registries)
- [Links](#links)
- [Donation](#donation)


## 🏔️ What is Alpine Linux?
Alpine Linux is a Linux distribution built around musl libc and BusyBox. The image is only 5 MB in size and has access to a package repository that is much more complete than other BusyBox based images. This makes Alpine Linux a great image base for utilities and even production applications. Read more about Alpine Linux here and you can see how their mantra fits in right at home with Container images.

## What is Wordpress?
WordPress is an online, open source website creation tool written in PHP. But in non-geek speak, it's probably the easiest and most powerful blogging and website content management system (or CMS) in existence today.

## ✨ Features

* Minimal size only, minimal layers
* Memory usage is minimal on a simple install.

## 🏗️ Architectures

* ```:amd64```, ```:x86_64``` - 64 bit Intel/AMD (x86_64/amd64)
* ```:arm64v8```, ```:aarch64``` - 64 bit ARM (ARMv8/aarch64)
* ```:arm32v7```, ```:armhf``` - 32 bit ARM (ARMv7/armhf)

#### 📝 PLEASE CHECK TAGS BELOW FOR SUPPORTED ARCHITECTURES, THE ABOVE IS A LIST OF EXPLANATION

## 🏷️ Tags

* ```:latest``` latest branch based (Automatic Architecture Selection)
* ```:amd64```, ```:x86_64```  amd64 based on latest tag but amd64 architecture
* ```:aarch64```, ```:arm64v8``` Armv8 based on latest tag but arm64 architecture
* ```:armhf```, ```:arm32v7``` Armv7 based on latest tag but arm32 architecture

## 📏 Layers & Sizes

![Version](https://img.shields.io/badge/version-amd64-blue.svg?style=for-the-badge)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/yobasystems/alpine-php-wordpress/amd64.svg?style=for-the-badge)

![Version](https://img.shields.io/badge/version-aarch64-blue.svg?style=for-the-badge)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/yobasystems/alpine-php-wordpress/aarch64.svg?style=for-the-badge)

![Version](https://img.shields.io/badge/version-armhf-blue.svg?style=for-the-badge)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/yobasystems/alpine-php-wordpress/armhf.svg?style=for-the-badge)


## Volume structure

* `/usr/html`: Webroot


## 🚀 How to use this image

## Creating an instance

Make sure you create the folder on the host before starting the container and obtain the correct permissions.

```
mkdir -p /data/{domain}/html

docker run -e VIRTUAL_HOST={domain}.com,www.{domain}.com -v /data/{domain}/html:/usr/html -p 80:80 yobasystems/alpine-php-wordpress

E.G

mkdir -p /data/yobasystems/html

docker run -e VIRTUAL_HOST=yobasystems.co.uk,www.yobasystems.co.uk -v /data/yobasystems/html:/usr/html -p 80:80 yobasystems/alpine-php-wordpress
```

The following user and group id are used, the files should be set to this:
User ID:
Group ID:

```
chown -R 100:101 /data/{domain}/html

E.G

chown -R 100:101 /data/yobasystems/html
```

Populate /data/{domain}/html with your WP files.


The following user and group id are used, the files should be set to this:

User ID:

Group ID:


```
chown -R 100:101 /data/{domain}/html
```

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

```
define('WP_REDIS_HOST', 'redis');
```

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
docker exec <image_id> apk add php84-soap
docker restart <image_name>
```

```
php84-common
php84-pdo_sqlite
php84-pear
php84-ftp
php84-imap
php84-mysqli
php84-json
php84-mbstring
php84-soap
php84-litespeed
php84-sockets
php84-bcmath
php84-opcache
php84-dom
php84-zlib
php84-gettext
php84-fpm
php84-intl
php84-openssl
php84-session
php84-pdo_mysql
php84-embed
php84-xmlrpc
php84-wddx
php84-dba
php84-ldap
php84-xsl
php84-exif
php84-pdo_dblib
php84-bz2
php84-pdo
php84-pspell
php84-sysvmsg
php84-gmp
php84-apache2
php84-pdo_odbc
php84-shmop
php84-ctype
php84-phpdbg
php84-enchant
php84-sysvsem
php84-sqlite3
php84-odbc
php84-pcntl
php84-calendar
php84-xmlreader
php84-snmp
php84-zip
php84-posix
php84-iconv
php84-curl
php84-doc
php84-gd
php84-xml
php84-dev
php84-cgi
php84-sysvshm
php84-pgsql
php84-tidy
php84-pdo_pgsql
php84-phar
php84-mysqlnd
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

## 🔍 Image contents & Vulnerability analysis

| PACKAGE NAME          | PACKAGE VERSION | VULNERABILITIES |
|-----------------------|-----------------|-----------------|


## 📚 Source Repositories

* [Github - yobasystems/alpine-php-wordpress](https://github.com/yobasystems/alpine-php-wordpress)
* [Gitlab - yobasystems/alpine-php-wordpress](https://gitlab.com/yobasystems/alpine-php-wordpress)


## 🐳 Container Registries

* [Dockerhub - yobasystems/alpine-php-wordpress](https://hub.docker.com/r/yobasystems/alpine-php-wordpress/)
* [Quay.io - yobasystems/alpine-php-wordpress](https://quay.io/repository/yobasystems/alpine-php-wordpress)
* [GHCR - yobasystems/alpine-php-wordpress](https://ghcr.io/yobasystems/alpine-php-wordpress)


## 🔗 Links

* [Yoba Systems](https://yoba.systems/)
* [Github - Yoba Systems](https://github.com/yobasystems/)
* [Dockerhub - Yoba Systems](https://hub.docker.com/u/yobasystems/)
* [Quay.io - Yoba Systems](https://quay.io/organization/yobasystems)
* [GHCR - Yoba Systems](https://ghcr.io/yobasystems)
* [Maintainer - Dominic Taylor](https://github.com/dominictayloruk)
