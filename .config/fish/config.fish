set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/.cargo/bin $HOME/.emacs.d/bin $HOME/.local/bin $fish_user_paths

if status --is-login
	if [ $(tty) = /dev/tty1 ] ;
       exec startx
	end
end

source $HOME/scripts/fish_ssh_agent.fish
source /opt/asdf-vm/asdf.fish

starship init fish | source

set fish_greeting
set fish_vi_key_bindings
set TERM 'xterm-256color'
set EDITOR 'emacs'

alias ls='exa --icons'
alias cat='bat --style=auto'
alias df='lfs'
alias sysup='sudo pacman -Syyuu'
alias dots='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'

function fish_greeting
    if test (random 1 10) -gt 5
       pokemon-colorscripts -r
    else
        colorscript random
    end
end
