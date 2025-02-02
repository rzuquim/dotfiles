#!/bin/bash

is_installed() {
    package_name=$1
    package_check=$2

    case "$package_check" in
        apt)
            if dpkg -l "$package_name" 2>/dev/null | grep -q "^ii"; then
                return 0
            fi
            ;;
        snap)
            if snap list "$package_name" &>/dev/null; then
                return 0
            fi
            ;;
        cargo)
            if cargo install --list 2>/dev/null | grep "^$package_name" &>/dev/null; then
                return 0
            fi
            ;;
        npm)
            if npm list -g --depth=0 2>/dev/null | grep "$package_name" &>/dev/null; then
                return 0
            fi
            ;;
        custom)
            if [ "$package_name" = "nodejs" ] && command -v node >/dev/null 2>&1; then
                return 0
            elif [ "$package_name" = "oh-my-zsh" ] && [ -d "$HOME/.oh-my-zsh/" ]; then
                return 0
            elif [ "$package_name" = "luarocks" ] && command -v luarocks >/dev/null 2>&1; then
                return 0
            elif [ "$package_name" = "atuin" ] && command -v atuin >/dev/null 2>&1; then
                return 0
            elif [ "$package_name" = "kitty" ] && command -v kitty >/dev/null 2>&1; then
                return 0
            elif [ "$package_name" = "jetbrains-mono" ] && [ -f "$HOME/.local/share/fonts/JetBrainsMono-Regular.ttf" ]; then
                return 0
            elif [ "$package_name" = "hack-font" ] && [ -f "$HOME/.local/share/fonts/HackNerdFontMono-Regular.ttf" ]; then
                return 0
            elif [ "$package_name" = "android-studio" ] && [ -d "$HOME/.local/bin/android-studio" ]; then
                return 0
            elif [ "$package_name" = "devour" ] && [ -f "/usr/local/bin/devour" ]; then
                return 0
            else
                return 1
            fi
            ;;
        *)
            echo "Unknown package manager '$package_manager' for '$package_name'."
            ;;
    esac

    return 1
}

install_with_apt() {
    sudo apt install -y "$1"
}

install_with_snap() {
    case "$2" in
        classic)
            sudo snap install "$1" --classic
            ;;
        edge)
            sudo snap install "$1" --edge
            ;;
    esac
}

install_with_cargo() {
    cargo install "$1"
}

install_with_npm() {
    npm install -g "$1"
}

custom_install() {
    case "$1" in
        docker-ce)
            docker_install
            return 0
            ;;
        google-chrome-stable)
            chrome_install
            return 0
            ;;
        nodejs)
            nodejs_install
            return 0
            ;;
        zsh)
            zsh_install
            return 0
            ;;
        oh-my-zosh)
            omz_install
            return 0
            ;;
        rustup)
            rust_install
            return 0
            ;;
        copyq)
            copyq_install
            return 0
            ;;
        fonts-firacode)
            firacode_install
            return 0
            ;;
        jetbrains-mono)
            jetbrainsmono_install
            return 0
            ;;
        hack-font)
            hackfont_install
            return 0
            ;;
        android-studio)
            androidstudio_install
            return 0
            ;;
        devour)
            devour_install
            return 0
            ;;
        zoom)
            zoom_install
            return 0
            ;;
        klogg)
            klogg_install
            return 0
            ;;
        tmux)
            tmux_install
            return 0
            ;;
        luarocks)
            luarocks_install
            return 0
            ;;
        atuin)
            atuin_install
            return 0
            ;;
        kitty)
            kitty_install
            return 0
            ;;
        pandoc)
            pandoc_install
            return 0
            ;;
        flatpak)
            flatpak_install
            return 0
            ;;
        docker-ctop)
            ctop_install
            return 0
            ;;
    esac
    return 1
}

docker_install() {
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    sudo usermod -aG docker $USER
    newgrp docker
}

chrome_install() {
    wget https://dl-ssl.google.com/linux/linux_signing_key.pub -O /tmp/google.pub
    gpg --no-default-keyring --keyring /etc/apt/keyrings/google-chrome.gpg --import /tmp/google.pub
    echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
    sudo apt update -y
    sudo apt install -y google-chrome-stable
}

nodejs_install() {
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    source ~/.nvm/nvm.sh
    nvm install 18.12.1
    nvm alias default 18.12.1
    nvm use
    npm install -g neovim
}

zsh_install() {
    sudo apt install -y zsh

    echo "Setting GNOME Terminal to use Zsh..."

    PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d \')
    gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/Terminal/Legacy/Profiles:/:$PROFILE_ID/" use-custom-command true
    gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/Terminal/Legacy/Profiles:/:$PROFILE_ID/" custom-command 'zsh'
}

