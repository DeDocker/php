#!/bin/sh

# Load all .env variables into environment variables (needed for PHP to read variables like OPCACHE_VALIDATE_TIMESTAMPS)
if [ "$CI_ENV" != "testing" ] && [ -f ".env" ]; then
    eval $(awk '{print "export " $0}' .env)
fi

CURRENT_UID=$(id -u)
if [ "$CURRENT_UID" = "33" ]; then

  if [ "$APP_ENV" != "local" ]
  then
    php artisan config:cache \
    && php artisan route:cache \
    && php artisan view:cache \
    && php artisan event:cache
  fi

  # Start nginx
  /usr/sbin/nginx
  # Start php-fpm
  /usr/sbin/php-fpm8.2
fi

exec "$@"
