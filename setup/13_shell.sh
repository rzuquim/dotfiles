#!/bin/bash

zsh_path="/usr/bin/zsh"
echo -e "${CYAN}Configuring shell:${NC} $zsh_path"

TERMINAL_PACKAGES=(
    "alacritty"
    "starship"
    "tmux"
    "zsh"
    "zsh-completions"
    "starship"
    "atuin"
    "tmux"
)

pacman -S --noconfirm --needed ${TERMINAL_PACKAGES[@]}

if [ ! -d /home/.shared/tmux-tpm ]; then
    git clone https://github.com/tmux-plugins/tpm /home/.shared/tmux-tpm
fi

if [ ! -d /home/.shared/zsh-completions ]; then
    git clone https://github.com/zsh-users/zsh-completions.git  /home/.shared/zsh-completions
fi

if [ ! -d /home/.shared/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions /home/.shared/zsh-autosuggestions
fi

if [ ! -d /home/.shared/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/.shared/zsh-syntax-highlighting
fi

if [ ! -d /home/.shared/zsh-history-substring-search ]; then
    git clone https://github.com/zsh-users/zsh-history-substring-search /home/.shared/zsh-history-substring-search
fi

for user in "${users[@]}"; do
    if [ ! -L "/home/$user/.tmux/plugins/tpm" ]; then
        su - $user -c "mkdir -p ~/.tmux/plugins/"
        ln -s /home/.shared/tmux-tpm /home/$user/.tmux/plugins/tpm
    fi

    if [ ! -d "/home/$user/.zsh/plugins/" ]; then
        su - $user -c "mkdir -p ~/.zsh/plugins/"
    fi

    if [ ! -L "/home/$user/.zsh/plugins/zsh-completions" ]; then
        ln -s /home/.shared/zsh-completions /home/$user/.zsh/plugins/zsh-completions
    fi

    if [ ! -L "/home/$user/.zsh/plugins/zsh-autosuggestions" ]; then
        ln -s /home/.shared/zsh-autosuggestions /home/$user/.zsh/plugins/zsh-autosuggestions
    fi

    if [ ! -L "/home/$user/.zsh/plugins/zsh-history-substring-search" ]; then
        ln -s /home/.shared/zsh-history-substring-search /home/$user/.zsh/plugins/zsh-history-substring-search
    fi

    if [ ! -L "/home/$user/.zsh/plugins/zsh-syntax-highlighting" ]; then
        ln -s /home/.shared/zsh-syntax-highlighting /home/$user/.zsh/plugins/zsh-syntax-highlighting
    fi
done
