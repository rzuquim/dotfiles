#!/bin/bash

source "./pop/install_setup.sh"

# NOTE: some of those packages need to be installed in this order

BASIC_PACKAGES=(
    # tools
    "git | apt"
    "tmux | custom | apt"
    "snapd | apt"
    "flatpak | custom | apt"
    "rustup | custom | snap"
    "nodejs | custom"
    "python3 | apt"
    "python3-pip | apt"
    "python3.10-venv | apt"
    "dotnet-sdk-8.0 | apt"
    "curl | apt"
    "dos2unix | apt"
    "build-essential | apt"
    "ca-certificates | apt"
    "flameshot | apt"
    "obsidian | snap"
    "p7zip-full | apt"
    "p7zip-rar | apt"
    "cmake | apt"
    "wkhtmltopdf | apt"
    "pkg-config | apt"
    "libfreetype6-dev | apt"
    "libfontconfig1-dev | apt"
    "libxcb-xfixes0-dev | apt"
    "libxkbcommon-dev | apt"
    "copyq | custom | apt"
    "zoom | custom | apt"
    "atuin | custom"
    "pandoc | custom | apt"

    # monitoring
    "btop | apt"
    "docker-ctop | custom | apt"

    # browser
    "google-chrome-stable | custom | apt"
    "librewolf | apt"

    # communications
    "easy-rsa | apt"
    "openvpn | apt"
    "remmina | snap"
    "telegram-desktop | snap"
    "whatsapp-for-linux | snap" # FIX: https://github.com/eneshecan/whatsapp-for-linux/issues/131#issuecomment-906992739

    # media
    # "flatpak install flathub org.qbittorrent.qBittorrent --user -y | flatpak"
    # "flatpak install flathub io.mpv.Mpv --user -y | flatpak"
    "presenterm | cargo"
    # "presenterm-export | pip"

    # terminal
    "zsh | custom | apt"
    "oh-my-zsh | custom"
    "starship | cargo"
    "fonts-firacode | custom | apt"
    "jetbrains-mono | custom"
    "hack-font | custom"
    "gitui | cargo"
    "alacritty | cargo"
    "kitty | custom"
    "eza | cargo"
    "ripgrep | apt"
    "bat | apt"
    "fd-find | cargo"
    "fzf | apt"
    "tlrc | cargo"
    "tree | apt"
    "xclip | apt"
    "git-delta | cargo"

    # editors
    "nvim | snap"
    "neovide | cargo"
    "code | snap"
    "rider | snap"

    # gnome
    # TODO: setup and configure the extensions I use:
    #       - https://extensions.gnome.org/extension/517/caffeine/
    #       - https://extensions.gnome.org/extension/1160/dash-to-panel/
    #       - https://extensions.gnome.org/extension/1460/vitals/
    #       - https://extensions.gnome.org/extension/16/auto-move-windows/
    #       - disable: Cosmic Dock
    #
    # TODO: "Settings > Desktop > Dock > Uncheck Enable Dock" (to make dash-to-panel work after a reboot)
    # TODO: Set extension configs
    "chrome-gnome-shell | apt"

    # devtools
    "docker-ce | custom | apt"
    "prettier | npm"
    "commitizen@4.2.2 | npm"
    "coffeescript@1.12.6 | npm"
    "typescript@4.4 | npm"
    "klogg | custom | apt"
    "luarocks | custom"
    "android-studio | custom" # NOTE: leaving the interactive installers last
)

echo
echo -e "${CYAN}* Installing apps${NC}"
echo "We are going to install the following apps:"

TO_INSTALL=()
for package in "${BASIC_PACKAGES[@]}"; do
    package_name=$(echo "$package" | cut -d '|' -f 1 | xargs)
    package_manager=$(echo "$package" | cut -d '|' -f 2 | xargs)
    package_check=$(echo "$package" | cut -d '|' -f 3 | xargs)
    package_check=${package_check:-${package_manager}}

    if is_installed "$package_name" "$package_check"; then
        echo -e "  - $package_name ${GREEN}(Already installed)${NC}"
    else
        echo -e "  - $package_name"
        TO_INSTALL+=("$package_name | $package_manager")
    fi
done

read -p "Install missing apps? [Y/n] " response
response=${response:-Y}

if [[ $response =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}OK! LET's GO!${NC}"
else
    echo -e "${RED}Comment out what you don't want and run the script later.${NC}"
    return
fi

sudo apt update -y
sudo apt upgrade

for package in "${TO_INSTALL[@]}"; do
    package_name=$(echo "$package" | cut -d '|' -f 1 | xargs)
    package_manager=$(echo "$package" | cut -d '|' -f 2 | xargs)

    echo "Installing $package_name with $package_manager..."

    if custom_install "$package_name" "$package_manager"; then
        continue
    fi

    case "$package_manager" in
        apt)
            install_with_apt "$package_name"
            ;;
        snap)
            install_with_snap "$package_name" "classic"
            ;;
        snap-edge)
            install_with_snap "$package_name" "edge"
            ;;
        cargo)
            install_with_cargo "$package_name"
            ;;
        npm)
            install_with_npm "$package_name"
            ;;
        *)
            echo "Unknown package manager '$package_manager' for '$package_name'."
            ;;
    esac
done

