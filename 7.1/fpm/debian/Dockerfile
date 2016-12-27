FROM debian:jessie-slim

COPY container /

RUN install-pkg apt-transport-https ca-certificates curl

RUN curl -o /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ jessie main" > /etc/apt/sources.list.d/php.list

RUN install-pkg php7.1 git unzip make

RUN install-php-ext fpm \
        bz2 \
        curl \
        exif \
        iconv \
        mbstring \
        mcrypt \
        pdo \
        pdo-mysql \
        pdo-pgsql \
        json \
        phar \
        dom \
        gd \
        ctype

RUN mkdir -p /run/php && chown www-data:www-data /run/php

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

EXPOSE 9000
CMD ["php-fpm7.1"]
