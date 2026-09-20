#!/bin/sh

sleep 3

#flatpak run dev.vencord.Vesktop --disable-features=VaapiVideoDecodeLinuxGL,VaapiVideoDecoder & disown
mullvad-exclude vesktop --disable-features=VaapiVideoDecodeLinuxGL,VaapiVideoDecoder & disown
# mullvad split-tunnel add $!

mullvad-exclude steam %U -nochatui -nofriendsui -silent & disown
# mullvad split-tunnel add $!

heroic & disown
mullvad split-tunnel add $!
