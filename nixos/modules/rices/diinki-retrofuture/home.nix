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
  # Stylix
  stylix = {
    enable = true;
    autoEnable = true;

    targets.waybar.enable = false;
  };

  # .config linking
  home.file.".hm-config" = {
    source = ./.config;
    recursive = true; # link recursively
  };
}
