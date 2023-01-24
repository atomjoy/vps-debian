#!/bin/bash

echo "## MARIADB Config"

if ! [ -d /etc/backup/mysql ]; then
  sudo mkdir -p /etc/backup/mysql
fi

# Backup
if [ -d /var/lib/mysql ]; then
  sudo tar -czf "/etc/backup/mysql/var_lib_mysql-$(date +%Y-%m-%d-%s).tar.gz" /var/lib/mysql
fi

# Remove server
sudo apt-get remove -y --purge mariadb-server
sudo apt-get autoremove -y

# Remove databases
sudo rm -rf /var/lib/mysql

# Install
sudo apt-get install -y mariadb-server

# Secure
mysql -u root -e "
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
"

# Laravel user pass
if [ "$MYSQL_PASS_LARAVEL" ]; then
mysql -u root -e "
CREATE DATABASE laravel CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE laravel_testing CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL ON laravel.* TO 'laravel'@'localhost' IDENTIFIED BY '${MYSQL_PASS_LARAVEL}' WITH GRANT OPTION;
GRANT ALL ON laravel.* TO 'laravel'@'127.0.0.1' IDENTIFIED BY '${MYSQL_PASS_LARAVEL}' WITH GRANT OPTION;
GRANT ALL ON laravel_testing.* TO 'laravel'@'localhost' IDENTIFIED BY '${MYSQL_PASS_LARAVEL}' WITH GRANT OPTION;
GRANT ALL ON laravel_testing.* TO 'laravel'@'127.0.0.1' IDENTIFIED BY '${MYSQL_PASS_LARAVEL}' WITH GRANT OPTION;
FLUSH PRIVILEGES;
"
fi

# Remove laravel user pass
if [ "${MYSQL_REMOVE_PASS_LARAVEL}" = "true" ]; then
mysql -u root -e "
SET PASSWORD FOR 'laravel'@'localhost' = '';
SET PASSWORD FOR 'laravel'@'127.0.0.1' = '';
FLUSH PRIVILEGES;
"
fi

# Root user pass
if [ "$MYSQL_PASS" ]; then
mysql -u root -e "
GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY '${MYSQL_PASS}' WITH GRANT OPTION;
GRANT ALL ON *.* TO 'root'@'127.0.0.1' IDENTIFIED BY '${MYSQL_PASS}' WITH GRANT OPTION;
FLUSH PRIVILEGES;
"
fi

# Remove root user pass
if [ "${MYSQL_REMOVE_PASS}" = "true" ]; then
mysql -u root -p$MYSQL_PASS -e "
SET PASSWORD FOR 'root'@'localhost' = '';
SET PASSWORD FOR 'root'@'127.0.0.1' = '';
FLUSH PRIVILEGES;
"
fi

echo "## MARIADB Updated"