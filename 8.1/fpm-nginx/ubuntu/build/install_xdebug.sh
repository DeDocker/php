#!/bin/sh -x

apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y php-pear php8.1-dev

pecl config-set php_ini $PHP_INI_DIR/php.ini
pear config-set php_ini $PHP_INI_DIR/php.ini

pecl install xdebug

echo zend_extension=xdebug.so >> $PHP_INI_DIR/conf.d/50_xdebug.ini; \
echo xdebug.mode = debug >> $PHP_INI_DIR/conf.d/50_xdebug.ini; \
echo xdebug.client_port=9001 >> $PHP_INI_DIR/conf.d/50_xdebug.ini; \
echo xdebug.client_host=host.docker.internal >> $PHP_INI_DIR/conf.d/50_xdebug.ini; \
echo xdebug.idekey=PHPSTORM >> $PHP_INI_DIR/conf.d/50_xdebug.ini; \
echo xdebug.log=/var/log/xdebug.log >> $PHP_INI_DIR/conf.d/50_xdebug.ini;

apt-get purge php-pear php8.1-dev

/build/cleanup.sh
