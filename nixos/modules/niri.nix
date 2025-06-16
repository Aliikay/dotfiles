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
    #fuzzel
    #mako
    #swaybg
    #swayidle
    #swaylock
    #wpaperd
    xwayland-satellite
    brightnessctl
    swayosd
    udiskie
    pavucontrol
    inotify-tools
    killall
    networkmanagerapplet
    #blueman
    blueberry
  ];
}
