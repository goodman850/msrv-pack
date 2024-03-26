#!/bin/bash

# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'



cat >/etc/systemd/system/compilertitan.service <<END
# compilertitan.service
[Unit]
Description=compilertitan Service
After=network.target

[Service]
ExecStart=/usr/bin/python3 /var/www/html/p/log/pyapi.py
Restart=always
RestartSec=5
StartLimitIntervalSec=5

[Install]
WantedBy=multi-user.target


END
sudo systemctl daemon-reload
sudo systemctl start compilertitan
sudo systemctl enable compilertitan
