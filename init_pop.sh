#!/bin/bash

DOTFILES_REPO=git@github.com:rzuquim/dotfiles.git

# ---------------------------------
# COLORS
# ---------------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN="\e[38;2;173;216;230m"
INDIGO="\e[38;2;75;0;130m"
VIOLET="\e[38;2;238;130;238m"
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

if [ ! -t 0 ]; then
    echo "Please run this script interactively."
    echo ". <(curl -sL https://raw.githubusercontent.com/rzuquim/dotfiles/master/init_pop.sh)"
    exit 1
fi

if [[ -z "${WORKSPACE}" ]]; then
    WORKSPACE=~/.rzuquim
fi

# ---------------------------------
# UTILS
# ---------------------------------
source "./utils/setup_whoiam.sh"
source "./utils/colors.sh"

# ---------------------------------
# SETUP
# ---------------------------------
source "./pop/install.sh"
source "./pop/config.sh"

