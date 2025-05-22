sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y && sudo apt-get autoclean -y

apt install \
network-manager \
systemd-resolved

systemctl restart systemd-resolved.service && \
systemctl disable --now networking.service && \
mv /etc/network/interfaces /etc/network/interfaces.disabled && \
systemctl restart NetworkManager

apt install \
curl \
lsb-release \
udisks2

curl -fsSL get.docker.com | sh

#Install osAgent
wget -O os-agent-aarch64.deb $(curl -s https://api.github.com/repos/home-assistant/os-agent/releases/latest | grep browser_download_url | grep 'aarch64.deb' | cut -d '"' -f 4) && sudo dpkg -i os-agent-aarch64.deb

#Install supervisor
curl -L -o homeassistant-supervised.deb https://github.com/home-assistant/supervised-installer/releases/latest/download/homeassistant-supervised.deb
apt install ./homeassistant-supervised.deb
