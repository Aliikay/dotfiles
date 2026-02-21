#!/bin/sh

if pgrep [w]l-screenrec
then
    pkill wl-screenrec
    notify-send --icon=/home/alikay/dotfiles/icons/screen-record.png --expire-time=3000 --transient "Finished screen recording" "Recording was saved to ~/Videos/Screencasts"
else
    notify-send --icon=/home/alikay/dotfiles/icons/screen-record.png --expire-time=3000 --transient "Starting a screen recording" "Toggle with Meta+Ctrl+Shift+S"
    play -v 0.1 ~/Music/SFX/screen-record.wav
    wl-screenrec -g "$(slurp)" -f ~/Videos/Screencasts/$(date +'%s_vid.mp4')
fi
