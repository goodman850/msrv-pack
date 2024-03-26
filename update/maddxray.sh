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
echo -e "$BLUE╔════════════════════════════════════════════╗"
echo -e "$BLUE║ $ORANGE   ✶ XRAYS Management ✶    $BLUE    ║"              
echo -e "$BLUE║--------------------------------------------║"
echo -e "$BLUE╠➣$NC 1. Repair XRAYS Config        $BLUE    ║"              
echo -e "$BLUE╠➣$NC 2. Stop XRAYS Service        $BLUE     ║"
echo -e "$BLUE╠➣$NC 3. Restart XRAYS Service        $BLUE  ║"
echo -e "$BLUE╠➣$NC 4. Check XRAYS Service Status   $BLUE  ║"
echo -e "$BLUE║--------------------------------------------║"
echo -e "$BLUE╚════════════════════════════════════════════╝$NC"

read -p " ➣ Select From Options [ 1 - 4 ]:  " menu
echo -e ""
case $menu in
1)
repairxray
;;
2)
stopxray
;;
3)
xray3
;;
4)
start-menu
;;
5)
clear
exit
;;
*)
clear
bash menu.sh
;;
esac
#
