sudo apt update
sudo apt install snapd
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo snap set certbot trust-plugin-with-root=ok
echo "Install dns plugin. example:"
echo "sudo snap install certbot-dns-cloudflare"
echo "then setup credentials and run certbot."
echo "Refer to this link: https://certbot.eff.org/"
