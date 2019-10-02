#!/bin/sh -x

docker-php-source extract && \
docker-php-ext-get xdebug 2.8.0beta2 && \
docker-php-ext-install xdebug && \
docker-php-source delete

echo xdebug.remote_enable=1 >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini; \
echo xdebug.remote_autostart=0 >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini; \
echo xdebug.remote_port=9000 >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini; \
echo xdebug.remote_connect_back=0 >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini; \
echo xdebug.remote_host=host.docker.internal >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini; \
echo xdebug.idekey=PHPSTORM >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini; \
echo xdebug.remote_log=/var/log/xdebug.log >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini;