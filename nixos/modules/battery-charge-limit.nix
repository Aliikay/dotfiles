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
  # Automatic System Updates
  systemd.services."battery-charge-limit" = {
    description = "Limit Battery Charge to 80%";
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

    script = let
    in ''
      echo 80 > /sys/class/power_supply/BAT1/charge_control_end_threshold
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };

  # Allow non root users to set the battery charge threshold!
  security.sudo.extraRules = [
    {
      users = ["alikay" "alikay-alt"];
      commands = [
        {
          command = "/run/current-system/sw/bin/systemctl start battery-charge-limit";
          options = ["SETENV" "NOPASSWD"];
        }
      ];
    }
  ];
}
