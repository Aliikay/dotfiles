{
  config,
  pkgs,
  pkgs-stable,
  pkgs-unstable,
  pkgs-pinned,
  inputs,
  ...
}: {
  imports = [
    #./illogical-impulse-dependancies.nix
  ];

  # Enable cachix for hyprland flake caching
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    #package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  environment.systemPackages = with pkgs; [
    eww
    blueberry
    fuzzel
    grim
    hyprpaper
    hyprpicker
    hyprlock
    hypridle
    pyprland
    slurp
    udiskie
    waybar
    nwg-displays
    pavucontrol
  ];
}
