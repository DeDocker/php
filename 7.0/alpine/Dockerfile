FROM alpine:edge

COPY container /

RUN install-pkg php7 git unzip make
RUN install-php-ext bz2 \
        curl \
        exif \
        iconv \
        mbstring \
        mcrypt \
        pdo \
        pdo_mysql \
        pdo_pgsql \
        openssl \
        json \
        phar \
        session \
        dom \
        gd \
        ctype \
        zlib

RUN set -x \
    && addgroup -g 82 -S www-data \
    && adduser -u 82 -D -S -G www-data www-data

RUN ln -s `which php7` /usr/bin/php

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

CMD ["php", "-a"]
