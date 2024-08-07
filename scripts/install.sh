#!/bin/sh

#echo "Changing channel to unstable..."
#nix-channel --add https://nixos.org/channels/nixos-unstable nixos
#nix-channel --update

echo "Getting a new nix shell with the needed components for github auth..."
nix-shell -p gh --command "gh auth login"

echo "Cloning repo w/ git..."
nix-shell -p git --command "git clone git@github.com:Aliikay/dotfiles.git ~/dotfiles"

echo "Please add the following to your configuration.nix: 
nix.settings = {
    substituters = [\"https://hyprland.cachix.org\"];
    trusted-public-keys = [\"hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=\"];
};
nix.settings.experimental-features = [ \"nix-command\" \"flakes\" ];
services.thermald.enable = true;
"
read -p "Press enter to continue"
sudo nano /etc/nixos/configuration.nix

echo "Please transfer any LUKS encryption stuff from the generated configuration.nix to the new one. First the generated config file will open, and then the new one will be opened."
read -p "Press enter to open the generated configuration.nix"
sudo nano /etc/nixos/configuration.nix
read -p "Press enter to open the new configuration.nix"
sudo nano ~/dotfiles/nixos/configuration.nix

echo "Copy the current hardware config to the dotfiles"
rm ~/dotfiles/nixos/hardware-configuration.nix
cp -r /etc/nixos/hardware-configuration.nix ~/dotfiles/nixos/hardware-configuration.nix

echo "Rebuilding & updating the system with substituters enabled"
sudo nixos-rebuild switch --upgrade

echo "Building the new system..."
nix-shell -I nixpkgs=channel:nixos-unstable -p nh git --command "~/dotfiles/scripts/rebuild.sh"

