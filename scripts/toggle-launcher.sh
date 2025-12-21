#!/bin/sh
#pgrep .wofi-wrapped >/dev/null 2>&1 && killall .wofi-wrapped || wofi --show drun --location=top -y 15
pgrep fuzzel >/dev/null 2>&1 && killall fuzzel || fuzzel
