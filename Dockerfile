FROM php:7.2-fpm

WORKDIR /app

COPY . /app

RUN rm -rf /var/www/html && ln -s /app /var/www/html

RUN apt-get update && apt-get install -y \
        libpq-dev \
        libxml2-dev \
        git \
        zip \
    && docker-php-ext-install -j$(nproc) pgsql \
    && docker-php-ext-install -j$(nproc) soap \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer install --no-dev --no-interaction
