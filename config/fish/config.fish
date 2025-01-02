set fish_greeting ""

### SETUP COLORS ###
set -gx TERM xterm-256color
set -x DISPLAY :0

### SETUP EZA ###
alias ls='eza -al --color=always --group-directories-first --icons --git'

### SETUP FZF ###
fzf --fish | source
fzf_configure_bindings --directory=\t
set fzf_preview_dir_cmd eza --all --color=always
set fzf_fd_opts --hidden --max-depth 1

### Fish ###
alias s='source ~/.config/fish/config.fish'

### PACMAN AND YAY ###
alias install='sudo pacman -S --needed --noconfirm'
alias update='yay -Syuu --noconfirm && yay -Scc --noconfirm && yay -Yc --noconfirm && fisher update'
alias y='yay -S --noconfirm'
alias yc='yay -Scc && yay -Yc'
alias unlock='sudo rm /var/lib/pacman/db.lck'
alias orphan='sudo pacman -Rns (pacman -Qtdq)'
alias remove='sudo pacman -Rcns'

### NVIM ###
alias nv='nvim *'

### FASTFETCH ###
alias ff='fastfetch'

### SETUP ZOXIDE ###
zoxide init fish | source

### SETTING THE STARSHIP PROMPT ###
starship init fish | source

### REPLACE CAT WITH BAT ###
if type -q bat
    abbr --add -g cat batv
end

### Path Variables ###
fish_add_path ~/go/bin
fish_add_path ~/.cargo/bin
