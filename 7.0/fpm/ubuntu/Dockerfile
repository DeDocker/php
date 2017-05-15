FROM ubuntu:16.04

COPY build /build

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common \
    && LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
    && apt-get remove --purge -y software-properties-common \
    && /build/cleanup.sh

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        php7.0 \
        php7.0-fpm \
        php7.0-bz2 \
        php7.0-curl \
        php7.0-exif \
        php7.0-iconv \
        php7.0-mbstring \
        php7.0-mcrypt \
        php7.0-pdo \
        php7.0-pdo-mysql \
        php7.0-pdo-pgsql \
        php7.0-json \
        php7.0-phar \
        php7.0-dom \
        php7.0-gd \
        php7.0-ctype \
        git \
        unzip \
        make \
    && /build/cleanup.sh

RUN mkdir -p /run/php && chown www-data:www-data /run/php

COPY container /

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

EXPOSE 9000
CMD ["php-fpm7.0"]
