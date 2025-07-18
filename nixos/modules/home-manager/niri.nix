{
  config,
  pkgs,
  pkgs-unstable,
  pkgs-stable,
  pkgs-last-stable,
  inputs,
  ...
}: {
  # Wpaperd
  services.wpaperd = {
    enable = true;
    #settings = {
    #  default = {
    #    path = "${config.home.homeDirectory}/dotfiles/wallpapers";
    #    duration = "24h";
    #    sorting = "random";
    #  };
    #};
  };

  #services.mako = {
  #  enable = true;
  #};

  #services.dunst = {
  #  enable = true;
  #};

  programs.tofi = {
    enable = true;
  };

  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "niri msg action power-off-monitors && swaylock";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "sleep";
        action = "systemctl sleep";
        text = "Sleep";
        keybind = "s";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
      {
        label = "logout";
        action = "niri msg action quit -s";
        text = "Logout";
        keybind = "e";
      }
    ];
  };

  services.swaync = {
    enable = true;
  };

  programs.fuzzel = {
    enable = true;
  };

  programs.swaylock = {
    enable = true;
  };

  services.swayidle = {
    enable = true;
  };

  programs.waybar = {
    enable = true;
  };

  services.cliphist = {
    enable = true;
    allowImages = true;
  };
}
