set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/.cargo/bin $HOME/.emacs.d/bin $HOME/.cabal/bin $HOME/.local/bin $fish_user_paths

if status --is-login
   if [ $(tty) = /dev/tty1 ] ;
      exec startx
   end
end

source $HOME/.local/bin/fish_ssh_agent.fish
source /opt/asdf-vm/asdf.fish

starship init fish | source

set fish_greeting
set TERM 'xterm-256color'
set EDITOR 'emacs'

set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan
set fish_color_quote '#dfdfdf' --bold

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
