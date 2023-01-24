#!/bin/bash

echo "## ADDUSER Config"

sudo killall -u $USER_NAME
sudo userdel -r -f $USER_NAME
sudo useradd -m -G sudo -s /bin/bash -p $(openssl passwd -1 "$USER_PASS") $USER_NAME
if [ "$USER_SUDO" = false ]; then
        sudo gpasswd -d $USER_NAME sudo
fi

# copy ssh keys
sudo cp -r /home/debian/.ssh /home/$USER_NAME/.ssh
sudo chown -R $USER_NAME:$USER_NAME /home/$USER_NAME/.ssh

# details
sudo id $USER_NAME
sudo cat /etc/passwd | grep "$USER_NAME"

echo "## ADDUSER Updated"