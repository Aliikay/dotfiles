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
}
