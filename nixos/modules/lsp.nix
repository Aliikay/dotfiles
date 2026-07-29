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
    typescript-language-server # JS and Typescript
    pkgs-unstable.rust-analyzer # Rust
    pkgs-unstable.rustfmt
    tailwindcss-language-server # CSS
    vscode-langservers-extracted # HTML, CSS, JSON, esLint
    omnisharp-roslyn # CSharp
    bash-language-server # Bash
  ];
}
