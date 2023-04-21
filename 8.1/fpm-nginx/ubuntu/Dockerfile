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
    cron \
    git \
    curl \
    libcap2-bin \
    openssh-client \
    make \
    nginx \
    sudo \
    supervisor \
    unzip \
    vim \
    ca-certificates \
    dnsutils \
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
