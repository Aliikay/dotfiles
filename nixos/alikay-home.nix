{config, lib, pkgs, pkgs-unstable, pkgs-stable, pkgs-last-stable, inputs, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "alikay";
  home.homeDirectory = "/home/alikay";
  
  imports = [ 
			inputs.ags.homeManagerModules.default 
			./modules/home-manager/desktop-entries.nix
			./modules/home-manager/gnome-extensions.nix
			./modules/home-manager/dconf.nix
			./modules/home-manager/update-notifier.nix
			./modules/home-manager/hyprland.nix
  ];

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };
  
  # set cursor size and dpi for 4k monitor
  #xresources.properties = {
  #  "Xcursor.size" = 16;
  #  "Xft.dpi" = 172;
  #};

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    ollama
    pywal
    sassc
    (python311.withPackages (p: [
    	p.material-color-utilities
    	p.pywayland    
    ]))
    cowsay
  ];
  
  
  # .config
  home.file.".config" = {
    source = ../.config;
    recursive = true;   # link recursively
  };
  
  # templates
  home.file."Templates" = {
  		source = ../templates;
  		recursive = true;
  };
  
  # Git
  programs.git = {
    enable = true;
    userName = "Alikay";
    userEmail = "1401288@gmail.com";
  };
  
  # Fish
  programs.fish = {
  		enable = true;
  		interactiveShellInit = ''
		    set fish_greeting # Disable greeting
		  '';
		  plugins = [
		  	{ name = "hydro"; src = pkgs.fishPlugins.hydro; }
		  ];
  };
  
  # Vim
  programs.vim = {
  		enable = true;
  };
  
  # PATH
  home.sessionPath = [ "$HOME/.local/bin" "$HOME/dotfiles/scripts" "$HOME/bin"];
  
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
