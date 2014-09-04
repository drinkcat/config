#!/bin/bash

xrandr --newmode  "1600x900_60.00"  118.25  1600 1696 1856 2112  900 903 908 934 -hsync +vsync
xrandr --addmode eDP1 1600x900_60.00

setxkbmap -layout us,us_intl -option grp:shifts_toggle

xinput set-prop "SynPS/2 Synaptics TouchPad" "Synaptics Soft Button Areas" 4000 0 4063 0 3000 4000 4063 0
synclient HorizTwoFingerScroll=1
synclient TapAndDragGesture=0

xrdb -merge /home/nicolas/.Xresources

xrandr --dpi 235
xrandr --fbmm 346x194

xrdb .Xresources

pulseaudio --start

conky &

xautolock -time 5 -locker 'i3lock -c 000080' &

pidgin &

exec i3
