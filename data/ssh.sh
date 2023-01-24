#!/bin/bash

echo "## SSH Config"

if ! [ -d /etc/backup/ssh ]; then
  sudo mkdir -p /etc/backup/ssh
fi

# Deny users
if [ -z "${SSH_DENY_USERS}" ]; then
SSH_DENY_USERS="root admin ssh sshd"
fi

# Allow users
if [ -z "${SSH_ALLOW_USERS}" ]; then
SSH_ALLOW_USERS="${USER_NAME} ${DEFAULT_USER}"
fi

# Backup
sudo cp /etc/ssh/sshd_config "/etc/backup/ssh/sshd_config_$(date +%Y-%m-%d-%s)"

# Clear all
echo "Include /etc/ssh/sshd_config.d/*.conf" > /etc/ssh/sshd_config

# Create
echo "
# Deny users
DenyUsers ${SSH_DENY_USERS}
# Allow users
AllowUsers ${SSH_ALLOW_USERS}
# Port
Port 22
# Only ipv4
ListenAddress 0.0.0.0
# Ssh keys
PubkeyAuthentication yes
# Disable root login
PermitRootLogin no
# Allow user check
UsePAM yes
# Disable password login
PasswordAuthentication no
ChallengeResponseAuthentication no
ChallengeResponseAuthentication no
KerberosAuthentication no
GSSAPIAuthentication no
# Disable rest
AllowAgentForwarding no
AllowTcpForwarding no
X11Forwarding no
GatewayPorts no
PermitTunnel no
PrintMotd no
UseDNS no
# Allow sftp client
Subsystem sftp  /usr/lib/openssh/sftp-server
" > /etc/ssh/sshd_config.d/debian.conf

# Restart
sudo service sshd restart
sudo service ssh restart

echo "## SSH Updated"