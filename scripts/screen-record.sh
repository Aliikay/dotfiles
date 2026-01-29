#!/bin/sh
aplay ~/Music/SFX/screen-record.wav && pkill wl-screenrec || wl-screenrec -g "$(slurp)" -f ~/Videos/Screencasts/$(date +'%s_vid.mp4')
