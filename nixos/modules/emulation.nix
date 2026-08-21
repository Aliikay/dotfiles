{
  config,
  pkgs,
  pkgs-stable,
  pkgs-unstable,
  pkgs-pinned,
  inputs,
  ...
}: {
  # System Packages
  environment.systemPackages = with pkgs; [
    # NDS
    melonds
    desmume
    xdelta # to patch roms

    # 3ds
    #pkgs-unstable.azahar
    azahar

    # N64
    flips # patcher for roms
    mupen64plus # idk tbh
    #pkgs-unstable.parallel-launcher # won't build, has an insecure dependancy last i checked
    parallel-launcher

    #PS2
    pcsx2

    # Wii/GCN
    dolphin-emu

    # PSX, Saturn
    mednafen

    # Wii U
    cemu

    # Switch
    ryubing
    #torzu # got DMCA'd >n<
  ];

  # Flatpaks
  services.flatpak.packages = [
    "ca.parallel_launcher.ParallelLauncher"
  ];
}
