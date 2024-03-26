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
# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
IZIN=$(curl -k https://titanic.icu/apiV2/api.php?myip=5 )
if [ $MYIP = $IZIN ]; then
echo -e "${NC}${GREEN}Permission Accepted...${NC}"
else
echo -e "${NC}${RED}Permission Denied!${NC}";
echo -e "${NC}${LIGHT}Please Contact Admin!!"
echo -e "${NC}${LIGHT}Telegram : https://t.me/OnlyNet"
exit 0
fi
clear
OnlyNetupdate="raw.githubusercontent.com/goodman850/msrv-pack/master/update"
# change direct
cd /usr/bin
# remove file
rm menu
rm -rf menu
# Download update
wget -O menu "https://${OnlyNetupdate}/menu.sh"
wget -O maddssh "https://${OnlyNetupdate}/maddssh.sh"
wget -O mbackup "https://${OnlyNetupdate}/mbackup.sh"
wget -O maddxray "https://${OnlyNetupdate}/maddxray.sh"
wget -O xray1 "https://${OnlyNetupdate}/xray1.sh"
wget -O xray2 "https://${OnlyNetupdate}/xray2.sh"
wget -O xray3 "https://${OnlyNetupdate}/xray3.sh"
wget -O msetting "https://${OnlyNetupdate}/msetting.sh"
wget -O start-menu "https://${OnlyNetupdate}/start-menu.sh"
# change Permission
chmod +x menu
chmod +x maddssh
chmod +x maddxray
chmod +x xray1
chmod +x xray2
chmod +x xray3
chmod +x mbackup
chmod +x msetting
chmod +x start-menu
#change direct
cd /root
# clear
#clear
echo -e "Succes Update Menu"
sleep 3
