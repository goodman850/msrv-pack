#!/bin/bash
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
#Getting
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
error1="${RED}[ERROR]${NC}"
success="${GREEN}[SUCCESS]${NC}"
clear

if [ -z "$1" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

domain="$1"

echo -e "========================="
echo -e "${NC}${GREEN}Domain/Host: ${domain}${NC}"
echo -e "========================="
echo -e "${success} Please wait..."
mkdir -p /usr/bin/xray
mkdir -p /etc/xray
echo $domain >> /etc/xray/domain
echo $domain >> /root/domain
echo "IP=$domain" >> /var/lib/onlynetstorevpn/ipvps.conf
echo "none" >> /var/lib/onlynetstorevpn/cfndomain
sleep 1

# Additional commands here

