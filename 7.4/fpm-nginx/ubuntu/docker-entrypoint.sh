#!/bin/sh

# Load all .env variables into environment variables (needed for PHP to read variables like OPCACHE_VALIDATE_TIMESTAMPS)
if [ "$CI_ENV" != "testing" ]; then
    eval $(awk '{print "export " $0}' .env)
fi

# Start nginx (only if running user is the same as in docker/Dockerfile)
if [ "$(id -u)" = 33 ]; then
    /usr/sbin/nginx
fi

if [ "$APP_ENV" != "local" ]; then
    php artisan config:cache
    php artisan route:cache
    php artisan view:cache
    php artisan event:cache
fi
exec "$@"
