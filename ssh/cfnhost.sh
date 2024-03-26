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

error1="${RED}[ERROR]${NC}"
success="${GREEN}[SUCCESS]${NC}"

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

echo -e "========================="
read -rp "Masukan Domain/Host : " -e domain
echo -e "========================="
echo -e "${success}\nDomain : ${domain} Di Tambahkan.."
# Delete Files
rm /var/lib/onlynetstorevpn/cfndomain
# Done
echo "${domain}" >> /var/lib/onlynetstorevpn/cfndomain
sleep 5
