#!/bin/bash

# Introductory message using dialog
dialog --title "Warning" --msgbox "This is will delete data in the following folders to reset the Nvidia container driver install:\n\n1. ~/.local/share/Conty\n2. ~/pro/steam/home\n\nThere may be saves from other AppImages, apps in ~/.local. You can back those up first if you desire." 15 60

# Confirmation dialog
if dialog --title "Confirm" --yesno "Do you want to proceed and delete the folders? Type 'yes' to continue." 10 60; then
    rm -rf ~/pro/steam/home
    rm -rf ~/.local/share/Conty
    echo "Folders deleted."
    echo ""
    echo "" 
    echo "Attempting to start Steam and get drivers as root"
    ALLOW_ROOT=1 DISPLAY=:0.0 HOME_DIR="~/pro/steam/home" ~/pro/steam/conty.sh steam -gamepadui
else
    echo "Operation canceled. No folders were deleted."
fi
