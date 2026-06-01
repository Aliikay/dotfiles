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

  services.wivrn = {
    enable = true;
    openFirewall = true;
  };

  programs.alvr = {
    enable = false;
    openFirewall = true;
  };

  systemd.user.services.monado.environment = {
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
  };

  environment.systemPackages = with pkgs; [
    bs-manager
    sidequest
  ];
}
