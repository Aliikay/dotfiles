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
  environment.systemPackages = with pkgs; [
    clingo
    sbcl
    rlwrap #for use with sbcl to fix the arrow keys
    swi-prolog
  ];
}
