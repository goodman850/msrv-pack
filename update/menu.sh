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
echo -e "$BLUE╔═══════════════════════════════════════$BLUE       ╗"
echo -e "$BLUE║           $ORANGE  [ Main Menu ]          $BLUE   ║"
echo -e "$BLUE╠═══════════════════════════════════════$BLUE       ╣"
echo -e "$BLUE║---------------------------------------            ║"
echo -e "$BLUE╠➣$NC 1$NC. SSH  Accounts(view only) $BLUE          ║ "
echo -e "$BLUE╠➣$NC 2$NC. Restart All Service         $BLUE       ║ "  
echo -e "$BLUE╠➣$NC 3$NC. Settings                    $BLUE       ║ " 
echo -e "$BLUE╠➣$NC 4$NC. Check Service                 $BLUE     ║ " 
echo -e "$BLUE╠➣$NC 5$NC. Exit                        $BLUE       ║ " 
echo -e "$BLUE║---------------------------------------            ║"
echo -e "$BLUE╠➣$NC Mod By TiTan-do                       $BLUE   ║"
echo -e "$BLUE╠➣$NC Telegram https://t.me/OnlyNet       $BLUE     ║"
echo -e "$BLUE╚═══════════════════════════════════════════════════╝$NC"  
read -p "Select From Options [ 1 - 6 ] : " menu
echo -e ""
case $menu in
1)
member
;;
2)
sslh-fix-reboot
;;
3)
msetting
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
menu
;;
esac
#
