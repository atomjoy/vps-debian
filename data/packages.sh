#!/bin/bash

echo "## PACKAGES Config"

sudo apt-get install -y openssl ca-certificates ssl-cert net-tools dnsutils mailutils
sudo apt-get install -y tar zip unzip certbot members ufw

echo "## PACKAGES Updated"