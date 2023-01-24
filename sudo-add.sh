#!/bin/bash

echo "## ADD SUDO Config"

# Variables
USERNAME="debian"

# Debian default conf
FILE="90-user-$USERNAME"

# Add user to sudo group
sudo usermod -a -G sudo $USERNAME

# Add sudo users
sudo rm /etc/sudoers.d/90-cloud-init-users
echo "# Enable sudo for ${USERNAME} without confirmation" > /etc/sudoers.d/$FILE
echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$FILE

# Show
sudo cat /etc/sudoers.d/90-user-$USERNAME

# Show group users
sudo grep 'sudo' /etc/group

# Show sudo users
sudo members 'sudo'

echo "## ADD SUDO Updated"