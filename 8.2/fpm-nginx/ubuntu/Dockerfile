FROM ubuntu:22.04

ARG APP_ENV="test"

ONBUILD ARG XDEBUG_ENABLED="0"
ONBUILD RUN test "$XDEBUG_ENABLED" = "1" && /build/install_xdebug.sh || echo "Skipping Xdebug"

ENV PHP_INI_DIR /etc/php/8.2/fpm

COPY build /build

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common \
    && add-apt-repository ppa:ondrej/php \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    php8.2 \
    php8.2-fpm \
    php8.2-bcmath \
    php8.2-bz2 \
    php8.2-ctype \
    php8.2-curl \
    php8.2-dom \
    php8.2-exif \
    php8.2-gd \
    php8.2-iconv \
    php8.2-mbstring \
    php8.2-pdo \
    php8.2-pdo-mysql \
    php8.2-pdo-pgsql \
    php8.2-phar \
    php8.2-redis \
    php8.2-zip \
    php8.2-intl \
    php8.2-soap \
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

RUN phpenmod intl \
    && rm /etc/nginx/sites-enabled/default /etc/nginx/sites-available/default \
    && mkdir -p /run/php && chown www-data:www-data /run/php

# Configure nginx (make possible to run nginx on port 80 as user www-data)
RUN setcap 'cap_net_bind_service=+ep' /usr/sbin/nginx \
    && mkdir -p /run/nginx && chown www-data:www-data /run/nginx \
    && chown -R www-data:www-data /var/lib/nginx; chmod -R oug+rwX /var/lib/nginx

COPY container /

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

RUN mkdir -p /usr/src/app \
    && mkdir -p /var/www \
    && chown -R www-data /usr/src/app /var/www

WORKDIR /usr/src/app

COPY docker-entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/docker-entrypoint.sh

USER www-data

ENTRYPOINT ["docker-entrypoint.sh"]
CMD []
