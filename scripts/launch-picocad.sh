#!/bin/sh
Xwayland :10 &
sleep 1
DISPLAY=:10 env -u WAYLAND_DISPLAY openbox --startup "bash -c '/home/alikay/Applications/PicoCAD/picocad-102/picocad-102.bin/linux/picocad & thunar'" &
