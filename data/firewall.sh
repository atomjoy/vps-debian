#!/bin/bash

echo "## UFW Config"

sudo ufw --force disable
sudo ufw --force reset
# Rules
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
# Allow all ip's
if [ "$SSH_MASK" = false ]; then
  sudo ufw allow proto tcp to 0.0.0.0/0 port $SSH_PORT
fi
# Allow masked ip's
if [ "$SSH_MASK" = true ]; then
  sudo ufw allow proto tcp from $SSH_MASK_IP to 0.0.0.0/0 port $SSH_PORT
fi
# Policy
sudo ufw default allow outgoing
sudo ufw default deny incoming
# Enable
sudo ufw logging on
sudo ufw --force enable
# Show
sudo ufw status numbered

echo "## UFW Updated"