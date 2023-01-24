#!/bin/bash

echo "## HOSTNAME Config"

if ! [ -d /etc/backup ]; then
  sudo mkdir -p /etc/backup
fi

sudo cp /etc/hosts "/etc/backup/hosts_$(date +%Y-%m-%d-%s)"
sudo sed -i "/127.0.0.1 ${HOST}.${DOMAIN} ${HOST}/d" /etc/hosts
echo "127.0.0.1 ${HOST}.${DOMAIN} ${HOST}" >> /etc/hosts
echo "${DOMAIN}" > /etc/mailname
sudo hostnamectl set-hostname $HOST

echo "Hostname: `hostname`"
echo "Fqdn host: `hostname -f`"
echo "Mailname: `cat /etc/mailname`"

echo "## HOSTNAME Updated"