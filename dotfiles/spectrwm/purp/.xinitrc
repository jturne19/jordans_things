#!/bin/sh

xrdb -merge /home/jordan/.Xresources &

/home/jordan/.fehbg &

urxvtd -q -f -o &

compton -b &

dunst &

exec spectrwm
