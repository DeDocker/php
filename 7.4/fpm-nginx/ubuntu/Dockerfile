FROM ubuntu:18.04

ONBUILD ARG XDEBUG_ENABLED="0"
ONBUILD RUN test "$XDEBUG_ENABLED" = "1" && /build/install_xdebug.sh || echo "Skipping Xdebug"

ENV PHP_INI_DIR /etc/php/7.4/fpm

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
  php7.4 \
  php7.4-fpm \
  php7.4-bz2 \
  php7.4-curl \
  php7.4-exif \
  php7.4-iconv \
  php7.4-mbstring \
  php7.4-pdo \
  php7.4-pdo-mysql \
  php7.4-pdo-pgsql \
  php7.4-json \
  php7.4-phar \
  php7.4-dom \
  php7.4-gd \
  php7.4-ctype \
  php7.4-zip \
  php7.4-bcmath \
  php7.4-intl \
  cron \
  sudo \
  vim \
  supervisor \
  openssh-client \
  libpcre2-dev \
  git \
  unzip \
  make \
  nginx \
  libcap2-bin \
  && /build/cleanup.sh

## System part
RUN usermod -u 33 www-data \
  && groupmod -g 33 www-data \
  && chown -R www-data:www-data /run/php

RUN phpenmod intl
RUN rm /etc/nginx/sites-enabled/default /etc/nginx/sites-available/default
RUN mkdir -p /run/php && chown www-data:www-data /run/php
RUN ln -s /usr/src/app/artisan /usr/bin

# Make possible to run nginx on port 80 as user www-data
RUN setcap 'cap_net_bind_service=+ep' /usr/sbin/nginx
RUN mkdir -p /run/nginx && chown www-data:www-data /run/nginx
RUN chown -R www-data:www-data /var/lib/nginx; chmod -R oug+rwX /var/lib/nginx /var/log/nginx /run/nginx

COPY container /

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php composer-setup.php --install-dir=/usr/local/bin --version=1.10.16 --filename=composer \
  && php -r "unlink('composer-setup.php');"

RUN composer self-update --2

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

EXPOSE 80

COPY docker-entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD []