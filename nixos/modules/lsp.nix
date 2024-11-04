{
  config,
  pkgs,
  pkgs-stable,
  pkgs-unstable,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    nixd # nix language LSP
    nodePackages.typescript-language-server
  ];
}
