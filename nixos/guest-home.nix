{config, lib, pkgs, pkgs-unstable, pkgs-stable, pkgs-last-stable, inputs, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "guest";
  home.homeDirectory = "/home/guest";
  
  imports = [ 
			inputs.ags.homeManagerModules.default 
			./modules/home-manager/desktop-entries.nix
			./modules/home-manager/gnome-extensions.nix
			./modules/home-manager/dconf.nix
			./modules/home-manager/update-notifier.nix
			./modules/home-manager/hyprland.nix
  ];
  
  # Fish
  programs.fish = {
  		enable = true;
  };
  
  # Vim
  programs.vim = {
  		enable = true;
  };
  
  # PATH
  #home.sessionPath = [ "$HOME/.local/bin" "$HOME/dotfiles/scripts" "$HOME/bin"];
  
  # Variables
  home.sessionVariables = {
  	#TERMINAL = "blackbox";
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
