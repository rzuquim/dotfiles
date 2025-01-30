#!/bin/bash

set_default_terminal() {
    set_terminal=$1
    terminal_name="${set_terminal##*/}"
    current_terminal=$(update-alternatives --query x-terminal-emulator | grep 'Value:' | awk '{print $2}')

    if [ "$set_terminal" != "$current_terminal" ]; then
        echo "Setting $terminal_name as the default terminal emulator ($set_terminal)..."
        sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $set_terminal 50
        sudo update-alternatives --config x-terminal-emulator

        gsettings set org.gnome.desktop.default-applications.terminal exec "$terminal_name"
        gsettings set org.gnome.desktop.default-applications.terminal exec-arg ''

        bin_link="/usr/local/bin/$terminal_name"
        if [ ! -L "$bin_link" ]; then
            sudo ln -s "$set_terminal" "$bin_link" > /dev/null
        fi
    else
        echo -e "${GREEN}$terminal_name is already the default terminal emulator.${NC}"
    fi
}

set_default_shell() {
    zsh_path=$1
    current_shell=$(getent passwd $USER | awk -F: '{print $7}')

    if [ "$current_shell" != "$zsh_path" ]; then
        echo "Setting Zsh as the default shell ($zsh_path)..."
        if [ -f ~/.zshrc ] && [ ! -L ~/.zshrc ]; then
            rm ~/.zshrc > /dev/null
        fi

        if [ ! -L ~/.zshrc ]; then
            ln -s ~/.config/shell/zshrc ~/.zshrc > /dev/null
        fi

        echo -e "${GREEN}Setting up oh-my-zsh plugins.${NC}"
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
        git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

        echo "Please enter your user's password"
        chsh -s $zsh_path
    else
        echo -e "${GREEN}Zsh is already the default shell.${NC}"
    fi
}

setup_dock() {
    if gsettings get org.gnome.shell favorite-apps | grep appcenter; then
        echo -e "${CYAN}Setting up dock apps${NC}"
        gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 36
    fi

    echo "Ensuring desktop app description for snapd apps"
    user_apps="$HOME/.local/share/applications"
    for snap_desktop_file in /var/lib/snapd/desktop/applications/*.desktop; do
        file_name="${snap_desktop_file##*/}"

        if [ ! -L "$user_apps/$file_name" ]; then
            ln -s "$snap_desktop_file" "$user_apps/$file_name"
        fi
    done

    DOCK_APPS=(
        # 'alacritty'
        # 'google-chrome'
        # 'brave_brave'
        # 'rider_rider'
        # 'code_code'
        # 'telegram-desktop_telegram-desktop'
        # 'Zoom'
        # 'remmina_remmina'
        # 'org.gnome.Nautilus'
        # 'gnome-control-center'
    )

    docks_app_join="["
    for app in "${DOCK_APPS[@]}"; do
        docks_app_join+="'${app}.desktop',"
    done
    docks_app_join="${docks_app_join%,}]"

    echo "Setting docks as: $docks_app_join"

    gsettings set org.gnome.shell favorite-apps "$docks_app_join"
    gsettings set org.gnome.shell.extensions.pop-shell show-title false
    gsettings set org.gnome.shell.extensions.pop-shell gap-inner uint32 5
    gsettings set org.gnome.shell.extensions.pop-shell tile-by-default true
}

set_default_profile() {
    if [ ! -L ~/.profile ]; then
        if [ -f ~/.profile ]; then
            read -p "Replace current ~/.profile with the my default? [Y/n] " response
            response=${response:-Y}
            if [[ $response =~ ^[Yy]$ ]]; then
                rm ~/.profile
            fi
        fi

        echo "Linking my ~/.profile"
        ln -s ~/.config/profile.sh ~/.profile
    else
        echo -e "${YELLOW}Profile already setup${NC}"
    fi
}

