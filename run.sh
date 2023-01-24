#!/bin/bash

### Variables

# new passwords
DEBIAN_PASS="SuperHasło123@@@"
ROOT_PASS="RootSuperHasło123@@@"

# vps hostname
HOST="hello"
DOMAIN="example.com"
EMAIL="email@example.com"

# default user
DEFAULT_USER="debian"

# add sftp upload user
USER_NAME="vpsmax"
USER_PASS="Vpsmax123@@@"
USER_SUDO=false

# ssh
SSH_PORT=22
SSH_DENY_USERS="root admin ssh sshd"
SSH_ALLOW_USERS="$USER_NAME $DEFAULT_USER"

# ssh mask, allow only from ip range (1.0.0.0/8, 1.2.0.0/16, 1.2.3.0/24)
SSH_MASK=false
SSH_MASK_IP="1.2.0.0/16"

# mariadb
MYSQL_PASS="toor"
MYSQL_PASS_LARAVEL="toor"
MYSQL_REMOVE_PASS=false
MYSQL_REMOVE_PASS_LARAVEL=false

# php versions 8.2, 8.1, 7.4
PHP_VER="8.2"

# snakeoil
SSL_CERT="/etc/ssl/certs/ssl-cert-snakeoil.pem"
SSL_KEY="/etc/ssl/private/ssl-cert-snakeoil.key"

### Scripts

# Don't change below
echo "## SCRIPTS Runing"

# change passwords
. data/pass.sh

# add sftp user
. data/adduser.sh

# run scripts
. data/ssh.sh
. data/host.sh
. data/sources.sh
. data/packages.sh
. data/snakeoil.sh
. data/firewall.sh
. data/postfix.sh
. data/php.sh
. data/mariadb.sh
. data/nginx.sh
. data/nginx-default.sh
. data/fail2ban.sh
. data/ssh-login-alert.sh