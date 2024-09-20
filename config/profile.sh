# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

setxkbmap -option caps:escape

export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$HOME/.cargo/bin:$HOME/.dotnet/bin:$PATH

export NVM_DIR=~/.nvm
source "$NVM_DIR/nvm.sh"

# reseting .context on every boot
if [[ -f "$HOME/.context" ]]; then
    rm ~/.context
fi