set_git_config() {
    mkdir -p ~/me
    if [ ! -L ~/.gitconfig ]; then
        echo -e "${CYAN}Setting up git...${NC}"
        ln -s ~/.config/git/gitconfig.toml ~/.gitconfig > /dev/null
    else
        echo -e "${YELLOW}Git already configured${NC}"
    fi

    GIT_WHO_AM_I="$HOME/.config/git/whoami.toml"
    if [ ! -f $GIT_WHO_AM_I  ]; then
        echo -e "${CYAN}Setting up git whoami${NC}"
        echo '[user]' > $GIT_WHO_AM_I
        echo "email = $MY_EMAIL" >> $GIT_WHO_AM_I
        echo "name = $MY_NAME" >> $GIT_WHO_AM_I
    else
        echo -e "${YELLOW}Git whoiam already configured${NC}"
    fi

    # Work
    read -p "Enter your company name: " COMPANY_NAME
    mkdir -p ~/${COMPANY_NAME}
    WORK_CONFIG="$HOME/.config/git/$COMPANY_NAME.toml"
    if [ ! -f "$WORK_CONFIG" ]; then
        read -p "Enter your email: " COMPANY_EMAIL

        echo "Setting up git for $COMPANY_NAME..."
        echo '[user]' > $WORK_CONFIG
        echo "email = $COMPANY_EMAIL" >> $WORK_CONFIG
        echo "name = $MY_NAME" >> $WORK_CONFIG

        echo "[includeIf \"gitdir:~/$COMPANY_NAME/\"]" >> ~/.config/git/gitconfig.toml
        echo "    path = $WORK_CONFIG" >> ~/.config/git/gitconfig.toml
    else
        echo "Git config for $COMPANY_NAME already configured"
    fi

    # Check if a work SSH key already exists
    COMPANY_SSH_DIR=~/.ssh/$COMPANY_NAME
    COMPANY_SSH_FILE=$COMPANY_SSH_DIR/id_ed25519
    mkdir -p $COMPANY_SSH_DIR
    if [ ! -f "$COMPANY_SSH_FILE" ]; then
        echo -e "${CYAN}No work SSH key found. Generating a new SSH key...${NC}"
        ssh-keygen -t ed25519 -C "$COMPANY_EMAIL" -f $COMPANY_SSH_FILE
        echo -e "${GREEN}SSH key generated and added to the ssh-agent.${NC}"
        echo
    fi

    MAIN_SSH_FILE=~/.ssh/id_ed25519
    MY_LOGIN="${MY_EMAIL%%@*}"
    PERSONAL_SSH_DIR=~/.ssh/$MY_LOGIN/
    mkdir -p $PERSONAL_SSH_DIR
    if [ -f "$MAIN_SSH_FILE" ] && [ ! -L "$MAIN_SSH_FILE" ]; then
        echo -e "${CYAN}Moving personal ssh file to specific file...${NC}"
        mv $MAIN_SSH_FILE "$PERSONAL_SSH_DIR/id_ed25519"
        mv "$MAIN_SSH_FILE.pub" "$PERSONAL_SSH_DIR/id_ed25519.pub"

        ln -s "$PERSONAL_SSH_DIR/id_ed25519" "$MAIN_SSH_FILE"
        ln -s "$PERSONAL_SSH_DIR/id_ed25519.pub" "$MAIN_SSH_FILE.pub"

        echo -e "${GREEN}Personal ssh files moved to .${NC}"
        echo
    fi
}

set_nvim_config() {
    if [ ! -L ~/.config/nvim ]; then
        if [ ! -d ~/me/nvim ]; then
            echo -e "${CYAN}Cloning nvim config...${NC}"
            git clone git@github.com:rzuquim/nvim.git ~/me/nvim
        fi

        echo "Linking ~/.config/nvim"
        ln -s ~/me/nvim ~/.config/nvim
    else
        echo -e "${YELLOW}Nvim already configured${NC}"
    fi
}

set_shortcuts() {
    base_gsettings="org.gnome.settings-daemon.plugins.media-keys.custom-keybinding"
    base_path="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
    custom_shortcuts=(
        "PrintScreen Interactive;flameshot gui;Print"
        "PrintScreen into file;flameshot full --path $HOME/Pictures/Screenshots/;<Shift>Print"
        "PrintScreen into clipboard;flameshot full --clipboard;<Ctrl>Print"
        "Clipboard History;copyq toggle;<Super>v"
        "Terminal;alacritty;<Super>Return"
    )

    # Loop through the custom shortcuts and add them
    new_bindings="["
    for index in "${!custom_shortcuts[@]}"; do
        IFS=';' read -r name command binding <<< "${custom_shortcuts[index]}"
        new_bindings+="'$base_path/custom$index/', "
    done

    # Remove the trailing comma and space, and close the list
    new_bindings="${new_bindings%, }]"

    echo "adding new bindings $new_bindings"
    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$new_bindings"

    for index in "${!custom_shortcuts[@]}"; do
        IFS=';' read -r name command binding <<< "${custom_shortcuts[index]}"
        add_custom_shortcut "$name" "$command" "$binding" "$index"
    done
}

add_custom_shortcut() {
    local name="$1"
    local command="$2"
    local binding="$3"
    local index="$4"

    local custom_keybinding_path="$base_path/custom$index/"

    echo "Setting shortcut [$index] $binding to $command $base_gsettings:$custom_keybinding_path"

    # Add the custom shortcut
    gsettings set $base_gsettings:$custom_keybinding_path name "$name"
    gsettings set $base_gsettings:$custom_keybinding_path command "$command"
    gsettings set $base_gsettings:$custom_keybinding_path binding "$binding"
}

setup_startup_apps() {
    local startup_apps=(
        "$HOME/.local/share/applications/whatsapp-for-linux_whatsapp-for-linux.desktop"
        "$HOME/.local/share/applications/telegram-desktop_telegram-desktop.desktop"
        "/usr/share/applications/com.github.hluk.copyq.desktop"
        '/usr/share/applications/librewolf.desktop'
    )

    if [ ! -d "$HOME/.config/autostart" ]; then
        mkdir -p "$HOME/.config/autostart"
    fi

    for index in "${!startup_apps[@]}"; do
        local app="${startup_apps[$index]}"
        echo -e "Adding app to startup: $app"
        local file_name=$(basename "$app")
        ln -sf "$app" "$HOME/.config/autostart/${file_name}"
    done
}

