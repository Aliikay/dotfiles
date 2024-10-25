{
  config,
  pkgs,
  pkgs-stable,
  pkgs-unstable,
  inputs,
  ...
}: let
  # Building from source
  build-dependancies = with pkgs; [
    scons
    gcc
    python3
    pkg-config
  ];

  # Edirot in repos
  editor = with pkgs; [
    godot_4
  ];

  # External Tools
  tools = with pkgs; [
    blender-hip
    pkgs-stable.aseprite
  ];
in {
  environment.systemPackages = with pkgs;
    [
    ]
    ++ build-dependancies
    ++ editor
    ++ tools;
}
