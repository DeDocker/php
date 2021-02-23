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
    && apt-get remove --purge -y software-properties-common

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
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
        cron \
        git \
        libcap2-bin \
        openssh-client \
        make \
        nginx \
        sudo \
        supervisor \
        unzip \
        vim \
    && /build/cleanup.sh

RUN rm /etc/nginx/sites-enabled/default /etc/nginx/sites-available/default
RUN mkdir -p /run/php && chown www-data:www-data /run/php

# Make possible to run nginx on port 80 as user www-data
RUN setcap 'cap_net_bind_service=+ep' /usr/sbin/nginx
RUN mkdir -p /run/nginx && chown www-data:www-data /run/nginx
RUN chown -R www-data:www-data /var/lib/nginx; chmod -R oug+rwX /var/lib/nginx

COPY container /

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

EXPOSE 80

COPY docker-entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD []