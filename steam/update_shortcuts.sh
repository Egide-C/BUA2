#!/bin/bash

github_url="https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/"
target_directory="/userdata/roms/conty/"

# List of .sh files to download
sh_files=(
  "Antimicrox.sh"
  "Balena-Etcher.sh"
  "Boilr.sh"
  "Firefox.sh"
  "GameHub.sh"
  "Geforce Now.sh"
  "Google-Chrome.sh"
  "Gparted.sh"
  "Greenlight.sh"
  "Heroic Game Launcher.sh"
  "Kodi.sh"
  "Libreoffice.sh"
  "Lutris.sh"
  "Microsoft-Edge.sh"
  "Minigalaxy.sh"
  "Moonlight.sh"
  "OBS Studio.sh"
  "PCManFM (File Manager).sh"
  "Peazip.sh"
  "Play on Linux 4.sh"
  "Protonup-Qt.sh"
  "Qbittorrent.sh"
  "Qdirstat.sh"
  "Smplayer.sh"
  "Steam Big Picture Mode.sh"
  "Steam.sh"
  "SteamTinker Launch (settings).sh"
  "Terminal-Root.sh"
  "Terminal.sh"
  "VLC.sh"
  "Zoom.sh"
)

# Create the target directory if it doesn't exist
mkdir -p "$target_directory"

# Download the specified .sh files and make them executable
for file in "${sh_files[@]}"; do
  # Replace spaces with '%20' for URL encoding
  encoded_file=$(echo "$file" | sed 's/ /%20/g')
  echo "Downloading $file..."
  #curl -sSL "${github_url}${encoded_file}" -o "${target_directory}${file}"
  wget -q --tries=10 --no-check-certificate --no-cache --no-cookies -O "${target_directory}${file}" "${github_url}${encoded_file}"
  chmod +x "${target_directory}${file}"
done


# Target directory
DIRECTORY="/userdata/roms/steam2"

# Find and delete all .sh files within the specified directory
find "$DIRECTORY" -type f -name "*.sh" -exec rm -f {} +

echo "All .sh files in $DIRECTORY have been deleted."

# URL of the .sh file to download
FILE_URL="https://github.com/trashbus99/batocera-addon-scripts/raw/main/__REFRESH_ES_STEAM_GAMES__.sh"
# Target file path
TARGET_FILE="$DIRECTORY/__REFRESH_ES_STEAM_GAMES__.sh"

# Download the file
curl -L "$FILE_URL" -o "$TARGET_FILE"

# Make the downloaded file executable
chmod +x "$TARGET_FILE"

echo "Downloaded and made executable: $TARGET_FILE"
sleep2

echo "refreshing steam list"
/userdata/roms/steam2/__REFRESH_ES_STEAM_GAMES__.sh
echo "done"
sleep 2
echo " Done. Reloading Emulationstation"
killall -9 emulationstation
sleep 2
echo "Done"
