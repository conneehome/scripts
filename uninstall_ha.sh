sudo ha core stop
sudo ha supervisor stop
sudo docker stop $(docker ps -aq)
sudo docker rm $(docker ps -aq)
sudo docker system prune -a --volumes -f
sudo rm -rf /usr/share/hassio
sudo rm -rf /etc/hassio
sudo rm -rf /root/.homeassistant
sudo systemctl disable hassio-supervisor.service
sudo systemctl stop hassio-supervisor.service
sudo rm /etc/systemd/system/hassio-supervisor.service
sudo systemctl daemon-reload
sudo apt remove --purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo apt remove --purge os-agent -y
sudo deluser --remove-home hassio
sudo apt remove --purge docker* -y
sudo rm -rf /var/lib/docker
sudo rm -rf /etc/docker
sudo apt autoremove --purge -y
sudo apt autoclean
