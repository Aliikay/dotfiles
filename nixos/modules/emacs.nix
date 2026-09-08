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
    discount # Markdown support
  ];
}
