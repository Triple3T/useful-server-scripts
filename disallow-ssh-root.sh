# run as root!
grep -q '^[ \t]*#\?[ \t]*PermitRootLogin' /etc/ssh/sshd_config \
  && sed -i -e 's/^[ \t]*#\?[ \t]*PermitRootLogin[ \t]*.*$/PermitRootLogin no/' /etc/ssh/sshd_config \
  || echo 'PermitRootLogin no' >> /etc/ssh/sshd_config
systemctl restart sshd
