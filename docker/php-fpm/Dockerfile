FROM php:7.3-fpm

RUN apt-get update && apt-get install -y git nginx libxml2-dev libpng-dev

# opcache is already installed in php-fpm, just need to enable it
RUN docker-php-ext-enable opcache

RUN apt-get install -y zlib1g-dev libzip-dev \
    && pecl install zip \
    && docker-php-ext-enable zip

RUN pecl install redis \
    && docker-php-ext-enable redis

RUN docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mysqli

RUN docker-php-ext-install gd

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ \
    && mv /usr/bin/composer.phar /usr/bin/composer

# Cleanup dev packages
RUN apt-get autoremove -y \
    && rm -rf /var/cache/apt/*

RUN mkdir -p /app/
WORKDIR /app/
