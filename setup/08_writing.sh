#!/bin/bash

echo -e "${CYAN}Installing nice fonts${NC}"

FONTS_PACKAGES=(
    "ttf-font-awesome"
    "ttf-cascadia-code-nerd"
    "ttf-fira-code"
    "ttf-firacode-nerd"
    "ttf-hack"
    "ttf-jetbrains-mono"
    "noto-fonts"
    "noto-fonts-cjk"
    "noto-fonts-emoji"
    "noto-fonts-extra"
)

pacman -S --noconfirm --needed ${FONTS_PACKAGES[@]}

echo -e "${CYAN}Installing writing tools${NC}"

WRITING_TOOLS=(
    "qutebrowser"
    "pandoc"
    "python-weasyprint"

    "zathura"
    "zathura-pdf-mupdf"
    "okular"

    "texlive-basic"
    "texlive-latex"
    "texlive-latexrecommended"
    "texlive-binextra"
    "texlive-latexextra"
    "texlive-publishers"
    "texlive-fontsrecommended"
    "texlive-fontsextra"
    "texlive-langportuguese"
    "texlive-langenglish"
    "texlive-langspanish"

    "tesseract"
    "tesseract-data-eng"
    "tesseract-data-por"
    "unpaper"
)

pacman -S --noconfirm --needed ${WRITING_TOOLS[@]}

