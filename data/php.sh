#!/bin/bash

echo "## PHP $PHP_VER Config"

sudo apt install -y curl wget zip unzip gnupg2 ca-certificates lsb-release software-properties-common

sudo curl https://packages.sury.org/php/apt.gpg | gpg --dearmor > /usr/share/keyrings/sury-php.gpg
sudo echo "deb [signed-by=/usr/share/keyrings/sury-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list

sudo apt update -y

sudo apt install -y php$PHP_VER-{fpm,mysql,xml,curl,mbstring,opcache,gd,imagick,imap,bcmath,bz2,zip,intl,redis,memcache,memcached}

sudo update-alternatives --list php
sudo update-alternatives --set php /usr/bin/php$PHP_VER

php -v

echo "## PHP $PHP_VER Updated"