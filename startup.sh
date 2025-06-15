#!/bin/sh
##### !!!!! SEE LINE 3 AND LINE 10 AND FOLLOW THE INSTRUCTION TO MAKE YOUR OWN STARTUP SCRIPT !!!!! #####
TARGET_USER=username ##### enter your desired username instead #####
# add user and home directory with .ssh directory
useradd -s /bin/bash -d /home/$TARGET_USER/ -m -G sudo $TARGET_USER
mkdir -p /home/$TARGET_USER/.ssh
chmod 700 /home/$TARGET_USER/.ssh
# write authorized_keys file to login with key file
cat <<EOF | tee /home/$TARGET_USER/.ssh/authorized_keys
##### replace this line with your public key, looks like: ssh-rsa (public_key) (user@host) #####
EOF
chmod 600 /home/$TARGET_USER/.ssh/authorized_keys
chown -R $TARGET_USER:$TARGET_USER /home/$TARGET_USER
# give sudo permission to added user
echo "$TARGET_USER ALL=NOPASSWD: ALL" >> /etc/sudoers
# fail2ban install, set jail time to 10080m(=7d), apply
apt install -y fail2ban
sed -e 's/10m/10080m/g' -i /etc/fail2ban/jail.conf
systemctl enable fail2ban
systemctl restart fail2ban
# turn off root login via ssh
grep -q '^[ \t]*#\?[ \t]*PermitRootLogin' /etc/ssh/sshd_config \
  && sed -i -e 's/^[ \t]*#\?[ \t]*PermitRootLogin[ \t]*.*$/PermitRootLogin no/' /etc/ssh/sshd_config \
  || echo 'PermitRootLogin no' >> /etc/ssh/sshd_config
systemctl restart sshd
