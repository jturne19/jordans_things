#!/bin/sh

xrdb -merge /home/jordan/.Xresources

feh --bg-scale /home/jordan/Pictures/wallpapers/beach-border-light.png &
urxvtd -q -f -o &

xset +fp /home/jordan/.fonts/tewi-font/out
xset +fp /home/jordan/.fonts/ &
xset fp rehash

redshift -c /home/jordan/.config/redshift.conf &
compton -cCGfF -o 0.38 -O 200 -I 200 -t 0 -l 0 -r 3 -D2 -m 0.88 -b &

exec spectrwm
