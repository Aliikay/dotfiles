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
  home.username = lib.mkForce "alikay-alt";
  home.homeDirectory = lib.mkForce "/home/alikay-alt";

  imports = [
    ./alikay-home.nix
  ];

  stylix = {
    image = ../wallpapers/other/n-festival.png;
  };
}
