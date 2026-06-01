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
    blender
    renderdoc
    aseprite
    inkscape
    material-maker
  ];
}
