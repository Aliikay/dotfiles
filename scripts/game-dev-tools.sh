#!/bin/sh

#unityhub & disown
Unity/Hub/Editor/6000.0.37f1/Editor/Unity -projectPath ~/Documents/Unity/UntitledBubbleGame/Slipstream -force-vulkan -force-gfx-mt & disown
mullvad split-tunnel add $!

code & disown
#mullvad split-tunnel add $!

flatpak run com.gitfiend.GitFiend & disown
#mullvad split-tunnel add $!
