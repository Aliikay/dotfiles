{
  config,
  lib,
  pkgs,
  pkgs-stable,
  pkgs-unstable,
  pkgs-pinned,
  inputs,
  ...
}: let
  secrets = builtins.getFlake "/home/alikay/dotfile-secrets";
in {
  environment.systemPackages = [
    secrets.packages.x86_64-linux.i-would-never
    secrets.packages.x86_64-linux.renoise
  ];
}
