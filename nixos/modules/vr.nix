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
  services.monado = {
    enable = true;
    defaultRuntime = true; # Register as default OpenXR runtime
  };

  programs.alvr = {
    enable = true;
    openFirewall = true;
  };

  systemd.user.services.monado.environment = {
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
  };
}
