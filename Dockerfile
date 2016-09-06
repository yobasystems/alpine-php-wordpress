FROM alpine:latest
MAINTAINER Dominic Taylor <dominic@yobasystems.co.uk>

ENV TERM="xterm" \
    MYSQL_HOST="" \
    MYSQL_USER="" \
    MYSQL_PASSWORD="" \
    MYSQL_DATABASE=""

RUN apk update \
    && apk add bash less vim nginx ca-certificates curl \
    php5-fpm php5-json php5-zlib php5-xml php5-pdo php5-phar php5-openssl \
    php5-pdo_mysql php5-mysqli \
    php5-gd php5-iconv php5-mcrypt \
    php5-mysql php5-curl php5-opcache php5-ctype php5-apcu \
    php5-intl php5-bcmath php5-dom php5-xmlreader mysql-client && apk add -u musl

RUN rm -rf /var/cache/apk/*

RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php5/php.ini && \
    sed -i 's/nginx:x:100:101:Linux User,,,:\/var\/www\/localhost\/htdocs:\/sbin\/nologin/nginx:x:100:101:Linux User,,,:\/var\/www\/localhost\/htdocs:\/bin\/bash/g' /etc/passwd && \
    sed -i 's/nginx:x:100:101:Linux User,,,:\/var\/www\/localhost\/htdocs:\/sbin\/nologin/nginx:x:100:101:Linux User,,,:\/var\/www\/localhost\/htdocs:\/bin\/bash/g' /etc/passwd- && \


ADD files/nginx.conf /etc/nginx/
ADD files/php-fpm.conf /etc/php5/
ADD files/run.sh /
RUN chmod +x /run.sh

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/bin/wp-cli

EXPOSE 80
VOLUME ["/usr"]

CMD ["/run.sh"]
