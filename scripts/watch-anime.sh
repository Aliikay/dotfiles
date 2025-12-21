#!/bin/sh
trackma-gtk & disown
alacritty -e fish -C "ani-cli --help"
