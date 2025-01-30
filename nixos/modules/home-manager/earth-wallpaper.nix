{
  config,
  pkgs,
  pkgs-stable,
  inputs,
  ...
}: {
  systemd.user.services = {
      earth-wallpaper = {
        Unit = {
          Description = "Earth Wallpaper Service";
          After = [ "network.target" ];
        };
        Service = {
          Type = "oneshot";
          ExecStart = "${pkgs.writeShellScript "earth-wallpaper" ''
            #!/bin/sh
            cd %h/Pictures/Wallpapers
            # Remove old files
            rm earth.jpg
            rm cropped-earth.jpg

            # Download image
            ${pkgs.curl}/bin/curl https://cdn.star.nesdis.noaa.gov/GOES16/ABI/FD/GEOCOLOR/10848x10848.jpg > earth.jpg

            # Crop
            ${pkgs.ffmpeg}/bin/ffmpeg -i earth.jpg -vf "crop=8424:6616:0:0" -q:v 100 cropped-earth.jpg

            # Set as wallpaper
            gsettings set org.gnome.desktop.background picture-uri file:///%h/Pictures/Wallpapers/cropped-earth.jpg

          ''}";
        };
        Install.WantedBy = [ "default.target" ];
      };
    };

    systemd.user.timers = {
      earth-wallpaper-timer = {
        Unit.Description = "Set wallapaper to live earth photo";
        Timer = {
          Unit = "earth-wallpaper";
          OnCalendar = "10m";
        };
        Install.WantedBy = [ "timers.target" ];
      };
    };
}
