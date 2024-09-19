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
        'alacritty'
        'google-chrome'
        'rider_rider'
        'code_code'
        'telegram-desktop_telegram-desktop'
        'teams-for-linux_teams-for-linux'
        'Zoom'
        'remmina_remmina'
        'org.gnome.Nautilus'
        'pop-cosmic-workspaces'
        'pop-cosmic-applications'
        'gnome-control-center'
    )

    docks_app_join="["
    for app in "${DOCK_APPS[@]}"; do
        docks_app_join+="'${app}.desktop',"
    done
    docks_app_join="${docks_app_join%,}]"

    echo "Setting docks as: $docks_app_join"

    gsettings set org.gnome.shell favorite-apps "$docks_app_join"
}
