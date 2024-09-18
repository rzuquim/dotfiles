#!/bin/bash

set_default_terminal() {
    set_terminal=$1
    terminal_name="${set_terminal##*/}"
    current_terminal=$(update-alternatives --query x-terminal-emulator | grep 'Value:' | awk '{print $2}')

    if [ "$set_terminal" != "$current_terminal" ]; then
        echo "Setting Alacritty as the default terminal emulator ($set_terminal)..."
        sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $set_terminal 50
        sudo update-alternatives --config x-terminal-emulator

        gsettings set org.gnome.desktop.default-applications.terminal exec "$terminal_name"
        gsettings set org.gnome.desktop.default-applications.terminal exec-arg ''

        bin_link="/usr/local/bin/$terminal_name"
        if [ ! -L "$bin_link" ]; then
            sudo ln -s "$set_terminal" "$bin_link" > /dev/null
        fi
    else
        echo "${GREEN}Alacritty is already the default terminal emulator.${NC}"
    fi
}

set_default_shell() {
    zsh_path=$1
    current_shell=$(getent passwd $USER | awk -F: '{print $7}')

    if [ "$current_shell" != "$zsh_path" ]; then
        echo "Setting Zsh as the default shell ($zsh_path)..."
        if [ ! -L ~/.zshrc ]; then
            ln -s ~/.config/shell/zshrc ~/.zshrc > /dev/null
        fi

        echo "Please enter your user's password"
        chsh -s $zsh_path
    else
        echo "${GREEN}Zsh is already the default shell.${NC}"
    fi
}

