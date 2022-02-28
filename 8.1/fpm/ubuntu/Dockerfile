FROM ubuntu:22.04

ONBUILD ARG XDEBUG_ENABLED="0"
ONBUILD RUN test "$XDEBUG_ENABLED" = "1" && /build/install_xdebug.sh || echo "Skipping Xdebug"

ENV PHP_INI_DIR /etc/php/8.1/fpm

COPY build /build

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        php8.1 \
        php8.1-fpm \
        php8.1-bcmath \
        php8.1-bz2 \
        php8.1-ctype \
        php8.1-curl \
        php8.1-dom \
        php8.1-exif \
        php8.1-gd \
        php8.1-iconv \
        php8.1-mbstring \
        php8.1-pdo \
        php8.1-pdo-mysql \
        php8.1-pdo-pgsql \
        php8.1-phar \
        php8.1-redis \
        php8.1-zip \
        git \
        curl \
        unzip \
        make \
        ca-certificates \
    && /build/cleanup.sh

RUN mkdir -p /run/php && chown www-data:www-data /run/php

COPY container /

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

EXPOSE 9000
CMD ["php-fpm8.1"]
