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
  programs.niri = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    waybar
    fuzzel
  ];
}
