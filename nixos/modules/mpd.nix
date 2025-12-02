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
  # MPD daemon
  services.mpd = {
    enable = true;
    musicDirectory = "${config.users.users.alikay.home}/Music/Collection";
    user = "alikay";
    extraConfig = ''
      audio_output {
      	type "pipewire"
      	name "Pipewire Output"
      }
    '';

    #network.listenAddress = "any"; # used for non-localhost connections
    #startWhenNeeded = true;
  };

  systemd.services.mpd.environment = {
    # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
    #XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.alikay.uid}"; # User-id must match services.mpd.user. MPD will look inside this directory for the PipeWire socket.
    XDG_RUNTIME_DIR = "/run/user/1000";
  };

  users.groups.media = {
    members = ["mpd"];
  };

  environment.systemPackages = with pkgs; [
    mpdris2
    plattenalbum
    playerctl
    mpc
  ];
}
