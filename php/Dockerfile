ARG PHP_VERSION=""
FROM php:${PHP_VERSION:+${PHP_VERSION}-}fpm-alpine

RUN apk update; \
    apk upgrade;

# Install the mysqli plugin
RUN docker-php-ext-install mysqli
RUN chown -Rv www-data:www-data /var/www/html/
