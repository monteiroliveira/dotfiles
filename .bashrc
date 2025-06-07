#
# ~/.bashrc
#

export TERM="xterm-256color"
export EDITOR="emacs -nw"
export HISTCONTROL=ignoredups
export PATH="$HOME/.local/bin:$PATH"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS1='[\u@\h \W]\$ '

set -o emacs

alias vim="nvim"
[ -z $(which emacs) ] && alias emacs="emacs &"
[ -z $(which emacs) ] && alias tmacs="emacs -nw"
alias ls="eza --icons"
alias cat="bat --style=auto"
alias grep="grep --color=auto"
alias ..="cd .."
alias pac="sudo pacman"
alias orca="WEBKIT_FORCE_COMPOSITING_MODE=1 WEBKIT_DISABLE_COMPOSITING_MODE=1 WEBKIT_DISABLE_DMABUF_RENDERER=1 orca-slicer"

shopt -s autocd
shopt -s cmdhist
shopt -s histappend

bind "set completion-ignore-case on"

eval "$(starship init bash)"
