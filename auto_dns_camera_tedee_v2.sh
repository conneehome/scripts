#!/bin/bash

sudo apt-get install arp-scan -y

declare -A MAC_PREFIXES
MAC_PREFIXES["94:c9:60"]="tedeeconnee"
MAC_PREFIXES["98:a8:29"]="cameraconnee"
MAC_PREFIXES["3c:84:27"]="luxpowerconnee"

HOSTS_FILE="/etc/hosts"

DEVICE_LIST=$(sudo arp-scan --localnet)

if [ -z "$DEVICE_LIST" ]; then
    echo "Nessun dispositivo trovato. Nessuna modifica al file hosts."
    exit 0
fi

declare -A COUNTERS
for BASE_NAME in "${MAC_PREFIXES[@]}"; do
    COUNTERS["$BASE_NAME"]=1
done

# Scansiona ogni dispositivo trovato
echo "$DEVICE_LIST" | while read -r DEVICE_INFO; do
    
    DEVICE_IP=$(echo "$DEVICE_INFO" | awk '{print $1}')
    DEVICE_MAC=$(echo "$DEVICE_INFO" | awk '{print $2}')

    for PREFIX in "${!MAC_PREFIXES[@]}"; do
        if [[ "$DEVICE_MAC" =~ ^$PREFIX ]]; then
            BASE_NAME="${MAC_PREFIXES[$PREFIX]}"
            DNS_NAME="${BASE_NAME}${COUNTERS[$BASE_NAME]}.local"

            if grep -q "$DNS_NAME" "$HOSTS_FILE"; then
                sudo sed -i "s/.*$DNS_NAME/$DEVICE_IP $DNS_NAME/" "$HOSTS_FILE"
                echo "Aggiornato: $DNS_NAME  ^f^r $DEVICE_IP"
            else
                echo "$DEVICE_IP $DNS_NAME" | sudo tee -a "$HOSTS_FILE"
                echo "Aggiunto: $DNS_NAME  ^f^r $DEVICE_IP"
            fi

            COUNTERS["$BASE_NAME"]=$((COUNTERS["$BASE_NAME"] + 1))
        fi
    done
done

echo "Aggiornamento completato. Puoi accedere ai dispositivi con i loro nomi DNS dinamici."

exit 0
