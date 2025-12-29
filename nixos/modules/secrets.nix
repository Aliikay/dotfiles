{
  config,
  lib,
  pkgs,
  pkgs-stable,
  pkgs-unstable,
  pkgs-pinned,
  inputs,
  ...
}: {
  environment.systemPackages = [
    inputs.secrets.packages.x86_64-linux.i-would-never
    inputs.secrets.packages.x86_64-linux.renoise
  ];
}
