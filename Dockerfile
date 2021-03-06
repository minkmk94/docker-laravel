FROM php:7.2-fpm

LABEL maintainer="Minker <mink.k53.utc@gmail.com>"

# Install VIM and GIT
RUN apt-get update && apt-get install -y \
    git \
    vim \
	unzip

# Install PHP libraries
RUN apt-get update && apt-get install -y \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libicu-dev \
		libpng-dev

# Install PHP extensions
RUN docker-php-ext-configure intl \
	&& docker-php-ext-install intl \
	&& docker-php-ext-install mysqli pdo pdo_mysql \
	&& docker-php-ext-install bcmath \
	&& docker-php-ext-install zip \
	&& pecl install xdebug-2.6.0 \
	&& docker-php-ext-enable xdebug \
	&& echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/php.ini \
	&& echo "xdebug.remote_enable=1" >> /usr/local/etc/php/php.ini \
	&& echo "xdebug.remote_autostart=0" >> /usr/local/etc/php/php.ini

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN usermod -u 1000 www-data

USER www-data

CMD ["php-fpm"]
