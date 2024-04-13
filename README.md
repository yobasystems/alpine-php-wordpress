# Wordpress Container image running on Alpine Linux

[![Docker Automated build](https://img.shields.io/docker/automated/yobasystems/alpine-php-wordpress.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/yobasystems/alpine-php-wordpress/)
[![Docker Pulls](https://img.shields.io/docker/pulls/yobasystems/alpine-php-wordpress.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/yobasystems/alpine-php-wordpress/)
[![Docker Stars](https://img.shields.io/docker/stars/yobasystems/alpine-php-wordpress.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/yobasystems/alpine-php-wordpress/)

[![Alpine Version](https://img.shields.io/badge/Alpine%20version-v3.19.1-green.svg?style=for-the-badge&logo=alpine-linux)](https://alpinelinux.org/)
[![Wordpress Version](https://img.shields.io/badge/Wordpress%20version-vlatest-green.svg?style=for-the-badge&logo=wordpress)](https://www.wordpress.org/en/)



This Container image [(yobasystems/alpine-php-wordpress)](https://hub.docker.com/r/yobasystems/alpine-php-wordpress/) is based on the minimal [Alpine Linux](http://alpinelinux.org/) ready for running [WordPress](https://www.wordpress.org/). (Requires external database)

### Alpine Version 3.19.1 (Released 2023-01-26)
##### Wordpress Version latest
##### PHP Version 8.1.28
##### Nginx Version 1.24.0

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
![MicroBadger Layers (tag)](https://img.shields.io/docker/layers/yobasystems/alpine-php-wordpress/amd64.svg?style=for-the-badge)
![MicroBadger Size (tag)](https://img.shields.io/docker/image-size/yobasystems/alpine-php-wordpress/amd64.svg?style=for-the-badge)

![Version](https://img.shields.io/badge/version-aarch64-blue.svg?style=for-the-badge)
![MicroBadger Layers (tag)](https://img.shields.io/docker/layers/yobasystems/alpine-php-wordpress/aarch64.svg?style=for-the-badge)
![MicroBadger Size (tag)](https://img.shields.io/docker/image-size/yobasystems/alpine-php-wordpress/aarch64.svg?style=for-the-badge)

![Version](https://img.shields.io/badge/version-armhf-blue.svg?style=for-the-badge)
![MicroBadger Layers (tag)](https://img.shields.io/docker/layers/yobasystems/alpine-php-wordpress/armhf.svg?style=for-the-badge)
![MicroBadger Size (tag)](https://img.shields.io/docker/image-size/yobasystems/alpine-php-wordpress/armhf.svg?style=for-the-badge)


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
docker exec <image_id> apk add php81-soap
docker restart <image_name>
```

```
php81-common
php81-pdo_sqlite
php81-pear
php81-ftp
php81-imap
php81-mysqli
php81-json
php81-mbstring
php81-soap
php81-litespeed
php81-sockets
php81-bcmath
php81-opcache
php81-dom
php81-zlib
php81-gettext
php81-fpm
php81-intl
php81-openssl
php81-session
php81-pdo_mysql
php81-embed
php81-xmlrpc
php81-wddx
php81-dba
php81-ldap
php81-xsl
php81-exif
php81-pdo_dblib
php81-bz2
php81-pdo
php81-pspell
php81-sysvmsg
php81-gmp
php81-apache2
php81-pdo_odbc
php81-shmop
php81-ctype
php81-phpdbg
php81-enchant
php81-sysvsem
php81-sqlite3
php81-odbc
php81-pcntl
php81-calendar
php81-xmlreader
php81-snmp
php81-zip
php81-posix
php81-iconv
php81-curl
php81-doc
php81-gd
php81-xml
php81-dev
php81-cgi
php81-sysvshm
php81-pgsql
php81-tidy
php81-pdo_pgsql
php81-phar
php81-mysqlnd
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

* [Bitbucket - yobasystems/alpine-php-wordpress](https://bitbucket.org/yobasystems/alpine-php-wordpress)


## 🐳 Container Registries

* [Dockerhub - yobasystems/alpine-php-wordpress](https://hub.docker.com/r/yobasystems/alpine-php-wordpress/)

* [Quay.io - yobasystems/alpine-php-wordpress](https://quay.io/repository/yobasystems/alpine-php-wordpress)


## 🔗 Links

* [Yoba Systems](https://www.yobasystems.co.uk/)

* [Github - Yoba Systems](https://github.com/yobasystems/)

* [Dockerhub - Yoba Systems](https://hub.docker.com/u/yobasystems/)

* [Quay.io - Yoba Systems](https://quay.io/organization/yobasystems)

* [Maintainer - Dominic Taylor](https://github.com/dominictayloruk)

## 💰 Donation

[![BMAC](https://img.shields.io/badge/BUY%20ME%20A%20COFFEE-£5-blue.svg?style=for-the-badge&logo=buy-me-a-coffee)](https://www.buymeacoffee.com/dominictayloruk?new=1)

[![BITCOIN](https://img.shields.io/badge/BTC-bc1q7hy8qmyvq7rw6slrna7yffcdnj9rcg4e9xjecc-blue.svg?style=for-the-badge&logo=bitcoin)](bitcoin:bc1q7hy8qmyvq7rw6slrna7yffcdnj9rcg4e9xjecc)

[![ETHEREUM](https://img.shields.io/badge/ETH-0xb6bE2e4da3d86b50Bdae1F9B6960c23dd87C532C-blue.svg?style=for-the-badge&logo=ethereum)](ethereum:0xb6bE2e4da3d86b50Bdae1F9B6960c23dd87C532C)