omz_install() {
    # BUG: not working
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

rust_install() {
    sudo snap install rustup --classic
    rustup default stable
}

copyq_install() {
    sudo add-apt-repository -y ppa:hluk/copyq
    sudo apt update -y
    sudo apt install -y copyq
}

firacode_install() {
    sudo apt install -y fonts-firacode
    FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip"
    FONT_DIR="$HOME/.local/share/fonts"

    mkdir -p "$FONT_DIR"

    wget "$FONT_URL" -O "$FONT_NAME.zip"
    unzip "$FONT_NAME.zip" -d "$FONT_DIR"

    mv "$FONT_NAME"/* "$FONT_DIR/"

    fc-cache -fv

    # Set the font in GNOME Terminal
    PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d \')
    gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/Terminal/Legacy/Profiles:/:$PROFILE/" font "Fira Code Nerd Font 12"
}

# from: https://askubuntu.com/questions/1271154/updating-zoom-in-the-terminal
zoom_install() {
    url=https://zoom.us/client/latest/zoom_amd64.deb
    debdir=/usr/local/zoomdebs
    aptconf=/etc/apt/apt.conf.d/100update_zoom
    sourcelist=/etc/apt/sources.list.d/zoomdebs.list

    sudo mkdir -p $debdir
    ( echo 'APT::Update::Pre-Invoke {"cd '$debdir' && wget -qN '$url' && apt-ftparchive packages . > Packages && apt-ftparchive release . > Release";};' | sudo tee $aptconf
        echo 'deb [trusted=yes lang=none] file:'$debdir' ./' | sudo tee $sourcelist
    ) >/dev/null

    sudo apt update
    sudo apt install -y zoom
}

klogg_install() {
    curl -sS https://klogg.filimonov.dev/klogg.gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/klogg.gpg &>/dev/null
    curl -sS https://klogg.filimonov.dev/deb/klogg.jammy.list | sudo tee /etc/apt/sources.list.d/klogg.list &>/dev/null

    sudo apt-get update
    sudo apt install -y klogg
}

tmux_install() {
    sudo apt install -y tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

luarocks_install() {
    sudo apt install build-essential libreadline-dev unzip
    mkdir ~/.rzuquim/tmp
    pushd ~/.rzuquim/tmp

    curl -L -R -O https://www.lua.org/ftp/lua-5.4.7.tar.gz
    tar zxf lua-5.4.7.tar.gz
    cd lua-5.4.7
    make all test
    sudo make install
    cd ..
    curl -R -O https://luarocks.github.io/luarocks/releases/luarocks-3.11.1.tar.gz
    tar zxf luarocks-3.11.1.tar.gz
    cd luarocks-3.11.1
    ./configure --with-lua-include=/usr/local/include
    make
    sudo make install
    popd
}

atuin_install() {
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
}

kitty_install() {
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
    mkdir ~/.local/bin
    ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
    cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
    cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
    sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
    sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
    echo 'kitty.desktop' > ~/.config/xdg-terminals.list
}


jetbrainsmono_install() {
    mkdir ~/.rzuquim/tmp
    pushd ~/.rzuquim/tmp

    wget https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip
    unzip JetBrainsMono-2.304.zip -d jetbrains-mono
    cd jetbrains-mono/fonts/ttf/

    mv JetBrainsMono-*.ttf ~/.local/share/fonts/
    popd
}

hackfont_install() {
    mkdir ~/.rzuquim/tmp
    pushd ~/.rzuquim/tmp

    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hack.zip
    unzip Hack.zip -d hack-font
    cd hack-font

    mv Hack*.ttf ~/.local/share/fonts/
    popd
}

pandoc_install() {
    mkdir ~/.rzuquim/tmp
    pushd ~/.rzuquim/tmp
    wget https://github.com/jgm/pandoc/releases/download/3.5/pandoc-3.5-1-amd64.deb
    sudo dpkg -i pandoc-3.5-1-amd64.deb
    sudo apt install texlive-xetex
    popd
}

flatpak_install() {
    sudo apt install flatpak
    sudo apt install gnome-software-plugin-flatpak
    sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
}

ctop_install() {
    sudo apt-get install ca-certificates curl gnupg lsb-release
    curl https://azlux.fr/repo.gpg | sudo apt-key add -
    sudo apt-add-repository deb http://packages.azlux.fr/debian stable main
    sudo apt-get update
    sudo apt-get install docker-ctop
}

androidstudio_install() {
    # docs: https://developer.android.com/studio/install#64bit-libs
    sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
    wget \
        https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2024.2.1.12/android-studio-2024.2.1.12-linux.tar.gz \
        -O /tmp/android-studio.tar.gz
    mkdir -p "$HOME/.local/bin/android-studio"
    tar zxf /tmp/android-studio.tar.gz --directory="$HOME/.local/bin/"
    bash "$HOME/.local/bin/android-studio/bin/studio.sh"
    ln -s $HOME/.local/bin/android-studio/bin/studio $HOME/.local/bin/androidstudio
}

devour_install() {
    if [ ! -d ~/.devour ]; then
        mkdir -p ~/.devour
        git clone https://github.com/salman-abedin/devour.git ~/.devour
    fi

    pushd ~/.devour
    sudo make install
    popd
}
