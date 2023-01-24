#!/bin/bash

# Utwórz recordy A w strefie DNS dla hostów swojej domeny/subdomeny:
# hello.example.com
# www.hello.example.com

DOMAIN="example.com"

# Letsencrypt notifications email
ALERT_EMAIL="email@example.com"

# Don't delete below
echo "## CERTBOT Config"

# Certbot mode --standalone or --webroot
STANDALONE=true

# Install
apt-get install certbot

# Revoke
if [ -f "/etc/letsencrypt/live/${DOMAIN}/fullchain.pem" ]; then
  sudo certbot revoke --noninteractive --cert-path /etc/letsencrypt/live/$DOMAIN/fullchain.pem
fi

# Delete old
if [ "$DOMAIN" ]; then
  sudo certbot delete --noninteractive --cert-name $DOMAIN
fi

# Create new tls cert www and non-www with webroot plugin
if [ "${STANDALONE}" = "true" ]; then
  # Stop server
  sudo service nginx stop

  # Standalone
  sudo certbot certonly --standalone --noninteractive --agree-tos --preferred-challenges=http --email $ALERT_EMAIL --expand -d $DOMAIN -d www.$DOMAIN

  # Start server
  sudo service nginx start
else
  # Start server
  sudo service nginx start

  # Webroot
  sudo certbot certonly --noninteractive --agree-tos --preferred-challenges=http --email $ALERT_EMAIL --expand --webroot --webroot-path /var/www/$DOMAIN -d $DOMAIN -d www.$DOMAIN

  # Restart nginx server
  sudo service nginx restart
fi

# After hook
if [ -d "/etc/letsencrypt/renewal" ]; then
  echo "renew_hook = sudo systemctl restart nginx" > /etc/letsencrypt/renewal/$DOMAIN.conf
fi

echo "## CERTBOT Updated"