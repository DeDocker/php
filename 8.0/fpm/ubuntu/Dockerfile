FROM ubuntu:20.04

ONBUILD ARG XDEBUG_ENABLED="0"
ONBUILD RUN test "$XDEBUG_ENABLED" = "1" && /build/install_xdebug.sh || echo "Skipping Xdebug"

ENV PHP_INI_DIR /etc/php/8.0/fpm

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
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        php8.0 \
        php8.0-fpm \
        php8.0-bcmath \
        php8.0-bz2 \
        php8.0-ctype \
        php8.0-curl \
        php8.0-dom \
        php8.0-exif \
        php8.0-gd \
        php8.0-iconv \
        php8.0-mbstring \
        php8.0-pdo \
        php8.0-pdo-mysql \
        php8.0-pdo-pgsql \
        php8.0-phar \
        php8.0-redis \
        php8.0-zip \
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
CMD ["php-fpm8.0"]
