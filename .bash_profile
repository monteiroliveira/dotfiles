#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

source $HOME/.local/bin/ssh_start --add

if [ $(tty) == /dev/tty1 ]; then
    exec startx
fi
