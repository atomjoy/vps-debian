#!/bin/bash

echo "## NGINX Config"

sudo apt-get remove -y --purge nginx
sudo apt-get autoremove -y
sudo apt-get install -y nginx ssl-cert

echo "## NGINX Updated"