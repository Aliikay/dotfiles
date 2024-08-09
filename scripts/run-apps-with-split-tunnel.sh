#!/bin/bash
flatpak run dev.vencord.Vesktop --disable-features=VaapiVideoDecodeLinuxGL,VaapiVideoDecoder & disown
mullvad split-tunnel add $!

/usr/bin/steam-runtime %U -nochatui -nofriendsui -silent & disown
mullvad split-tunnel add $!

flatpak run com.heroicgameslauncher.hgl & disown
mullvad split-tunnel add $!
