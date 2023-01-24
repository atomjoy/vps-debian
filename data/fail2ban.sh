#!/bin/bash

echo "## FAIL2BAN Config"

sudo apt-get install fail2ban -y
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
echo "
[sshd]
enabled = true
port = ssh
logpath = /var/log/auth.log
maxretry = 3
bantime = 1200
action = iptables-multiport
" > /etc/fail2ban/jail.d/defaults-debian.conf
sudo service fail2ban restart

echo "## FAIL2BAN Updated"