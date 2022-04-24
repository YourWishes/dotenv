#!/bin/bash

# Create applications directory
mkdir -p ~/Applications

# Prep snap
#sudo ln -s /var/lib/snapd/snap /snap

toInstall=(
  firefox
  gparted
  solaar
  qbittorrent
  vlc
  pinta
  cheese
  meld
  filezilla
  inkscape
  gnome-chess
  gnome-mines
  gnome-sudoku
  aisleriot
  handbrake
  audacity
  blender
  tiled
  libreoffice-fresh
  xorg-xcursorgen
)

# Arch Linux Setup
if [ -f "/etc/arch-release" ]; then
  sudo pacman -S  -q --noconfirm $toInstall

  # VS Code (Arch)
  git clone https://aur.archlinux.org/visual-studio-code-bin
  cd visual-studio-code-bin
  makepkg -si --noconfirm
  cd ..
fi

# Debian set up
if [ -f "/etc/debian_version" ]; then
  sudo apt install --assume-yes $toInstall

  # VS Code (Debian)
  wget https://az764295.vo.msecnd.net/stable/899d46d82c4c95423fb7e10e68eba52050e30ba3/code_1.63.2-1639562499_amd64.deb -O ~/Downloads/vscode.deb
  sudo dpkg -i ~/Downloads/vscode.deb
  rm ~/Downloads/vscode.deb
fi

# Install programs using flatpak
flatpak install flathub \
    com.bitwarden.desktop \
    com.obsproject.Studio \
    com.discordapp.Discord \
    com.usebottles.bottles \
    org.libretro.RetroArch \
    org.gnome.NetworkDisplays \
    org.gnome.gitlab.YaLTeR.VideoTrimmer \
    net.ankiweb.Anki \
    com.orama_interactive.Pixelorama \
    com.parsecgaming.parsec \
    com.github.tenderowl.frog \
    com.uploadedlobster.peek \
    --assumeyes

# pCloud
wget https://p-def8.pcloud.com/cBZu1eKrMZMqwjTqZZZh9ILr7Z2ZZmNzZkZPF7pVZrHZrzZBpZpRZc5Z6pZopZ9pZApZGFZUJZkJZPpZkzZWTVkVZQDtD9nHvjKu7c1tTLeXYVj05EfNk/pcloud -O ~/Applications/pcloud
chmod +x ~/Applications/pcloud
~/Applications/pcloud &

# PIA
wget https://installers.privateinternetaccess.com/download/pia-linux-3.3.1-06924.run -O ~/Downloads/pia.run
chmod +x ~/Downloads/pia.run
mkdir -p ~/.config/privateinternetaccess
cp ./scripts/pia-settings.json ~/.config/privateinternetaccess/clientsettings.json
~/Downloads/pia.run
rm ~/Downloads/pia.run

# Moe Theme
wget https://gitlab.com/jomada/moe-theme/-/archive/master/moe-theme-master.tar.gz -O moe.tar.gz
tar -xzvf ./moe.tar.gz

# Dark
cp -r ./moe-theme-master/MoeDark-Global/* ~/.local/share/plasma/look-and-feel/
cp -r ./moe-theme-master/MoeDark ~/.local/share/plasma/desktoptheme/MoeDark
cp -r ./moe-theme-master/MoeDark-aurorae/* ~/.local/share/aurorae/themes/
cp ./moe-theme-master/Moe-Dark-color-schemes/MoeDark.colors ~/.local/share/color-schemes/MoeDark.colors

# Light
cp -r ./moe-theme-master/Moe-Global/* ~/.local/share/plasma/look-and-feel/
cp -r ./moe-theme-master/Moe ~/.local/share/plasma/desktoptheme/Moe
cp -r ./moe-theme-master/aurorae/* ~/.local/share/aurorae/themes/
cp ./moe-theme-master/color-schemes/Moe.colors ~/.local/share/color-schemes/Moe.colors

# Switch theme
lookandfeeltool -a Moe-Dark

# Iosevka Font
wget "https://objects.githubusercontent.com/github-production-release-asset-2e65be/39315600/97e975fb-b154-4b05-bd0a-3c818fdb02f9?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20220424%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220424T063917Z&X-Amz-Expires=300&X-Amz-Signature=4edc659fe314a1f8b8964063152d98f2ce1e1c971619d87c08996443ce65cf68&X-Amz-SignedHeaders=host&actor_id=0&key_id=0&repo_id=39315600&response-content-disposition=attachment%3B%20filename%3Dsuper-ttc-iosevka-ss09-15.2.0.zip&response-content-type=application%2Foctet-stream" -O ./iosevka-ss09.zip
bsdtar xvf ./iosevka-ss09.zip
mkdir -p ~/.fonts
cp -r ./*.ttc ~/.fonts/

# Papirus Icons
wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="$HOME/.local/share/icons" sh
/usr/lib/plasma-changeicons Papirus-Dark

# simp1e cursors
git clone --recurse-submodules https://gitlab.com/zoli111/simp1e.git
cd simp1e
find . -type f -name "*.sh" -exec sed -i 's/\r//' {} \;
chmod +x ./generate_svgs.sh
./generate_svgs.sh
./build_cursors.sh
cp -r ./built_themes/* ~/.local/share/icons/
kwriteconfig5 --file ~/.config/kcminputrc --group Mouse --key cursorTheme "Simp1e-"

# Wallpaper
wget https://c138.pcloud.com/dHZ31M01DZo01UIKZZZHQX4r7Z2ZZmNzZkZAwYNXZCUrpaQWBJ9YU5IC91RHV78eLjN07/wallpaper2.png -O ~/Pictures/wallpaper.png
dbus-send --session --dest=org.kde.plasmashell --type=method_call /PlasmaShell org.kde.PlasmaShell.evaluateScript "string:
var Desktops = desktops();                                                                                                                       
for (i=0;i<Desktops.length;i++) {
        d = Desktops[i];
        d.wallpaperPlugin = \"org.kde.image\";
        d.currentConfigGroup = Array(\"Wallpaper\",
                                    \"org.kde.image\",
                                    \"General\");
        d.writeConfig(\"Image\", \"file://$(realpath ~)/Pictures/wallpaper.png\");
}"