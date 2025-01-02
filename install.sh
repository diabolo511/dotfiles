#!/bin/sh

### --- Systmem updates --- ###

sudo pacman -Syuu --noconfirm

### --- Install packages --- ###

sudo pacman -S --needed --noconfirm base-devel polkit-gnome libsecret gnome-keyring

### --- Install AUR Helper --- ###

git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
cd ../ && rm -rf yay

### --- Install Software --- ###

if [[ "$1" == "--X11" ]]; then
  pkgs=(
  "polybar" 
  "dunst" 
  "feh" 
  "maim" 
  "xdg-desktop-portal" 
  "playerctl" 
  "picom" 
  "xorg-setxkbmap" 
  "nwg-look" 
  "rofi" 
  "xdg-desktop-portal-gtk"
  )
  for pkg in "${pkgs[@]}"; do
    echo "-- Installing: $pkg"
    sudo pacman -S --needed --noconfirm ${pkg}
  done

  mkdir ~/.config/rofi/
  ln -sf $PWD/config/rofi/config.rasi ~/.config/rofi/
  ln -sf $PWD/config/rofi/themes/ ~/.config/rofi/

  mkdir ~/.config/polybar/
  ln -sf $PWD/config/polybar/colors.ini ~/.config/polybar/
  ln -sf $PWD/config/polybar/config.ini ~/.config/polybar/
  ln -sf $PWD/config/polybar/modules.ini ~/.config/polybar/
  ln -sf $PWD/config/polybar/scripts/ ~/.config/polybar/

  mkdir ~/.config/dunst/
  ln -sf $PWD/config/dunst/dunstrc ~/.config/dunst/

  mkdir ~/.config/picom/
  ln -sf $PWD/config/picom/picom.conf ~/.config/picom/

  mkdir ~/.config/bspwm
  ln -sf $PWD/config/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
  chmod 755 $PWD/config/bspwm/bspwmrc

  mkdir -p ~/.config/sxhkd
  ln -s $PWD/config/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
  chmod 644 $PWD/config/sxhkd/sxhkdrc

  ln -sf $PWD/config/.Xresources ~/
fi

pkgs=(
  "git"
  "bluez"
  "bluez-utils"
  "cups"
  "cups-pdf"
  "fish"
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
  "fisher"
  "starship"
  "xclip"
  "tree"
  "ripgrep"
  "xorg-xsetroot"
  "wmctrl"
# ----------- #  
  "bitwarden"
  "vlc"
  "obs-studio"
  "gufw"
  "linux-firmware-qlogic"
  "spotify-launcher"
  "ghostty"
  "lazygit"
# ---------- # 
  "cmake"
  "clang"
  "ninja"
  "gdb"
  "python-psutil"
  "python-distutils-extra"
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
  "intellij-idea-community-edition-jre"
  "github-desktop-bin"
  "swift-bin"
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

sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service

### --- Fish --- ###

chsh -s $(which fish)
mkdir ~/.config/fish
ln -sf $PWD/config/fish/config.fish ~/.config/fish/
ln -sf $PWD/config/fish/fish_plugins ~/.config/fish/

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
