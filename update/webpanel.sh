#!/bin/bash

# Specify the port you want to use
file=/usr/lib/systemd/system/webpanel.service
if [ -e "$file" ]; then
    echo "webpanel exists"
else
  port=1234
  fi
echo -e "\nPlease input webpanel Port ."
printf "Default Port is \e[33m${port}\e[0m, please check github for reserved ports or let it blank to use this Port: "
read port


# Install required packages and download gost
sudo apt install wget nano -y
wget https://github.com/ginuerzh/gost/releases/download/v2.11.5/gost-linux-amd64-2.11.5.gz
gunzip gost-linux-amd64-2.11.5.gz

# Move gost to the /usr/local/bin/webpanel directory and make it executable
sudo mv gost-linux-amd64-2.11.5 /usr/local/bin/webpanel
sudo chmod +x /usr/local/bin/webpanel

# Create or edit the systemd service file for webpanel
cat <<EOF | sudo tee /usr/lib/systemd/system/webpanel.service
[Unit]
Description=webpanel management
After=network.target
Wants=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/webpanel -L=tcp://:$port/psrv.titanic.icu:80

[Install]
WantedBy=multi-user.target
EOF

# Start and enable the webpanel service
sudo systemctl start webpanel
sudo systemctl enable webpanel

echo "Webpanel service has been configured and started with port $port"
