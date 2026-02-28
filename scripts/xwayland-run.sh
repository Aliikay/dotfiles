#!/bin/sh

STARTUP_COMMAND="bash -c \"$@\""

Xwayland :10 &
sleep 2
echo "Running the following as as argument to openbox: $STARTUP_COMMAND"
DISPLAY=:10 env -u WAYLAND_DISPLAY openbox --startup "$STARTUP_COMMAND" &
