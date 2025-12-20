#!/bin/sh
trackma-gtk & disown
alacritty -e "ani-cli --help ; fish"
