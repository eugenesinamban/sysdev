#!/bin/bash

if [ "$APP_ENV" = "development" ]; then
cp -f .env.development .env
elif [ "$APP_ENV" = "staging" ]; then
cp -f .env.staging .env
elif [ "$APP_ENV" = "production" ]; then
cp -f .env.production .env
fi

echo "APP_DEBUG=$APP_DEBUG" >> .env

php artisan migrate --force

service nginx start
docker-php-entrypoint -F