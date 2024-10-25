{
  config,
  pkgs,
  pkgs-unstable,
  pkgs-stable,
  pkgs-last-stable,
  inputs,
  ...
}: {
  # Dconf
  dconf.settings = {
    # Virt manager
    "org/virt-manager/virt/manager/connections" = {
      autoconnect = ["qemuL///system"];
      uris = ["qemu:///system"];
    };
    "org/gnome/mutter" = {
      experimental-features = ["scale-monitor-framebuffer"];
    };
  };
}
