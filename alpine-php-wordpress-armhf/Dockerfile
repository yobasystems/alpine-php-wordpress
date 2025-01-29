FROM yobasystems/alpine:3.21.1-armhf

ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="Dominic Taylor <dominic@yoba.systems>" \
    architecture="arm32v7/armhf" \
    alpine-version="3.21.1" \
    nginx-version="1.26.2" \
    php-version="8.4.3" \
    wordpress-version="latest" \
    build="29-Jan-2025" \
    org.opencontainers.image.title="alpine-php-wordpress" \
    org.opencontainers.image.description="Wordpress container image running on Alpine Linux" \
    org.opencontainers.image.authors="Dominic Taylor <dominic@yoba.systems>" \
    org.opencontainers.image.vendor="Yoba Systems" \
    org.opencontainers.image.version="3.21.1" \
    org.opencontainers.image.url="https://hub.docker.com/r/yobasystems/alpine-php-wordpress/" \
    org.opencontainers.image.source="https://github.com/yobasystems/alpine-php-wordpress" \
    org.opencontainers.image.base.name="docker.io/yobasystems/alpine:3.21.1" \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.created=$BUILD_DATE

ENV TERM="xterm" \
    DB_HOST="172.17.0.1" \
    DB_NAME="" \
    DB_USER=""\
    DB_PASS=""

RUN apk add --no-cache bash curl less vim nginx ca-certificates git tzdata zip \
    libmcrypt-dev zlib-dev gmp-dev \
    freetype-dev libjpeg-turbo-dev libpng-dev \
    php84-fpm php84-json php84-zlib php84-xml php84-xmlwriter php84-simplexml php84-pdo php84-phar php84-openssl \
    php84-pdo_mysql php84-mysqli php84-session \
    php84-gd php84-iconv php84-gmp php84-zip \
    php84-curl php84-opcache php84-ctype php84-apcu \
    php84-intl php84-bcmath php84-dom php84-mbstring php84-xmlreader mysql-client && apk add -u musl && \
    rm -rf /var/cache/apk/*

RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php84/php.ini && \
    sed -i 's/expose_php = On/expose_php = Off/g' /etc/php84/php.ini && \
    sed -i "s/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/sbin\/nologin/nginx:x:100:101:nginx:\/usr:\/bin\/bash/g" /etc/passwd && \
    sed -i "s/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/sbin\/nologin/nginx:x:100:101:nginx:\/usr:\/bin\/bash/g" /etc/passwd- && \
    ln -s /sbin/php-fpm84 /sbin/php-fpm

ADD files/nginx.conf /etc/nginx/
ADD files/php-fpm.conf /etc/php84/
ADD files/run.sh /
RUN chmod +x /run.sh && \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/bin/wp-cli && chown nginx:nginx /usr/bin/wp-cli

EXPOSE 80
VOLUME ["/usr/html"]

CMD ["/run.sh"]
