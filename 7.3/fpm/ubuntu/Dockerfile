FROM ubuntu:18.04

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
        php7.3 \
        php7.3-fpm \
        php7.3-bz2 \
        php7.3-curl \
        php7.3-exif \
        php7.3-iconv \
        php7.3-mbstring \
        php7.3-pdo \
        php7.3-pdo-mysql \
        php7.3-pdo-pgsql \
        php7.3-json \
        php7.3-phar \
        php7.3-dom \
        php7.3-gd \
        php7.3-ctype \
        php7.3-zip \
        php7.3-bcmath \
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
CMD ["php-fpm7.3"]
