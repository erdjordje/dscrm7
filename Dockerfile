FROM php:5.5-apache
ENV http_proxy http://rsbeproxy01.endava.net:8080
MAINTAINER djordje.erakovic@endava.com
COPY config/apache2.conf /etc/apache2/apache2.conf
RUN apt-get -y update && apt-get install -y  apt-utils && a2enmod rewrite
RUN apt-get -y upgrade && apt-get -y install libpng12-dev libjpeg-dev libfreetype6-dev libgd2-xpm-dev libvpx-dev libc-client2007e-dev libkrb5-dev libmcrypt-dev \
	&& docker-php-ext-configure gd --with-jpeg-dir=/usr/lib/x86_64-linux-gnu/ --with-freetype-dir=/usr/lib/x86_64-linux-gnu/ --with-xpm-dir=/usr/lib/x86_64-linux-gnu/ --with-vpx-dir=/usr/lib/x86_64-linux-gnu/ \
	&& docker-php-ext-configure imap --with-imap=/usr/lib/x86_64-linux-gnu/ --with-kerberos --with-imap-ssl \
	&& docker-php-ext-install bcmath gd imap opcache mcrypt mysqli \
	&& pear config-set http_proxy rsbeproxy01.endava.net:8080 \
	&& pecl install zip jsmin-1.1.0 xdebug \
	&& docker-php-ext-enable zip jsmin
