#!/bin/sh

killall -q polybar

feh --bg-scale --zoom fill ~/.config/dotfiles/config/01.jpg

picom --config ~/.config/picom/picom.conf & disown

dunst &
polybar & disown

dbus-update-activation-environment --all & disown

gnome-keyring-daemon --start --components=ssh,secrets,pkcs11,login & disown

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1  & diown

discord-canary & disown
spotify-launcher & disown
