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
  # These services have been ported from the systemd unit files in the dotfiles/systemd folder

  # Main Service File
  systemd.services."all-ways-egpu" = {
    enable = true;
    description = "Configure eGPU as primary under Wayland desktops";

    path = with pkgs; [
      coreutils
      pciutils
      gawk
      util-linux
    ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/home/alikay/dotfiles/scripts/start-all-ways-egpu-boot.sh";
    };

    wantedBy = ["graphical.target"];

    before = ["display-manager.service"];
    after = ["bolt.service"];
  };

  # Configure GPU as main under boot_vga
  systemd.services."all-ways-egpu-boot-vga" = {
    enable = false;
    description = "Configure eGPU as primary using boot_vga under Wayland desktops";

    path = with pkgs; [
      coreutils
      pciutils
      gawk
      util-linux
    ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/home/alikay/bin/all-ways-egpu set-boot-vga egpu";
    };

    wantedBy = ["graphical.target"];

    after = ["display-manager.service" "bolt.service"];
  };

  # Shutdown Process to cleanup boot_vga
  systemd.services."all-ways-egpu-shutdown" = {
    enable = false;
    description = "Cleanup boot_vga eGPU configuration at shutdown";

    path = with pkgs; [
      coreutils
      pciutils
      gawk
      util-linux
    ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/home/alikay/bin/all-ways-egpu set-boot-vga internal";
    };

    wantedBy = ["halt.target" "shutdown.target" "reboot.target"];

    before = ["halt.target" "shutdown.target" "reboot.target"];
  };

  # Configure GPU as main uusing compositor variables
  systemd.services."all-ways-egpu-set-compositor" = {
    enable = false;
    description = "Configure eGPU as primary using compositor variables under Wayland desktops";

    path = with pkgs; [
      coreutils
      pciutils
      gawk
      util-linux
    ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/home/alikay/bin/all-ways-egpu set-compositor-primary egpu";
    };

    wantedBy = ["graphical.target"];

    after = ["display-manager.service" "bolt.service"];
  };
}
