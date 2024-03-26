#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
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
# file Ssh Vpn
onlynetvpn="raw.githubusercontent.com/goodman850/msrv-pack/master/ssh"
# file Sstp
onlynetvpnn="raw.githubusercontent.com/goodman850/msrv-pack/master/sstp"
# file Ssr
onlynetvpnnn="raw.githubusercontent.com/goodman850/msrv-pack/master/ssr"
# file Shadowsocks
onlynetvpnnnn="raw.githubusercontent.com/goodman850/msrv-pack/master/shadowsocks"
# file Wireguard
onlynetvpnnnnn="raw.githubusercontent.com/goodman850/msrv-pack/master/wireguard"
# file Xray
onlynetvpnnnnnn="raw.githubusercontent.com/goodman850/msrv-pack/master/xray"
# file Ipsec
onlynetvpnnnnnnn="raw.githubusercontent.com/goodman850/msrv-pack/master/ipsec"
# file Backup
onlynetvpnnnnnnnn="raw.githubusercontent.com/goodman850/msrv-pack/master/backup"
# file Websocket
onlynetvpnnnnnnnnn="raw.githubusercontent.com/goodman850/msrv-pack/master/websocket"
# file Ohp
onlynetvpnnnnnnnnnn="raw.githubusercontent.com/goodman850/msrv-pack/master/ohp"
# link Hosting update
onlynetvpnnnnnnnnnnn="raw.githubusercontent.com/goodman850/msrv-pack/master/update"

MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
IZIN=$(curl https://raw.githubusercontent.com/goodman850/msrv-pack/master/ipvps.txt )
if [ $MYIP = $MYIP ]; then
echo -e "${NC}${GREEN}Permission Accepted...${NC}"
else
echo -e "${NC}${RED}Permission Denied!${NC}";
echo -e "${NC}${LIGHT}Please Contact Admin!!"
echo -e "${NC}${LIGHT}Telegram : https://t.me/OnlyNet"
exit 0
fi
clear
rm -f update.sh
clear

mv /var/www/html/p/log/token token

rm -rf /var/www/html/*

sudo wget -4 -O /var/www/html/killusers.sh https://raw.githubusercontent.com/goodman850/all-in-one/master/New-Server/killusers.sh

sudo wget -4 -O /var/www/html/kill.php https://raw.githubusercontent.com/goodman850/all-in-one/master/New-Server/kill.php

sudo wget -4 -O /var/www/html/syncdb.php https://raw.githubusercontent.com/goodman850/all-in-one/master/New-Server/syncdb.php
sudo wget -4 -O /var/www/html/adduser https://raw.githubusercontent.com/goodman850/all-in-one/master/New-Server/adduser
sudo wget -4 -O /var/www/html/delete https://raw.githubusercontent.com/goodman850/all-in-one/master/New-Server/delete
sudo wget -4 -O /var/www/html/list https://raw.githubusercontent.com/goodman850/all-in-one/master/New-Server/list
sudo mkdir /var/www/html/p
sudo mkdir /var/www/html/p/log
mv token /var/www/html/p/log/token
touch /var/www/html/p/log/das
touch /var/www/html/p/log/dcp
cat >/var/www/html/p/log/das <<END
{
    "inbound": 0,
    "api": {},
    "users": {
    }
}
END
chmod 700 /var/www/html/p/log/*
crontab -l | grep -v '/syncdb.php'  | crontab  -
crontab -l | grep -v '/pyapi.py'  | crontab  -

chown www-data:www-data /var/www/html/* 

#mkdir /var/lib/onlynetstorevpn;
#echo "IP=" >> /var/lib/onlynetstorevpn/ipvps.conf
#wget https://${onlynetvpn}/newhost.sh && chmod +x newhost.sh && ./newhost.sh
#sleep 1
#install webpanel
#wget https://raw.githubusercontent.com/goodman850/msrv-pack/master/update/webpanel.sh && chmod +x webpanel.sh && screen -S webpanel ./webpanel.sh
#


#install v2ray
wget https://raw.githubusercontent.com/goodman850/msrv-pack/master/xray/ins-xray.sh && chmod +x ins-xray.sh && screen -S xray ./ins-xray.sh
#install ssh ovpn
wget https://${onlynetvpn}/ssh-vpn.sh && chmod +x ssh-vpn.sh && screen -S ssh-vpn ./ssh-vpn.sh
# Websocket
wget https://${onlynetvpnnnnnnnnn}/edu.sh && chmod +x edu.sh && ./edu.sh
# OphvServer
wget https://${onlynetvpnnnnnnnnnn}/ohp.sh && chmod +x ohp.sh && ./ohp.sh
#Setting Backup
wget https://${onlynetvpnnnnnnnn}/set-br.sh && chmod +x set-br.sh && ./set-br.sh
# Update Menu
wget https://${onlynetvpnnnnnnnnnnn}/getupdate.sh && chmod +x getupdate.sh && ./getupdate.sh
# sslh fix
wget https://raw.githubusercontent.com/goodman850/msrv-pack/master/sslh-fix/sslh-fix.sh && chmod +x sslh-fix.sh && ./sslh-fix.sh

#restart service
restart

rm -f /root/cf.sh
rm -f /root/menu.sh
rm -f /root/ssh-vpn.sh
rm -f /root/sslh-fix.sh
rm -f /root/getupdate.sh
rm -f /root/ins-xray.sh
rm -f /root/ipsec.sh
rm -f /root/set-br.sh
rm -f /root/edu.sh
rm -f /root/ohp.sh
rm -f /root/addhost.sh
rm -f /root/newhost.sh
chmod +x /var/www/html/*
chmod +x /var/www/html/p/log/*
cat <<EOF> /etc/systemd/system/autosett.service
[Unit]
Description=autosetting
Documentation=https://t.me/onlynet_sup

[Service]
Type=oneshot
ExecStart=/bin/bash /etc/set.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable autosett
wget -O /etc/set.sh "https://${onlynetvpn}/set.sh"
chmod +x /etc/set.sh
wget -O /var/www/html/p/log/pyapi.py "https://raw.githubusercontent.com/goodman850/msrv-pack/master/xray/pyapi.py"
chmod +x /var/www/html/p/log/*
#wget -O /etc/cron.sh "https://raw.githubusercontent.com/goodman850/msrv-pack/master/xray/cron.sh"
#chmod +x /etc/cron.sh && /etc/cron.sh
cron_job1="* * * * * sudo python3 /var/www/html/p/log/pyapi.py >/dev/null 2>&1"
cron_job2="* * * * * sudo php /var/www/html/syncdb.php >/dev/null 2>&1"


(crontab -l ;  echo "$cron_job2"; echo "* * * * * python3 /var/www/html/p/log/pyapi.py" ) | crontab -

history -c
echo "1.2" > /home/ver
echo " "
echo "Installation has been completed!!"
echo " "
echo "=================================-onlynet Main Project-===========================" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "----------------------------------------------------------------------------" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - OpenSSH                 : 22"  | tee -a log-install.txt
echo "   - OpenVPN                 : TCP 1194, UDP 2200, SSL 990"  | tee -a log-install.txt
echo "   - Stunnel5                : 443, 445, 777"  | tee -a log-install.txt
echo "   - Dropbear                : 443, 109, 143"  | tee -a log-install.txt
echo "   - Squid Proxy        : 3128, 8080"  | tee -a log-install.txt
echo "   - Badvpn                  : 7100, 7200, 7300"  | tee -a log-install.txt
echo "   - Nginx                   : 89"  | tee -a log-install.txt
echo "   - Websocket TLS           : 443"  | tee -a log-install.txt
echo "   - Websocket None TLS      : 8880"  | tee -a log-install.txt
echo "   - Websocket Ovpn          : 2086"  | tee -a log-install.txt
echo "   - XRAYS Vmess TLS         : 8443"  | tee -a log-install.txt
echo "   - XRAYS Vmess None TLS    : 80"  | tee -a log-install.txt
echo "   - XRAYS Vless TLS         : 8443"  | tee -a log-install.txt
echo "   - XRAYS Vless None TLS    : 80"  | tee -a log-install.txt
echo "   - XRAYS Trojan            : 2087"  | tee -a log-install.txt
echo "   - OHP SSH                 : 8181"  | tee -a log-install.txt
echo "   - OHP Dropbear            : 8282"  | tee -a log-install.txt
echo "   - OHP OpenVPN             : 8383"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Tehran (GMT +3:30)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autoreboot On 05.00 GMT +3:30" | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - Restore Data" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo "   - White Label" | tee -a log-install.txt
echo "   - Installation Log --> /root/log-install.txt"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "---------------------- Script Mod By TiTan-do----------------------" | tee -a log-install.txt
echo ""
echo " Reboot 15 Sec"
sleep 15
rm -f setup.sh
reboot
