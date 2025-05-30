#!/bin/bash

echo -e "${CYAN}Installing nice fonts${NC}"

FONTS_PACKAGES=(
    "ttf-font-awesome"
    "ttf-cascadia-code-nerd"
    "ttf-fira-code"
    "ttf-firacode-nerd"
    "ttf-hack"
    "ttf-jetbrains-mono"
    "noto-fonts-emoji"
)

echo -e "${CYAN}Installing writing tools${NC}"

WRITING_TOOLS=(
    "qutebrowser"
    "pandoc"
    "python-weasyprint"
    "zathura"
    "zathura-pdf-poppler"
)

pacman -S --noconfirm --needed ${WRITING_TOOLS[@]}

