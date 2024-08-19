FROM yobasystems/alpine:3.20.2-amd64

ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="Dominic Taylor <dominic@yoba.systems>" \
    architecture="amd64/x86_64" \
    alpine-version="3.20.2" \
    nginx-version="1.26.2" \
    php-version="8.3.10" \
    wordpress-version="latest" \
    build="19-Aug-2024" \
    org.opencontainers.image.title="alpine-php-wordpress" \
    org.opencontainers.image.description="Wordpress container image running on Alpine Linux" \
    org.opencontainers.image.authors="Dominic Taylor <dominic@yoba.systems>" \
    org.opencontainers.image.vendor="Yoba Systems" \
    org.opencontainers.image.version="3.20.2-s" \
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

RUN \
    build_pkgs="build-base linux-headers openssl-dev pcre-dev wget zlib-dev" && \
    runtime_pkgs=" bash curl less vim ca-certificates git tzdata zip openssl pcre \
    libmcrypt-dev zlib-dev gmp-dev \
    freetype-dev libjpeg-turbo-dev libpng-dev \
    php83-fpm php83-json php83-zlib php83-xml php83-xmlwriter php83-simplexml php83-pdo php83-phar php83-openssl \
    php83-pdo_mysql php83-mysqli php83-session \
    php83-gd php83-iconv php83-gmp php83-zip \
    php83-curl php83-opcache php83-ctype php83-apcu \
    php83-intl php83-bcmath php83-dom php83-mbstring php83-xmlreader mysql-client" && \
    apk --update add ${build_pkgs} ${runtime_pkgs} && apk add -u musl && \
    cd /tmp && \
    wget http://nginx.org/download/nginx-1.26.2.tar.gz && \
    tar xzf nginx-1.26.2.tar.gz && \
    cd /tmp/nginx-1.26.2 && \
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

RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php83/php.ini && \
    sed -i 's/expose_php = On/expose_php = Off/g' /etc/php83/php.ini && \
    sed -i "s/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/sbin\/nologin/nginx:x:100:101:nginx:\/usr:\/bin\/bash/g" /etc/passwd && \
    sed -i "s/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/sbin\/nologin/nginx:x:100:101:nginx:\/usr:\/bin\/bash/g" /etc/passwd- && \
    ln -s /sbin/php-fpm83 /sbin/php-fpm

ADD files/nginx.conf /etc/nginx/nginx.conf
ADD files/php-fpm.conf /etc/php83/
ADD files/run.sh /
RUN chmod +x /run.sh && \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/bin/wp-cli && chown nginx:nginx /usr/bin/wp-cli

EXPOSE 80
VOLUME ["/usr"]

CMD ["/run.sh"]
