#!/bin/bash

echo "## REMOVE SUDO Config"

# Variables
USERNAME="debian"

# Debian default conf
FILE="90-user-$USERNAME"

# Remove user from sudo
sudo gpasswd -d $USERNAME sudo

# Remove sudo users
sudo rm /etc/sudoers.d/90-cloud-init-users
echo "# Enable sudo for ${USERNAME} without confirmation" > /etc/sudoers.d/$FILE
echo "# ${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$FILE

# Show
sudo cat /etc/sudoers.d/90-user-$USERNAME

# Show group users
sudo grep 'sudo' /etc/group

# Show sudo users
sudo members 'sudo'

echo "## REMOVE SUDO Updated"