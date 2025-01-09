#!/bin/sh

### --- Systmem updates --- ###

sudo pacman -Syuu --noconfirm

### --- Install packages --- ###

sudo pacman -S --needed --noconfirm base-devel

### --- Install AUR Helper --- ###

git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
cd ../ && rm -rf yay

### --- Install Software --- ###



pkgs=(
  "git"
  "bluez"
  "bluez-utils"
  "cups"
  "cups-pdf"
  "zsh"
  "which"
  "github-cli"
  "fzf"
  "ufw"
  "zoxide"
  "exa"
  "unrar"
  "unzip"
  "zip"
  "p7zip"
  "libheif"
  "ntfs-3g"
  "fastfetch"
  "zlib"
  "zenity"
  "zxing-cpp"
  "xvidcore"
  "wget"
  "whois"
  "usbutils"
  "aspell"
  "aspell-de"
  "earlyoom"
  "rsync"
  "reflector"
  "bat"
  "fd"
  "starship"
  "xclip"
  "tree"
  "ripgrep"
# ----------- #  
  "bitwarden"
  "vlc"
  "obs-studio"
  "gufw"
  "linux-firmware-qlogic"
  "spotify-launcher"
  "ghostty"
# ---------- # 
  "cmake"
  "clang"
  "ninja"
  "gdb"
  "python"
  "go"
  "nodejs"
  "npm"
# ---------- # 
  "ttf-meslo-nerd"
  "powerline-fonts"
  "noto-fonts"
  "noto-fonts-cjk"
  "noto-fonts-extra"
  "noto-fonts-emoji"
  "ttf-firacode-nerd"
  "ttf-cascadia-mono-nerd"
)

for pkg in "${pkgs[@]}"; do
  echo "-- Installing: $pkg"
  sudo pacman -S --needed --noconfirm ${pkg}
done

### --- Install AUR Software --- ###

aurpkgs=(
  "brother-mfc-l2710dw"
  "zoom"
  "aic94xx-firmware"
  "wd719x-firmware"
  "upd72020x-fw"
  "ast-firmware"
  "visual-studio-code-bin"
  "anydesk-bin"
  "discord-canary"
  "discord-canary-wayland-hook"
  "github-desktop-bin"
  "brave-bin"
)

for pkg in ${aurpkgs[@]}; do
  echo "-- Installing: $pkg"
  yay -S --noconfirm ${pkg}
done

mkdir ~/.config/ghostty
ln -sf $PWD/config/ghostty/config ~/.config/ghostty/

### --- Enable Services --- ###

sudo systemctl enable cups.service
sudo systemctl enable cups.socket
sudo systemctl start cups.service

modprobe btusb
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

sudo ufw default reject
sudo ufw enable
sudo systemctl enable ufw.service

### --- ZSH --- ###

chsh -s $(which zsh)

### --- Starship --- ###

ln -sf $PWD/config/starship.toml ~/.config/

### --- Cleanup --- ###

yay -Scc --noconfirm
yay -Yc --noconfirm

sudo mkinitcpio -P

### --- Reboot --- ###

echo "-- Installation Finished"
echo "-- Press enter to continue --"
read

reboot
