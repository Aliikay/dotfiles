#!/bin/sh

if ! pgrep -u "$(whoami)" swayosd-server
then
    swayosd-server & disown
    sleep 1
fi

swayosd-client "$@"
