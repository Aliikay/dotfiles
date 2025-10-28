{
  config,
  pkgs,
  pkgs-stable,
  pkgs-unstable,
  pkgs-pinned,
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

  # Editor in repos
  editor = with pkgs; [
    #godot_4
    pkgs-unstable.godot
    #godot_4-mono
    pkgs-unstable.godot_4-mono
  ];

  # External Tools
  tools = with pkgs; [
    blender-hip
    aseprite
    pkgs-unstable.gdtoolkit_4
  ];
in {
  environment.systemPackages = with pkgs;
    [
    ]
    ++ build-dependancies
    ++ editor
    ++ tools;
}
