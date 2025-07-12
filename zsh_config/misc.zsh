eval "$(zoxide init zsh)"

alias zs="zellij_sessionizer"
bindkey -s ^f "zellij_sessionizer\n"  # Ctrl+F shortcut

export PATH=$HOME/.local/bin:$PATH
export XDG_DATA_DIRS="$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/isaac/.local/share/flatpak/exports/share"
