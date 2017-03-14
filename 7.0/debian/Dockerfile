FROM debian:jessie-slim

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

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

CMD ["php", "-a"]
