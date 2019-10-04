#!/bin/sh -x

apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y php-pear php7.4-dev

pecl config-set php_ini $PHP_INI_DIR/php.ini
pear config-set php_ini $PHP_INI_DIR/php.ini

pecl install xdebug-beta

echo xdebug.remote_enable=1 >> $PHP_INI_DIR/conf.d/xdebug.ini; \
echo xdebug.remote_autostart=0 >> $PHP_INI_DIR/conf.d/xdebug.ini; \
echo xdebug.remote_port=9001 >> $PHP_INI_DIR/conf.d/xdebug.ini; \
echo xdebug.remote_connect_back=0 >> $PHP_INI_DIR/conf.d/xdebug.ini; \
echo xdebug.remote_host=host.docker.internal >> $PHP_INI_DIR/conf.d/xdebug.ini; \
echo xdebug.idekey=PHPSTORM >> $PHP_INI_DIR/conf.d/xdebug.ini; \
echo xdebug.remote_log=/var/log/xdebug.log >> $PHP_INI_DIR/conf.d/xdebug.ini;

apt-get purge php-pear php7.4-dev

/build/cleanup.sh
