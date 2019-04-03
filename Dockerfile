FROM php:7.2-fpm

MAINTAINER Minker

# Install VIM and GIT
RUN apt-get update && apt-get install -y \
    git \
    vim 

# Install PHP extensions
RUN apt-get update && apt-get install -y \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libicu-dev \
		libpng-dev

RUN docker-php-ext-configure intl \
&& docker-php-ext-install intl \
&& docker-php-ext-install mysqli pdo pdo_mysql

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

CMD ["php-fpm"]