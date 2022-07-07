#!/bin/bash

# Thanks to:
# Dennis Williamson from https://askubuntu.com/questions/1705/how-can-i-create-a-select-menu-in-a-shell-script
# Meer Borg from https://askubuntu.com/questions/510752/bash-utility-dialog-leaves-a-messy-screen

source setenvvars.sh

STYLE="sel"

options=("Install essential packages" "Configure DNS" "Keys configs apply" "Interface (misc) options apply" "Quit")
dioptions=("I" "Install essential packages" "D" "Configure DNS" "K" "Keys configs apply" "M" "Interface (misc) options apply" "Q" "Quit")

dojob () {
  case $1 in
    "install")
	extras/install-essent.sh
	;;
    "dns")
	extras/setup-dns.sh
	;;
    "keys")
	extras/config-keys.sh
	;;
    "misc")
	extras/config-misc.sh
	;;
    "quit")
	exit 0
    
  esac
}


if [ $STYLE == "sel" ]
then
echo $ML_TOOLS_TITLE
select opt in "${options[@]}"
do
  case $opt in
    "Install essential packages")
	     echo "apt install"
       ;;
    "Configure DNS")
      echo "apt install dnsmasq"
      ;;
    "Quit")
	     exit 0
       ;;
    *)
	echo "Invalid option $REPLY"
  esac
done
else
  echo "Dialog mode  $TOOLS_TITLE"
  dialog --title "Select action" --backtitle "$TOOLS_TITLE" --menu "Please Select action" 0 0 0 "${dioptions[@]}"
fi
