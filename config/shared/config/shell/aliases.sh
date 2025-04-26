#!/bin/bash

# ---------------------
# aliases
# ---------------------
alias q='exit'
alias c='clear'
alias h='history'
alias mkdir='mkdir -p'
alias ls='eza -la --group-directories-first --time-style=long-iso --no-user --no-permissions'
alias diff='delta'
alias vi='nvim'
alias vim='nvim'
alias nv='nvim'
alias null='/dev/null'
alias grep='rg --color=auto'
alias cat='bat'
alias clip='wl-copy'
alias home='cd ~'
alias root='cd /'
alias tree='tree --dirsfirst'
alias tree_f='fd | tree --fromfile'
alias tree_d='fd --type d | tree --fromfile'
alias o=xdg-open
alias ..='cd ..'
alias ...='cd ..; cd ..'
alias ....='cd ..; cd ..; cd ..'

# navigation
alias w=work
alias we=work_and_editor
alias wt=work_on_tmux_session
alias n=fd_and_navigate
alias b=back_to_folder

# git
alias g=git
alias gui=gitui

# dotnet
alias dn=dotnet
alias dnb='dotnet build'
alias dnr='dotnet run -v q --property WarningLevel=0'

# docker
alias d=docker
alias dit=docker_interactive

