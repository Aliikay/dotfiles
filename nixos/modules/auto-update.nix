{
  config,
  pkgs,
  pkgs-stable,
  pkgs-unstable,
  pkgs-pinned,
  inputs,
  ...
}: {
  # Automatic System Updates
  systemd.services."nixos-auto-upgrade" = {
    description = "NixOS Automatic Updates";
    restartIfChanged = false;
    unitConfig.X-StopOnRemoval = false;

    path = with pkgs; [
      coreutils
      gnutar
      xz.bin
      sudo
      gzip
      libnotify
      gitMinimal
      config.nix.package.out
      config.programs.ssh.package
    ];

    environment =
      config.nix.envVars
      // {
        inherit (config.environment.sessionVariables) NIX_PATH;
        HOME = "/root";
        #DBUS_SESSION_BUS_ADDRESS = "unix:path=${builtins.getEnv "XDG_RUNTIME_DIR"}/bus"; # from when i tried to make notify service only run while upgrading
      };

    script = let
      nixos-rebuild = "${config.system.build.nixos-rebuild}/bin/nixos-rebuild";
    in ''
      REBUILD=${nixos-rebuild} /etc/nixos/nixos/update-nixos-auto-script.sh
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };

    startAt = "Sat 05:00:00";
    after = ["network-online.target"];
    wants = ["network-online.target"];
  };
  systemd.timers."nixos-auto-upgrade" = {
    timerConfig = {
      Persistent = true;
      RandomizedDelaySec = "15min";
    };
  };
}
