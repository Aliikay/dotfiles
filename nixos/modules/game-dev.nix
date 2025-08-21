{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  #pkgs-stable,
  #pkgs-last-stable,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    unityhub
    renderdoc
    aseprite
    blender-hip
    inkscape
    material-maker
  ];
}
