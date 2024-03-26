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
BRED="\e[41m"
BBLUE="\e[38;5;21m"
#information
OK="${GREEN}[OK]${NC}"
Error="${RED}[Mistake]${NC}"
#pkg install ncurses-utils
#echo -e "Getting Information Please Wait...."
is_root() {
    if [ 0 == $UID ]; then
        echo -e "${OK} ${NC} The current user is the root user..${NC}"
        sleep 1
        echo -e "Getting Information...."
    else
        echo -e "${Error} ${NC} Please switch to the root user and execute start-menu again ${NC}"
        exit 1
    fi
}
is_root
#pkg install ncurses-utils
ip=$(wget -qO- ipinfo.io/ip)
domainhost=$(cat /root/domain)
region=$(wget -qO- ipinfo.io/region)
isp=$(wget -qO- ipinfo.io/org)
timezone=$(wget -qO- ipinfo.io/timezone)
ossys=$(neofetch | grep "OS" | cut -d: -f2 | sed 's/ //g')
host=$(neofetch | grep "Host" | cut -d: -f2 | sed 's/ //g')
kernel=$(neofetch | grep "Kernel" | cut -d: -f2 | sed 's/ //g')
uptime=$(neofetch | grep "Uptime" | cut -d: -f2 | sed 's/ //g')
cpu=$(neofetch | grep "CPU" | cut -d: -f2 | sed 's/ //g')
memory=$(neofetch | grep "Memory" | cut -d: -f2 | sed 's/ //g')
echo -e "Getting Information..."
clear
# echo -e "$BLUE━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"$NC
# echo -e "$BRED           SELAMAT DATANG            $NC"
# echo -e "$BLUE━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"$NC
# figlet TiTan-do| lolcat
# #echo -e "$NC"
# echo -e "Telegram : @OnlyNet"
echo -e "$BLUE━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$NC"
echo -e "$BRED          InformaTion System           $NC"
echo -e "$BLUE━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$NC"
echo -e "$CLAY IP Address :$NC $ip $NC"
echo -e "$CLAY Domain :$NC $domainhost $NC"
echo -e "$CLAY Region :$NC $region $NC"
echo -e "$CLAY ISP :$NC $isp $NC"
echo -e "$CLAY Host :$NC $host $NC"
echo -e "$CLAY CPU :$NC $cpu $NC"
echo -e "$CLAY Kernel :$NC $kernel $NC"
echo -e "$CLAY Up Time :$NC $uptime $NC"
echo -e "$CLAY OS System :$NC $ossys $NC"
echo -e "$CLAY Time Zone :$NC $timezone $NC"
echo -e "$CLAY Date :$NC $(date +%A) $(date +%m-%d-%Y)"
echo -e "$CLAY Memory :$NC $memory $NC"
echo -e "$BLUE━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$NC"
echo -e "$BRED           Service Status            $NC"
echo -e "$BLUE━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$NC"
# add edit
apt install curl socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y
apt install socat cron bash-completion ntpdate -y
ntpdate pool.ntp.org
apt -y install chrony
timedatectl set-ntp true
systemctl enable chronyd && systemctl restart chronyd
systemctl enable chrony && systemctl restart chrony
timedatectl set-timezone Asia/Tehran
chronyc sourcestats -v
chronyc tracking -v
latest_version="$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
# / / Installation Xray Core
xraycore_link="https://github.com/XTLS/Xray-core/releases/download/v$latest_version/xray-linux-64.zip"

# / / Make Main Directory
rm -rf /usr/bin/xray
rm -rf /usr/local/bin/xray
#rm -rf /etc/xray
rm -rf /var/log/xray

mkdir -p /usr/bin/xray
mkdir -p /etc/xray
mkdir -p /var/log/xray/
# / / Unzip Xray Linux 64
cd $(mktemp -d)
curl -sL "$xraycore_link" -o xray.zip
unzip -q xray.zip && rm -rf xray.zip
mv xray /usr/local/bin/xray
chmod +x /usr/local/bin/xray

# Make Folder XRay
mkdir -p /var/log/xray/
touch /var/log/xray/access.log
touch /var/log/xray/error.log
sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill
cd /root/
#service squid start
#new coming
uuid1=$(cat /proc/sys/kernel/random/uuid)
uuid2=$(cat /proc/sys/kernel/random/uuid)
uuid3=$(cat /proc/sys/kernel/random/uuid)
uuid4=$(cat /proc/sys/kernel/random/uuid)
uuid5=$(cat /proc/sys/kernel/random/uuid)
uuid6=$(cat /proc/sys/kernel/random/uuid)
uuid=$(cat /proc/sys/kernel/random/uuid)
# //
touch /etc/xray/v2ray-tls.json
touch /etc/xray/vless-tls.json
touch /etc/xray/vless-nontls.json
touch /etc/xray/trojan.json

