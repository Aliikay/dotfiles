#!/bin/sh

swayidle -w \
    before-sleep swaylock \
    timeout 1140 'notify-send --transient "Idle Screen Lock" "Locking the screen in 1 minute!"' \
        resume 'notify-send --transient "Idle Screen Lock" "Cancelled screen lock"' \
    timeout 1200 'niri msg action power-off-monitors && swaylock'
