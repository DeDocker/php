FROM alpine:3.5

RUN apk add --no-cache php7 \
        php7-fpm \
        php7-bz2 \
        php7-curl \
        php7-exif \
        php7-iconv \
        php7-mbstring \
        php7-mcrypt \
        php7-pdo \
        php7-pdo_mysql \
        php7-pdo_pgsql \
        php7-openssl \
        php7-json \
        php7-phar \
        php7-session \
        php7-dom \
        php7-gd \
        php7-ctype \
        php7-zlib \
        git \
        unzip \
        make

COPY container /

RUN set -x \
    && addgroup -g 82 -S www-data \
    && adduser -u 82 -D -S -G www-data www-data

RUN ln -s `which php7` /usr/bin/php

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

EXPOSE 9000
CMD ["php-fpm7"]
