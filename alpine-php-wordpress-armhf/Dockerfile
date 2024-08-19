FROM yobasystems/alpine:3.20.2-armhf

ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="Dominic Taylor <dominic@yoba.systems>" \
    architecture="arm32v7/armhf" \
    alpine-version="3.20.2" \
    nginx-version="1.26.2" \
    php-version="8.3.10" \
    wordpress-version="latest" \
    build="19-Aug-2024" \
    org.opencontainers.image.title="alpine-php-wordpress" \
    org.opencontainers.image.description="Wordpress container image running on Alpine Linux" \
    org.opencontainers.image.authors="Dominic Taylor <dominic@yoba.systems>" \
    org.opencontainers.image.vendor="Yoba Systems" \
    org.opencontainers.image.version="3.20.2" \
    org.opencontainers.image.url="https://hub.docker.com/r/yobasystems/alpine-php-wordpress/" \
    org.opencontainers.image.source="https://github.com/yobasystems/alpine-php-wordpress" \
    org.opencontainers.image.base.name="docker.io/yobasystems/alpine:3.20.2" \
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
    php83-fpm php83-json php83-zlib php83-xml php83-xmlwriter php83-simplexml php83-pdo php83-phar php83-openssl \
    php83-pdo_mysql php83-mysqli php83-session \
    php83-gd php83-iconv php83-gmp php83-zip \
    php83-curl php83-opcache php83-ctype php83-apcu \
    php83-intl php83-bcmath php83-dom php83-mbstring php83-xmlreader mysql-client && apk add -u musl && \
    rm -rf /var/cache/apk/*

RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php83/php.ini && \
    sed -i 's/expose_php = On/expose_php = Off/g' /etc/php83/php.ini && \
    sed -i "s/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/sbin\/nologin/nginx:x:100:101:nginx:\/usr:\/bin\/bash/g" /etc/passwd && \
    sed -i "s/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/sbin\/nologin/nginx:x:100:101:nginx:\/usr:\/bin\/bash/g" /etc/passwd- && \
    ln -s /sbin/php-fpm83 /sbin/php-fpm

ADD files/nginx.conf /etc/nginx/
ADD files/php-fpm.conf /etc/php83/
ADD files/run.sh /
RUN chmod +x /run.sh && \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/bin/wp-cli && chown nginx:nginx /usr/bin/wp-cli

EXPOSE 80
VOLUME ["/usr/html"]

CMD ["/run.sh"]
