#!/bin/bash

echo "Batocera.PRO CasaOS installer..."
echo "This can take a while... please wait."

sleep 5

# Define the home directory
HOME_DIR=/userdata/system

# Define URLs for the split zip files
ZIP_PART_1="https://github.com/garbagescow/batocera.pro/releases/download/batocera-containers/batocera-casaos.tar.zip.001"
ZIP_PART_2="https://github.com/garbagescow/batocera.pro/releases/download/batocera-containers/batocera-casaos.tar.zip.002"
ZIP_PART_3="https://github.com/garbagescow/batocera.pro/releases/download/batocera-containers/batocera-casaos.tar.zip.003"
ZIP_PART_4="https://github.com/garbagescow/batocera.pro/releases/download/batocera-containers/batocera-casaos.tar.zip.004"

# Change to home directory
cd "${HOME_DIR}"
if [ $? -ne 0 ]; then
    echo "Failed to change to home directory. Exiting."
    exit 1
fi

#Get aria2c
echo "Fetching Aria2c"

curl -L https://github.com/garbagescow/batocera.pro/raw/main/.dep/.scripts/aria2c.sh | bash

# Download the split zip files using aria2 with multiple connections
echo "Downloading split zip files using multiple connections..."
./aria2c -x 5 -s 5 "${ZIP_PART_1}" "${ZIP_PART_2}" "${ZIP_PART_3}" "${ZIP_PART_4}"
if [ $? -ne 0 ]; then
    echo "Failed to download one or more parts of the split zip file. Exiting."
    exit 1
fi

# Combine the zip files
echo "Combining split zip files..."
cat batocera-casaos.tar.zip.* > batocera-casaos.tar.zip
if [ $? -ne 0 ]; then
    echo "Failed to combine the split zip files. Exiting."
    exit 1
fi

# Unzip the combined zip file
echo "Unzipping combined zip file..."
unzip -q "batocera-casaos.tar.zip"
if [ $? -ne 0 ]; then
    echo "Failed to unzip the file. Exiting."
    exit 1
fi

# Extract the tar.gz file
echo "Extracting the tar.gz file..."
tar -xf "batocera-casaos.tar"
if [ $? -ne 0 ]; then
    echo "Failed to extract the tar.gz file. Exiting."
    exit 1
fi

# Clean up zip and tar files
rm batocera-casaos.tar.zip*
rm batocera-casaos.tar

# Download the executable using aria2
echo "Downloading the executable file..."
aria2c -x 5 -s 5 "https://github.com/garbagescow/batocera.pro/releases/download/batocera-containers/batocera-casaos" -o "${HOME_DIR}/casaos/batocera-casaos"
if [ $? -ne 0 ]; then
    echo "Failed to download executable. Exiting."
    exit 1
fi

# Make the executable runnable
chmod +x "${HOME_DIR}/casaos/batocera-casaos"
if [ $? -ne 0 ]; then
    echo "Failed to make the file executable. Exiting."
    exit 1
fi

# Add casa to custom.sh for autostart
echo "/userdata/system/casaos/batocera-casaos &" >> ~/custom.sh

# Run the executable
echo "Running the executable..."
"${HOME_DIR}/casaos/batocera-casaos"
if [ $? -ne 0 ]; then
    echo "Failed to run the executable. Exiting."
    exit 1
fi

# Final dialog message with casaos management info
MSG="Casaos container has been set up.\n\nAccess casa Web UI at http://<your-batocera-ip>:80 \n\nRDP Debian XFCE Desktop port 3389 username/password is root/linux\n\nCasaos data stored in: ~/casaos\n\nDefault web ui username/password is batocera/batoceralinux"
dialog --title "Casaos Setup Complete" --msgbox "$MSG" 20 70

echo "Process completed successfully."

echo "1) to stop the container, run:  podman stop casaos"
echo "2) to enter zsh session, run:  podman exec -it casaos zsh"
