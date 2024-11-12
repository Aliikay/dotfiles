{
  config,
  pkgs,
  pkgs-unstable,
  pkgs-stable,
  pkgs-last-stable,
  inputs,
  ...
}: {
  # Notify changes with the auto update script
  systemd.user.services.auto-update-notify-watcher = {
    Unit = {
      Description = "Watches for data on the auto update notifier pipe and passes it to libnotify";
    };
    Install = {
      WantedBy = ["default.target"];
    };

    Service = {
      ExecStart = "${pkgs.writeShellScript "notify-watcher" ''
        #!/bin/sh
        FILE=$HOME/.upgrade-script-pipe
        while true; do
        	${pkgs.coreutils}/bin/sleep 5
        	if test -f "$FILE"; then
        		read line < "$FILE" ; ${pkgs.libnotify}/bin/notify-send "NixOS Auto Updates" "$line"
        		${pkgs.coreutils}/bin/rm "$FILE"
        	fi
        done
      ''}";
    };
  };
}
