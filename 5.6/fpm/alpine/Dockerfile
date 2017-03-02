FROM alpine:3.5

RUN apk add --no-cache php5 \
        php5-fpm \
        php5-bz2 \
        php5-curl \
        php5-exif \
        php5-iconv \
        php5-mcrypt \
        php5-pdo \
        php5-pdo_mysql \
        php5-pdo_pgsql \
        php5-openssl \
        php5-json \
        php5-phar \
        php5-dom \
        php5-gd \
        php5-ctype \
        php5-zlib \
        git \
        unzip \
        make

COPY container /

RUN set -x \
    && addgroup -g 82 -S www-data \
    && adduser -u 82 -D -S -G www-data www-data

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

EXPOSE 9000
CMD ["php-fpm"]
