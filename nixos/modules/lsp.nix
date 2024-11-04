{
  config,
  pkgs,
  pkgs-stable,
  pkgs-unstable,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    nixd # nix
    nodePackages.typescript-language-server # JS and Typescript
    rust-analyzer #Rust
  ];
}
