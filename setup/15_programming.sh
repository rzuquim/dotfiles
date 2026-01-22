#!/bin/bash

DEV_PACKAGES=(
    "nvim"
    "rustup"
    "nodejs"
    "npm"
    "typescript-language-server"
    "nvm"
    "gitui"
    "python"
    "dotnet-sdk"
    "lua"
    "luarocks"
    "cmake"
    "go"
    "jq"
    "vulkan-tools"
    "docker"
    "docker-compose"
    "docker-buildx"
    "clang"
    "llvm"
    "virtualbox"
)

echo -e "${CYAN}Installing dev tools:${NC} ${DEV_PACKAGES[@]}"
pacman -S --noconfirm --needed ${DEV_PACKAGES[@]}

TAURI_DEPS=(
    "webkit2gtk-4.1"
    "base-devel"
    "curl"
    "wget"
    "file"
    "openssl"
    "appmenu-gtk-module"
    "libappindicator-gtk3"
    "librsvg"
    "xdotool"
)

echo -e "${CYAN}Installing tauri dependencies:${NC} ${TAURI_DEPS[@]}"
pacman -S --noconfirm --needed ${TAURI_DEPS[@]}

# NOTE: Check if github.com is already in known_hosts
if [ ! -d "/home/me/.ssh" ]; then
    su - me -c "mkdir /home/me/.ssh"
fi

KNOWN_HOSTS_FILE=/home/me/.ssh/known_hosts
if [ ! -f "$KNOWN_HOSTS_FILE" ] || ! grep -q "^github.com " "$KNOWN_HOSTS_FILE"; then
    echo -e "${YELLOW}Adding github.com to known_hosts${NC}"
    su - me -c "ssh-keyscan github.com >> $KNOWN_HOSTS_FILE"
fi

if [ ! -d "/home/me/.config/git" ]; then
    su - me -c "mkdir /home/me/.config/git"
fi

if [ ! -f $GIT_WHO_AM_I  ]; then
    echo -e "${YELLOW}Setting up git whoami${NC}"

    echo '[user]' > $GIT_WHO_AM_I
    echo "email = $MY_EMAIL" >> $GIT_WHO_AM_I
    echo "name = $MY_NAME" >> $GIT_WHO_AM_I
fi

if [ ! -d "/home/me/.config" ]; then
    su - me -c "mkdir /home/me/.config"
fi

if ! rustup show active-toolchain; then
    echo -e "${YELLOW}Setting up default rust tollchain as${NC} stable"
fi

systemctl enable docker

