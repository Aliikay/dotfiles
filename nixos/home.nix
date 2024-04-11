{ config, inputs, pkgs, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "alikay";
  home.homeDirectory = "/home/alikay";
  
  imports = [ inputs.ags.homeManagerModules.default ];

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
    cowsay
  ];
  
  # AGS
  programs.ags = {
  	enable = true;  	
  };

  # Git
  programs.git = {
    enable = true;
    userName = "Alikay";
    userEmail = "1401288@gmail.com";
  };
  
  # PATH
  home.sessionPath = [ "$HOME/.local/bin" "$HOME/dotfiles/scripts" ];

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
