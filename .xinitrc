[[ -f $HOME/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
xsetroot -cursor_name left_ptr
setxkbmap -option ctrl:nocaps
xset s off -dpms


exec startxfce4

# exec xmonad
