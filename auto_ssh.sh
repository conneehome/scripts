#!/bin/bash

docker exec -it homeassistant sh -c '
  apk add --no-cache sshpass &&
  ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N "" -q &&
  cp -i ~/.ssh/id_ed25519 /config && cp -i ~/.ssh/id_ed25519.pub /config
  cd /config
  sshpass -p "root" ssh-copy-id -i ./id_ed25519 -o StrictHostKeyChecking=no root@localhost'