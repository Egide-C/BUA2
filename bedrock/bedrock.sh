#!/bin/bash

# Define the dialog box with increased dimensions
dialog --title "WARNING!" \
       --yesno "1. This game is unstable in Batocera. Using the Keyboard in the game world may cause crashes.\
                \n  Limited testing with a gamepad seems to work. The Keyboard functions for menus.\
                \n2. This game requires you to own Minecraft Bedrock Edition for Android on your Google account.\
                \n\nCONTINUE INSTALLING?" 15 70

# Clear the dialog
clear

# Check the exit status
response=$?
case $response in
   0) echo "Agreed. Executing curl command..."
      # Execute the curl command and handle any errors
     curl -L https://raw.githubusercontent.com/uureel/batocera.pro/main/bedrock/br.sh | bash || { echo "Failed to execute curl command or the script encountered an error."; exit 1; }
      ;;
   1) echo "Declined."
      ;;
   255) echo "[ESC] key pressed."
      ;;
esac