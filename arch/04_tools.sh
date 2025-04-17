#!/bin/bash

if [[ -n "$ARCH_INTERACTIVE" ]]; then
    # code to check if the basic config should be applied
    read -p "Install tools? [y/N] " response

    response=${response:-N}
    if [[ $response =~ ^[Nn]$ ]]; then
        ARCH_NO_TOOLS=true
    fi
fi

if [[ -z "$ARCH_NO_TOOLS" ]]; then
    BASIC_PACKAGES=(
        "git"
        "curl"
        "7zip"
        "zip"
        "unzip"
        "unrar"
        "dos2unix"
        "base-devel"
        "which"
        "fd"
        "fzf"
        "eza"
        "ripgrep"
        "tldr"
        "tree"
        "btop"
        "ncdu"
        "openvpn"
        "bat"
        "wget"
        "rsync"
    )

    echo -e "${CYAN}Installing basic tools:${NC} ${BASIC_PACKAGES[@]}"
    pacman -S --noconfirm --needed ${BASIC_PACKAGES[@]}

    DEV_PACKAGES=(
        "nvim"
        "rustup"
        "nvm"
        "gitui"
        "python"
        "dotnet-sdk"
        "lua"
        "luarocks"
        "cmake"
        "go"
    )

    echo -e "${CYAN}Installing dev tools:${NC} ${DEV_PACKAGES[@]}"
    pacman -S --noconfirm --needed ${DEV_PACKAGES[@]}

    TERMINAL_PACKAGES=(
        "alacritty"
        "zsh"
        "starship"
        "tmux"
    )

    echo -e "${CYAN}Installing dev tools:${NC} ${TERMINAL_PACKAGES[@]}"
    pacman -S --noconfirm --needed ${TERMINAL_PACKAGES[@]}

    FONTS_PACKAGES=(
        "ttf-font-awesome"
        "ttf-cascadia-code-nerd"
        "ttf-fira-code"
        "ttf-hack"
        "ttf-jetbrains-mono"
    )

    echo -e "${CYAN}Installing fonts:${NC} ${FONTS_PACKAGES[@]}"
    pacman -S --noconfirm --needed ${FONTS_PACKAGES[@]}

    echo -e "${CYAN}Installing AUR helper:${NC} paru"
    if ! command -v paru >/dev/null 2>&1; then
        if [ -d /tmp/paru ]; then
            rm -rf /tmp/paru
        fi

        # NOTE: the build must happen on a non root user, but we need to pacman -U using the root
        #       the makepkg will fail since we are not on a interactive session
        su - me -c \
            "rustup default stable && \
            git clone --depth 1 https://aur.archlinux.org/paru.git /tmp/paru && \
            cd /tmp/paru && makepkg -si"

        paru_pkg=$(ls /tmp/paru/*.zst | grep -v debug)
        if [ -z "$paru_pkg" ]; then
            echo -e "${RED}Could not find paru package build.${NC}"
            exit 1
        fi

        pacman --noconfirm --needed -U "$paru_pkg"
    fi

    # FIX: not working
    #
    # BROWSER_DEPENDENCIES=(
    #     "pipewire-jack"
    #     "gnu-free-fonts"
    # )
    #
    # BROWSER_PACKAGES=(
    #     "xwayland-run-git"
    #     "librewolf-bin"
    #     "brave-bin"
    # )
    #
    # echo -e "${CYAN}Installing browsers:${NC} ${BROWSER_PACKAGES[@]}"
    # pacman -Sy --noconfirm --needed ${BROWSER_DEPENDENCIES[@]}
    # su - me -c "paru -Sy --noconfirm --needed --sudo true ${BROWSER_PACKAGES[@]}"
fi
