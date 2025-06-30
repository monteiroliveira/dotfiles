xsetroot -cursor_name left_ptr
setxkbmap -option ctrl:nocaps
xset s off -dpms
[[ -f $HOME/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
exec xmonad
