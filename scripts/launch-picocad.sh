#!/bin/sh
Xwayland :10 &
sleep 3 &
DISPLAY=:10 env -u WAYLAND_DISPLAY openbox --startup /home/alikay/Applications/PicoCAD/picocad-102/picocad-102.bin/linux/picocad
