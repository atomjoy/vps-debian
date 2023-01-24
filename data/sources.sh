#!/bin/bash

echo "## APT Config"

if ! [ -d /etc/backup/apt ]; then
  sudo mkdir -p /etc/backup/apt
fi

# Backup
sudo cp /etc/apt/sources.list "/etc/backup/apt/sources.list_$(date +%Y-%m-%d-%s)"
# Install
apt-get install -y apt-transport-https
sed -i 's/http\:/https\:/g' /etc/apt/sources.list
apt-get update -y
apt-get -y upgrade

echo "## APT Updated"