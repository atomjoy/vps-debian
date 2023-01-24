#!/bin/bash

sudo echo '#!/bin/bash
' > /etc/pam.d/ssh-login.sh

sudo echo "EMAIL=$EMAIL" >> /etc/pam.d/ssh-login.sh

sudo echo "SUBJECT=\"Vps Ssh Login!  \`date\` \"" >> /etc/pam.d/ssh-login.sh

sudo echo "MESSAGE=\"
A user signed into your server through SSH.
-------------------------------------------
Username: \${PAM_USER}
IP Address: \${PAM_RHOST}
Date: \`date\`\"
" >> /etc/pam.d/ssh-login.sh

sudo echo '
# Send email
if [ ${PAM_TYPE} = "open_session" ]; then
        echo "${MESSAGE}" | mail -s "${SUBJECT}" "${EMAIL}"
fi

exit 0
' >> /etc/pam.d/ssh-login.sh

chmod 0700 /etc/pam.d/ssh-login.sh
chown root:root /etc/pam.d/ssh-login.sh
chmod +x /etc/pam.d/ssh-login.sh

sudo sed -i "/session required pam_exec.so \/etc\/pam.d\/ssh-login.sh/d" /etc/pam.d/sshd
sudo echo "
session required pam_exec.so /etc/pam.d/ssh-login.sh
" >> /etc/pam.d/sshd