#!/bin/sh
line=$(ps aux | grep wl-screenrec)
if [ -z "$line" ]
then
    play -v 0.1 ~/Music/SFX/screen-record.wav
    pkill wl-screenrec
    notify-send "Finished screen recording"
else
    wl-screenrec -g "$(slurp)" -f ~/Videos/Screencasts/$(date +'%s_vid.mp4')
fi
