#!/bin/bash
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
#information
OK = "$ {
  Green
}[OK]$ {
  Font
}"
Error = "$ {
  Red
}[Mistake]$ {
  Font
}"
clear
echo -e "$BLUE╔═══════════════════════════════════════$BLUE╗"
echo -e "$BLUE║           $ORANGE ✶ Setting Menu ✶        $BLUE   ║"
echo -e "$BLUE╠═══════════════════════════════════════$BLUE╣"
echo -e "$BLUE║---------------------------------------║"
echo -e "$BLUE╠➣$NC 1$NC. Change Domain&Get Cert               $BLUE║ "
echo -e "$BLUE╠➣$NC 2$NC. Repair XRAYS Config             $BLUE║ "
echo -e "$BLUE╠➣$NC 3$NC. Stop XRAYS Service   $BLUE     ║ " 
echo -e "$BLUE╠➣$NC 4$NC. Restart XRAYS Service   $BLUE     ║ " 
echo -e "$BLUE╠➣$NC 5$NC. Change Port OVPN(soon clients added)   $BLUE     ║ " 
echo -e "$BLUE╠➣$NC 6$NC. Set Limit Speed             $BLUE      ║ " 
echo -e "$BLUE╠➣$NC 7$NC. Check Bandwith Server         $BLUE      ║ " 
echo -e "$BLUE╠➣$NC 8$NC. Rennew Cert                 $BLUE      ║ " 
echo -e "$BLUE╠➣$NC 9$NC. Back to Menu                $BLUE      ║ " 
echo -e "$BLUE║---------------------------------------║"
echo -e "$BLUE╚═══════════════════════════════════════╝$NC"  
read -p "Select From Options [ 1 - 7 ] : " menu
echo -e ""
case $menu in
1)
addhost
;;
2)
xray1
;;
3)
xray2
;;
4)
xray3
;;
5)
portopvn
;;
6)
limitspeed
;;
7)
vnstat
;;
8)
certsslh
;;
9)
clear
menu
;;
*)
clear
msetting
;;
esac
#