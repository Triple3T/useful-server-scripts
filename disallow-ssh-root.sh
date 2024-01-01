# run as root!
sed -e 's/^#\?PermitRootLogin yes.*$/PermitRootLogin no/' -i /etc/ssh/sshd_config
systemctl restart sshd
