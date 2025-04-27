#!/bin/sh

bindkey -v                                      # vim mode on zsh
bindkey -s '^a' ' fg^M'                         # running fg
bindkey '^[[A' history-substring-search-up      # Up
bindkey '^[[B' history-substring-search-down    # Down
bindkey "^[[1;5C" forward-word                  # <C-Right>
bindkey "^[[1;5D" backward-word                 # <C-Left>
bindkey  "^[[H"   beginning-of-line             # Home
bindkey  "^[[F"   end-of-line                   # End
