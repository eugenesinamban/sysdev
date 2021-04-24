FROM sysdev_lcl:latest AS builder

COPY package.json package-lock.json webpack.mix.js ./
COPY resources/js resources/js
COPY resources/sass resources/sass

RUN npm install

RUN npm run production

FROM sysdev_php-fpm:latest

RUN  mkdir -p storage/app/public \
    && mkdir -p storage/framework/sessions \
    && mkdir -p storage/framework/views \
    && mkdir -p storage/framework/cache

COPY composer.json composer.lock phpunit.xml server.php artisan ./
RUN mkdir -p database/seeds database/factories
COPY resources/lang resources/lang
COPY resources/views resources/views

RUN /usr/bin/composer install --optimize-autoloader --no-dev

COPY docker/php-fpm/php-fpm.conf /usr/local/etc/php-fpm.d/zz-docker.conf
COPY docker/nginx/nginx.conf /etc/nginx/nginx.conf
COPY docker/nginx/prod.conf /etc/nginx/sites-available/default

COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules/vue ./node_modules/vue

ARG GIT_HASH
RUN echo "${GIT_HASH}" > REVISION

RUN chown www-data:www-data -R /app

COPY docker/production/webserver.sh /docker/production/webserver.sh
RUN chmod +x /docker/production/webserver.sh

ENTRYPOINT ["/docker/production/webserver.sh"]
