{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  pkgs-stable,
  pkgs-last-stable,
  inputs,
  ...
}: {
  # TODO please change the username & home directory to your own
  home.username = lib.mkForce "demo-station";
  home.homeDirectory = lib.mkForce "/home/demo-station";

  imports = [
    ./alikay-home.nix
  ];

  # Stylix
  stylix = {
    image = ../wallpapers/other/slipstream-water.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/da-one-sea.yaml";
  };

  home.file."dotfiles" = {
    source = ../.;
    recursive = true; # link recursively
  };

  # Custom waybar css
  home.file.".config/waybar" = lib.mkForce {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/home-folders/demo-station/.config/waybar";
    recursive = true;
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
