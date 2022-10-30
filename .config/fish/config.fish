set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/.cargo/bin $HOME/.emacs.d/bin $fish_user_paths

source /opt/asdf-vm/asdf.fish

set fish_greeting
set fish_vi_key_bindings
set TERM 'xterm-256color'
set EDITOR 'vim'

alias ls='exa --icons'
alias cat='bat --style=auto'
alias df='lfs'
alias dotfile='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'

function fish_greeting
    if test (random 1 10) -gt 5
       pokemon-colorscripts -r
    else
        colorscript random
    end
end
