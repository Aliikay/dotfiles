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
    pkgsRocm.blender
    renderdoc
    aseprite
    inkscape
    material-maker
  ];
}
