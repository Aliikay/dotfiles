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
  programs.niri = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    waybar
    #fuzzel
    #mako
    #swaybg
    #swayidle
    #swaylock
    #wpaperd
    xwayland-satellite
    xsettingsd
    brightnessctl
    swayosd
    udiskie
    pavucontrol
    inotify-tools
    killall
    networkmanagerapplet
    #blueman
    blueberry
    wev
    cliphist
    wl-clipboard-rs
    swayidle
    xwayland
    wl-mirror
    openbox # For running xwayland rootful
  ];

  # Polkit
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = ["graphical-session.target"];
    wants = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
