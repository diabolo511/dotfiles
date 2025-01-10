1. Wenn ich den Stick gebootet habe?
 - loadkeys de-latin1
 - pacman -Sy
 - pacman-key --refresh-keys
 - pacman-key --init
 - archinstall

2. Config 
 - Set Language
 - Set Keyboard Layout de_DE
 - Diskpartition: btrfs
 - Set Profile: KDE oder GNOME
 - Set User: NAME set as root
 - additional Package: git
 - graphics: AMD

3. Post Install
 - cd .config
 - git clone https://github.com/diabolo511/dotfiles.git
 - cd dotfiles
 - ./install.sh
 - cp -r dotzshrc /home/danny/.zshrc

4. Wichtige Befehle
 - update - Update all packages
 - install - Installation von Paketen aus offiziellen Quellen
 - remove - Löschen von Paketen aus offiziellen Quellen
 - y - installation von Paketen aus AUR
 - yr - löschen von Paketen aus AUR
 - c - löschen von Eingaben aus dem Terminal

5. Wichtige Links
 - archlinux.org
 - archlinux.org/packages/q=
 - aur.archlinux.org/packages?O=0&k=