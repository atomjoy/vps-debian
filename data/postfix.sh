#!/bin/bash

echo "## POSTFIX Config"

apt-get -y --purge remove exim4-*
apt-get -y --purge remove postfix
apt-get autoremove -y
apt-get update -y
apt-get upgrade -y

echo "root: root" >> /etc/aliases
echo "postfix postfix/mailname string ${DOMAIN}" | debconf-set-selections
echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections

apt-get install -y postfix

sed -i '/inet_interfaces/d' /etc/postfix/main.cf
sed -i '/inet_protocols/d' /etc/postfix/main.cf

echo "inet_interfaces = loopback-only" >> /etc/postfix/main.cf
echo "inet_protocols = ipv4" >> /etc/postfix/main.cf

sudo systemctl restart postfix

# Send email
echo "Sample email `date`" | mail -s "Welcome, vps test `date`" $EMAIL
echo "Smtp test message `date`" | mailx -s "Welcome message `date`" -a "From: Admin Root <root@${DOMAIN}>" $EMAIL


echo "## POSTFIX Updated"