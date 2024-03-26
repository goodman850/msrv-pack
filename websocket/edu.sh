#!/bin/bash
# Proxy For Edukasi & Imclass
# My Telegram : https://t.me/onlynet_sup
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
IZIN=$(curl https://raw.githubusercontent.com/goodman850/titanic-pack1/master/ipvps.txt )
if [ $MYIP = $MYIP ]; then
echo -e "${NC}${GREEN}Permission Accepted...${NC}"
else
echo -e "${NC}${RED}Permission Denied!${NC}";
echo -e "${NC}${LIGHT}Please Contact Admin!!"
echo -e "${NC}${LIGHT}Telegram : https://t.me/OnlyNet"
exit 0
fi
clear
# adresse
onlynetvpn="raw.githubusercontent.com/goodman850/titanic-pack1/master/websocket"

# Getting Proxy Template
wget -q -O /usr/local/bin/ws-nontls https://${onlynetvpn}/websocket.py
#cp /root/myproject/websocket/websocket.py /usr/local/bin/ws-nontls
chmod +x /usr/local/bin/ws-nontls

# Installing Service
cat > /etc/systemd/system/ws-nontls.service << END
[Unit]
Description=python2 Proxy Mod By TiTan-doMain
Documentation=https://t.me/onlynet_sup
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python2 -O /usr/local/bin/ws-nontls 8880
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable ws-nontls
systemctl restart ws-nontls

# Getting Proxy Template
wget -q -O /usr/local/bin/ws-ovpn https://${onlynetvpn}/ws-ovpn.py
#cp /root/myproject/websocket/ws-ovpn.py /usr/local/bin/ws-ovpn
chmod +x /usr/local/bin/ws-ovpn

# Installing Service
cat > /etc/systemd/system/ws-ovpn.service << END
[Unit]
Description=python2 Proxy Mod By LamVpn
Documentation=https://t.me/LamVpn
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python2 -O /usr/local/bin/ws-ovpn 2086
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable ws-ovpn
systemctl restart ws-ovpn

# Getting Proxy Template
wget -q -O /usr/local/bin/ws-tls https://${onlynetvpn}/ws-tls

chmod +x /usr/local/bin/ws-tls

# Installing Service
cat > /etc/systemd/system/ws-tls.service << END
[Unit]
Description=python2 Proxy Mod By geovpn
Documentation=https://t.me/geovpn
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python2 -O /usr/local/bin/ws-tls 443
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable ws-nontls
systemctl restart ws-nontls
systemctl enable ws-tls
systemctl restart ws-tls
sleep 3