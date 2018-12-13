FROM debian:stretch-slim

COPY build /build

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        apt-transport-https \
        lsb-release \
        ca-certificates \
        curl \
    && curl -o /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list \
    && apt-get remove --purge -y lsb-release \
    && /build/cleanup.sh

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        php7.2 \
        php7.2-fpm \
        php7.2-bz2 \
        php7.2-curl \
        php7.2-exif \
        php7.2-iconv \
        php7.2-mbstring \
        php7.2-pdo \
        php7.2-pdo-mysql \
        php7.2-pdo-pgsql \
        php7.2-json \
        php7.2-phar \
        php7.2-dom \
        php7.2-gd \
        php7.2-ctype \
        git \
        unzip \
        make \
    && /build/cleanup.sh

RUN mkdir -p /run/php && chown www-data:www-data /run/php
RUN mkdir -p /var/www && chown www-data:www-data /var/www

COPY container /

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

EXPOSE 9000
CMD ["php-fpm7.2"]
