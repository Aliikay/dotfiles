#!/bin/sh

# Open work browser
flatpak run app.zen_browser.zen -P Work & disown
mullvad split-tunnel add $!

# Open application spreadsheet
libreoffice /home/alikay/Documents/Notes/Personal\ Notes/Work/Sent\ Applications.ods & disown

# Open obsidian
flatpak run md.obsidian.Obsidian & disown

# Open file browser
nautilus /home/alikay/Documents/Notes/Personal\ Notes/Work & disown

# Open file browser
nautilus /home/alikay/Documents/CV & disown

# Open git
alacritty --working-directory ~/Documents/CV -c lazygit

# Open resume
setzer & disown
