{
  config,
  pkgs,
  pkgs-stable,
  pkgs-unstable,
  pkgs-pinned,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # NDS
    melonDS
    xdelta #to patch roms

    # 3ds
    #pkgs-unstable.azahar

    # N64
    flips # patcher for roms
    mupen64plus #idk tbh

    #PS2
    pcsx2

    # Wii/GCN
    dolphin-emu

    # Wii U
    cemu

    # Switch
    ryujinx
    torzu
  ];
}
