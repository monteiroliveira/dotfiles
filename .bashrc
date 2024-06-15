#
# ~/.bashrc
#

export TERM="xterm-256color"
export EDITOR="nvim"
export HISTCONTROL=ignoredups:erasedups

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS1='[\u@\h \W]\$ '

set -o vi

alias vim="nvim"
alias ls="eza --icons"
alias cat="bat --style=auto"
alias grep="grep --color=auto"
alias ..="cd .."
alias dot="/usr/bin/git --git-dir=$HOME/.dot --work-tree=$HOME"

shopt -s autocd
shopt -s cmdhist
shopt -s histappend

bind "set completion-ignore-case on"

eval "$(starship init bash)"