# // Certificate File
path_crt="/etc/xray/xray.crt"
path_key="/etc/xray/xray.key"
rm -rf /etc/xray/config.json
touch /etc/xray/config.json

cat >/etc/xray/config.json <<END
{
  "log": {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
"listen": "127.0.0.1",
"port": 10085,
"protocol": "dokodemo-door",
"settings": {
"address": "127.0.0.1"
},
"tag": "api",
"sniffing": null
},

{
  "listen": "0.0.0.0",
      "port": 8443,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid3}"

          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "${path_crt}",
              "keyFile": "${path_key}"
            }
          ]
        },
        
        "wsSettings": {
          "path": "/vless/",
          "headers": {
            "Host": "$domain"
          }
        }
        
      },
      
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    },
    {
      "listen": "0.0.0.0",
      "port": 80,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid4}"

          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "path": "/vless/",
          "headers": {
            "Host": "$domain"
          }
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": ["http", "tls"]
      }
    },
    {
      "listen": "0.0.0.0",
      "port": 2087,
      "protocol": "trojan",
      "settings": {
        "clients": [
          {
            "password": "${uuid5}"

          }
        ],
        "fallbacks": [
          {
            "dest": "$domain:80"
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "${path_crt}",
              "keyFile": "${path_key}"
            }
          ],
          "alpn": [
            "http/1.1"
          ]
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": ["http", "tls"]
      }
      
     },
     {
            "listen": "0.0.0.0",
            "port": 2053,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "email": "general@vless-tcp-xtls",
                        "id": "9f2b4b10-6818-492e-a157-d5131d450c7b",
                        "flow": "xtls-rprx-vision",
                        "level": 0
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "tcp",
                "security": "reality",
                "realitySettings": {
                    "show": false,
                    "dest": "zula.ir:443",
                    "xver": 0,
                    "serverNames": [
                        "zula.ir",
						 "www.zula.ir"
                    ],
                    "privateKey": "M4cZLR81ErNfxnG1fAnNUIATs_UXqe6HR78wINhH7RA",
                    "minClientVer": "",
                    "maxClientVer": "",
                    "maxTimeDiff": 0,
                    "shortIds": [
                        "b1"
                    ]
                }
            },
            "sniffing": {
                "enabled": true,
                "destOverride": [
                    "http",
                    "tls"
                ]
            }
        }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      },
      {
        "inboundTag": [
          "api"
        ],
        "outboundTag": "api",
        "type": "field"
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  },
  "stats": {},
  "api": {
    "services": [
"HandlerService",
"LoggerService",
"StatsService"
    ],
    "tag": "api"
  },
  "policy": {
    "levels": {
      "0": {
        "statsUserDownlink": true,
        "statsUserUplink": true
      }
    },
    "system": {
     "statsInboundUplink": true,
"statsInboundDownlink": true,
"statsOutboundUplink": true,
"statsOutboundDownlink": true
    }
  }
}
END

# / / Installation Xray Service
cat >/etc/systemd/system/xray.service <<END
[Unit]
Description=Xray Service By onlynet
Documentation=https://t.me/onlynet_sup
After=network.target nss-lookup.target

[Service]
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray -config /etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target
END
rm -rf /var/www/html/p/log/pyapi.py
touch /var/www/html/p/log/das
touch /var/www/html/p/log/dcp
wget -O /var/www/html/p/log/pyapi.py "https://raw.githubusercontent.com/goodman850/titanic-pack1/master/xray/pyapi.py"
chmod +x /var/www/html/p/log/*

# // Enable & Start Service
# Accept port Xray
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 8443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 8443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 80 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2087 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2087 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2053 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2053 -j ACCEPT
iptables-save >/etc/iptables.up.rules
iptables-restore -t </etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
systemctl daemon-reload
systemctl stop xray.service
systemctl start xray.service
systemctl enable xray.service
systemctl restart xray.service


#end edit
if [ "$xrays" == "$ell" ]; then
 echo -e " Xray/V2Ray              :$GREEN [Running] $NC"
 else
 echo -e " Xray/V2Ray              :$RED [soon] $NC"
 fi
echo -e "$BLUE━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$NC"
echo -e "$BRED----------- Mod By TiTan-do-----------"
echo -e "$BLUE━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$NC"