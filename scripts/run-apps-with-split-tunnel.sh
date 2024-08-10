#!/bin/sh
flatpak run dev.vencord.Vesktop --disable-features=VaapiVideoDecodeLinuxGL,VaapiVideoDecoder & disown
mullvad split-tunnel add $!

steam %U -nochatui -nofriendsui -silent & disown
mullvad split-tunnel add $!

heroic & disown
mullvad split-tunnel add $!
