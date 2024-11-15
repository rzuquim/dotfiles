#!/bin/bash

# If you come from bash you might have to change your $PATH. export VISUAL=nvim
export EDITOR="$VISUAL"
export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$HOME/.cargo/bin:$HOME/.dotnet/bin:$PATH:$HOME/.local/share/flatpak/exports/bin/
export BROWSER="google-chrome"

# History
export HISTFILE=~/.config/.zsh_history
export HISTSIZE=100
export SAVEHIST=1000
export HISTCONTROL=ignoreboth # ignoring history duplicate

# clipboard config
export CM_SELECTIONS="clipboard"
export CM_DEBUG=0
export CM_OUT_CLIP=0
export CM_MAX_CLIPS=100

