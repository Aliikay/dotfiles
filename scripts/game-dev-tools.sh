#!/bin/sh

xwayland-run.sh ~/Unity/Hub/Editor/6000.0.65f1/Editor/Unity -projectPath ~/Documents/Unity/UntitledBubbleGame/Slipstream -force-vulkan -force-gfx-mt & disown
mullvad split-tunnel add $!

# The clone
~/Unity/Hub/Editor/6000.0.65f1/Editor/Unity -projectPath ~/Documents/Unity/UntitledBubbleGame/Slipstream_clone_0 -force-vulkan -force-gfx-mt & disown
mullvad split-tunnel add $!

steam %U -nochatui -nofriendsui -silent & disown
mullvad split-tunnel add $!

code & disown
#mullvad split-tunnel add $!

#flatpak run com.gitfiend.GitFiend & disown
alacritty --working-directory ~/Documents/Unity/UntitledBubbleGame/ -T lazygit -e lazygit & disown
#mullvad split-tunnel add $!

# Open obsidian
flatpak run md.obsidian.Obsidian & disown

# Open github issues
firefox --new-window https://github.com/Daisy-Chain-Games-Inc/Slipstream/issues
