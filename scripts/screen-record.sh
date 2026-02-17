#!/bin/sh

if pgrep [w]l-screenrec
then
    pkill wl-screenrec
    notify-send "Finished screen recording" "Recording was saved to ~/Videos/Screencasts"
else
    notify-send --expire-time=2000 "Starting a screen recording" "Recording will be saved to ~/Videos/Screencasts"
    play -v 0.1 ~/Music/SFX/screen-record.wav
    wl-screenrec -g "$(slurp)" -f ~/Videos/Screencasts/$(date +'%s_vid.mp4')
fi
