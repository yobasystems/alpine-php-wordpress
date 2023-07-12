FROM yobasystems/alpine:3.18.2-amd64

ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="Dominic Taylor <dominic@yoba.systems>" \
    architecture="amd64/x86_64" \
    alpine-version="3.18.2" \
    nginx-version="1.25.1" \
    php-version="8.1.21" \
    wordpress-version="latest" \
    build="12-Jul-2023" \
    org.opencontainers.image.title="alpine-php-wordpress" \
    org.opencontainers.image.description="Wordpress container image running on Alpine Linux" \
    org.opencontainers.image.authors="Dominic Taylor <dominic@yoba.systems>" \
    org.opencontainers.image.vendor="Yoba Systems" \
    org.opencontainers.image.version="v3.18.2-s" \
    org.opencontainers.image.url="https://hub.docker.com/r/yobasystems/alpine-php-wordpress/" \
    org.opencontainers.image.source="https://github.com/yobasystems/alpine-php-wordpress" \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.created=$BUILD_DATE

ENV TERM="xterm" \
    DB_HOST="172.17.0.1" \
    DB_NAME="" \
    DB_USER=""\
    DB_PASS=""

RUN \
    build_pkgs="build-base linux-headers openssl-dev pcre-dev wget zlib-dev" && \
    runtime_pkgs=" bash curl less vim ca-certificates git tzdata zip openssl pcre \
    libmcrypt-dev zlib-dev gmp-dev \
    freetype-dev libjpeg-turbo-dev libpng-dev \
    php81-fpm php81-json php81-zlib php81-xml php81-xmlwriter php81-simplexml php81-pdo php81-phar php81-openssl \
    php81-pdo_mysql php81-mysqli php81-session \
    php81-gd php81-iconv php81-gmp php81-zip \
    php81-curl php81-opcache php81-ctype php81-apcu \
    php81-intl php81-bcmath php81-dom php81-mbstring php81-xmlreader mysql-client curl" && \
    apk --update add ${build_pkgs} ${runtime_pkgs} && apk add -u musl && \
    cd /tmp && \
    wget http://nginx.org/download/nginx-1.25.1.tar.gz && \
    tar xzf nginx-1.25.1.tar.gz && \
    cd /tmp/nginx-1.25.1 && \
    ./configure \
      --prefix=/etc/nginx \
      --sbin-path=/usr/sbin/nginx \
      --conf-path=/etc/nginx/nginx.conf \
      --error-log-path=/var/log/nginx/error.log \
      --http-log-path=/var/log/nginx/access.log \
      --pid-path=/var/run/nginx.pid \
      --lock-path=/var/run/nginx.lock \
      --http-client-body-temp-path=/var/cache/nginx/client_temp \
      --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
      --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
      --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
      --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
      --user=nginx \
      --group=nginx \
      --with-http_ssl_module \
      --with-http_realip_module \
      --with-http_addition_module \
      --with-http_sub_module \
      --with-http_dav_module \
      --with-http_flv_module \
      --with-http_mp4_module \
      --with-http_gunzip_module \
      --with-http_gzip_static_module \
      --with-http_random_index_module \
      --with-http_secure_link_module \
      --with-http_stub_status_module \
      --with-http_auth_request_module \
      --with-mail \
      --with-mail_ssl_module \
      --with-file-aio \
      --with-ipv6 \
      --with-threads \
      --with-stream \
      --with-stream_ssl_module \
      --with-http_slice_module \
      --with-http_v2_module && \
    make && \
    make install && \
    sed -i -e 's/#access_log  logs\/access.log  main;/access_log \/dev\/stdout;/' -e 's/#error_log  logs\/error.log  notice;/error_log stderr notice;/' /etc/nginx/nginx.conf && \
    adduser -D nginx && \
    rm -rf /tmp/* && \
    apk del ${build_pkgs} && \
    rm -rf /var/cache/apk/*

RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php81/php.ini && \
    sed -i 's/expose_php = On/expose_php = Off/g' /etc/php81/php.ini && \
    sed -i "s/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/sbin\/nologin/nginx:x:100:101:nginx:\/usr:\/bin\/bash/g" /etc/passwd && \
    sed -i "s/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/sbin\/nologin/nginx:x:100:101:nginx:\/usr:\/bin\/bash/g" /etc/passwd- && \
    ln -s /sbin/php-fpm81 /sbin/php-fpm

ADD files/nginx.conf /etc/nginx/nginx.conf
ADD files/php-fpm.conf /etc/php81/
ADD files/run.sh /
RUN chmod +x /run.sh && \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/bin/wp-cli && chown nginx:nginx /usr/bin/wp-cli

EXPOSE 80
VOLUME ["/usr"]

CMD ["/run.sh"]
