#!/bin/bash

echo "## VHOST DEFAULT Config"

# Default vhosts catch-all
echo "
# Http close connection
server {
  listen 80 default_server;
  listen [::]:80 default_server;
  server_name _;
  return 444;
}

# Https close connection
server {
  listen 443 default_server ssl;
  listen [::]:443 default_server ssl;
  server_name _;
  ssl_certificate ${SSL_CERT};
  ssl_certificate_key ${SSL_KEY};
  ssl_protocols TLSv1.2 TLSv1.3;
  ssl_ciphers HIGH:!aNULL:!MD5;
  return 444;
}
" > "/etc/nginx/sites-available/default"

sudo chown -R www-data:www-data /etc/nginx/sites-available
sudo chmod -R 2775 /etc/nginx/sites-available

# Restart
sudo service nginx restart

echo "## VHOST DEFAULT Updated"