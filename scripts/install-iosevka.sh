#!/bin/bash

echo "Downloading Iosveka"
if [ ! -f ~/Downloads/iosevka.zip ]; then
  wget -O ~/Downloads/iosevka.zip "https://github.com/be5invis/Iosevka/releases/download/v11.2.6/super-ttc-iosevka-11.2.6.zip"
fi
unzip ~/Downloads/iosevka.zip
sudo mv ./iosevka.ttc /usr/local/share/fonts
