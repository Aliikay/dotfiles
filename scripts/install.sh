echo "Changing channel to unstable..."
nix-channel --add https://nixos.org/channels/nixos-unstable nixos
nix-channel --update

echo "Getting a new nix shell with the needed components for github auth..."
nix-shell -p gh --command "gh auth login"

echo "Cloning repo w/ git..."
nix-shell -p git --command "git clone git@github.com:Aliikay/dotfiles.git ~/dotfiles"

echo "Please add the following to your configuration.nix: 
nix.settings = {
    substituters = [\"https://hyprland.cachix.org\"];
    trusted-public-keys = [\"hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=\"];
};"
read -p "Press enter to continue"
sudo nano /etc/nixos/configuration.nix

echo "Rebuilding the system with substituters enabled"
sudo nixos-rebuild switch

echo "Building the new system..."
nix-shell -p nh git --command "~/dotfiles/scripts/rebuild.sh"
