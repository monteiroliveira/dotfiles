#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export QT_QPA_PLATFORMTHEME=qt6ct

[ -f $HOME/.local/bin/sshagt ] && . $HOME/.local/bin/sshagt --add

if [ $(tty) == /dev/tty1 ]; then
    exec startx
fi
