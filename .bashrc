#
# ~/.bashrc
#

export TERM="xterm-256color"
export EDITOR="emacs -nw"
export VISUAL="emacs"
export HISTCONTROL=ignoredups

set -o emacs

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
[[ -f /etc/bashrc ]] && . /etc/bashrc

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

## ASDF
if ! [[ "$PATH" =~ "${ASDF_DATA_DIR:-$HOME/.asdf}/shims:" ]]; then
    PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fi

# Golang local packages (like asdf)
if ! [[ "$PATH" =~ "${GOPATH:-$HOME/go}/bin:" ]]; then
    PATH="${GOPATH:-$HOME/go}/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

[ -z "$XDG_CONFIG_HOME" ] && \
    export XDG_CONFIG_HOME="$HOME/.config"

[ -z "$XDG_DATA_HOME" ] && \
    export XDG_DATA_HOME="$HOME/.local/share"

[ -z "$XDG_CACHE_HOME" ] && \
    export XDG_CACHE_HOME="$HOME/.cache"

command -v nvim > /dev/null 2>&1 && alias vim="command nvim"
if command -v emacs > /dev/null 2>&1; then
    alias tmacs="command emacs -nw"
    emacs() {
        command emacs "$@" & 
    }
    alias em="emacs"   
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
bind '"\C-l":"clear\n"'
bind '"\C-g":"tmuxpm\n"'
bind '"\C-h":"tmuxsm\n"'

command -v asdf > /dev/null 2>&1 && . <(asdf completion bash)
command -v fzf > /dev/null 2>&1 && eval "$(fzf --bash)"
# CTRL-t = fzf select
# CTRL-r = fzf history
# ALT-c  = fzf cd

