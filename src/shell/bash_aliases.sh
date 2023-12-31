#!/bin/bash

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cd..="cd .."

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

alias cp="cp -iv"
#             │└─ list copied files
#             └─ prompt before overwriting an existing file

alias mkdir="mkdir -pv"
#                   │└─ list created directories
#                   └─ create intermediate directories

alias mv="mv -iv"
#             │└─ list moved files
#             └─ prompt before overwriting an existing file

alias rm="rm -rf --"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

alias :q="exit"
alias c="clear"
alias checkHis="history -c && > ~/.bash_history"
alias d="cd ~/Desktop"
#alias e="vim --"
alias g="git"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ll="ls -l"
alias m="man"
alias map="xargs -n1"
alias p="cd ~/proxies"
alias path='printf "%b\n" "${PATH//:/\\n}"'
alias q="exit"
alias t="tmux"
alias y="yarn"



# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Load OS specific configs.

# shellcheck source=/dev/null
. "$OS/bash_aliases"
