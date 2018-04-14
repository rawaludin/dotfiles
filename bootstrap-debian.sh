#!/bin/sh

COMPOSER_ALLOW_SUPERUSER=1
DEBIAN_FRONTEND=noninteractive
TERM=xterm-256color

sudo apt-get update -q && \
    sudo apt-get install --no-install-recommends -qy \
        apt-transport-https \
        ca-certificates \
        gnupg2 \
        wget && \

    # PHP7.1 Sury repository
    sudo sh -c 'echo deb https://packages.sury.org/php/ stretch main | tee /etc/apt/sources.list.d/sury.list' && \
    sudo wget -q -O- https://packages.sury.org/php/apt.gpg | apt-key add - && \

    sudo apt-get update -q && \
    sudo apt-get install --no-install-recommends -qy \
        cron \
        curl \
        git \
        htop \
        mysql-client \
        netcat \
        php7.1-apcu \
        php7.1-apcu-bc \
        php7.1-cli \
        php7.1-curl \
        php7.1-fpm \
        php7.1-gd \
        php7.1-gmp \
        php7.1-intl \
        php7.1-json \
        php7.1-ldap \
        php7.1-mcrypt \
        php7.1-mbstring \
        php7.1-memcache \
        php7.1-memcached \
        php7.1-mongo \
        php7.1-mysql \
        php7.1-odbc \
        php7.1-pgsql \
        php7.1-pspell \
        php7.1-readline \
        php7.1-redis \
        php7.1-sqlite \
        php7.1-sybase \
        php7.1-tidy \
        php7.1-soap \
        php7.1-xdebug \
        php7.1-xmlrpc \
        php7.1-xsl \
        php7.1-zip \
        phpunit \
        python-setuptools \
        redis-tools \
        sendmail-bin \
        supervisor \
        vim-nox \
        unzip \
        zip
