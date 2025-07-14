#
# ~/.bashrc
#

export TERM="xterm-256color"
export EDITOR="emacs -nw"
export VISUAL="emacs"
export HISTCONTROL=ignoredups
export PATH="$HOME/.local/bin:$PATH"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS1='[\u@\h \W]\$ '

set -o emacs

[ -z "$XDG_CONFIG_HOME" ] && \
    export XDG_CONFIG_HOME="$HOME/.config"

[ -z "$XDG_DATA_HOME" ] && \
    export XDG_DATA_HOME="$HOME/.local/share"

[ -z "$XDG_CACHE_HOME" ] && \
    export XDG_CACHE_HOME="$HOME/.cache"

export XMONAD_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/xmonad"
export XMONAD_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/xmonad"
export XMONAD_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/xmonad"

which nvim > /dev/null 2>&1 && alias vim="$(which nvim)"
if which emacs > /dev/null 2>&1; then
    alias tmacs="$(which emacs) -nw"
    alias em="tmacs"
    alias emacs="$(which emacs) &"
fi
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias ..="cd .."
alias pac="sudo pacman"

alias orca="WEBKIT_FORCE_COMPOSITING_MODE=1 WEBKIT_DISABLE_COMPOSITING_MODE=1 WEBKIT_DISABLE_DMABUF_RENDERER=1 orca-slicer"
alias myt-dlp="yt-dlp -f bestaudio -x --embed-metadata --embed-thumbnail"

shopt -s autocd
shopt -s cdspell
shopt -s cmdhist
shopt -s histappend
shopt -s expand_aliases
shopt -s checkwinsize

bind "set completion-ignore-case on"

which starship > /dev/null 2>&1 && eval "$(starship init bash)"
which fzf > /dev/null 2>&1 && eval "$(fzf --bash)"
# CTRL-t = fzf select
# CTRL-r = fzf history
# ALT-c  = fzf cd
