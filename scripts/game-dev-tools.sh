#!/bin/sh

unityhub & disown
mullvad split-tunnel add $!

code & disown
#mullvad split-tunnel add $!

flatpak run com.gitfiend.GitFiend & disown
#mullvad split-tunnel add $!
