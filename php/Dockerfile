FROM php:8.1-fpm-alpine as minimum

# necessary if pecl has to be used later
ENV LIBRARY_PATH=/lib:/usr/lib
RUN apk add zlib-dev libpng-dev libjpeg-turbo-dev freetype-dev libzip-dev oniguruma-dev imagemagick imagemagick-dev gettext gettext-dev $PHPIZE_DEPS \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo_mysql gd opcache zip gettext \
#    && docker-php-ext-enable apcu \
    && cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

## add gibbon specific settings to php.ini
COPY ./gibbon-php-settings.ini "$PHP_INI_DIR/conf.d/gibbon-php-settings.ini"
COPY ./docker-php-mailrelay.ini "$PHP_INI_DIR/conf.d/docker-php-mailrelay.ini"

RUN cp "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
RUN mkdir /sessions && chown -R www-data:www-data /sessions

FROM minimum as dev

RUN apk add git openssh-client patch rsync \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && su -s /bin/sh -c "mkdir ~/.ssh && chmod 0700 ~/.ssh && mkdir ~/salt && mkdir ~/templates && mkdir -p /var/www/html/web/sites" www-data

COPY ./docker-php-gibbonsetup /usr/local/bin/

RUN apk add rsync \
    && cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini" \
    && chmod 0755 /usr/local/bin/docker-php-gibbonsetup \
    && sed -i "`wc -l < /usr/local/bin/docker-php-entrypoint`i\\/usr/local/bin/docker-php-gibbonsetup\\" /usr/local/bin/docker-php-entrypoint
