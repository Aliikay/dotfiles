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
  # Stylix
  stylix = {
    enable = true;
    autoEnable = true;

    targets.waybar.enable = false;

    iconTheme = {
      enable = true;
      package = pkgs.gruvbox-plus-icons.override {
        folder-color = "highland";
      };
      dark = "Gruvbox-Plus-Dark";
      light = "Gruvbox-Plus-Light";
    };
  };

  # .config linking
  #home.file.".hm-config" = {
  home.file.".config/niri" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nixos/modules/rices/gruvbox/niri";
    recursive = true; # link recursively
  };

  home.file.".config/waybar" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nixos/modules/rices/gruvbox/waybar";
    recursive = true; # link recursively
  };

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

  #programs.onagre = {
  #  enable = true;
  #};

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
    style = "
        window{
            background: #28282840;
        }

        button{
            color: #fabd2f;
        }";
  };

  services.swaync = {
    enable = true;
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "alacritty -T '{cmd}' -e '{cmd}'";
        font = lib.mkForce "Space Mono:size=14";
        width = 50;
        lines = 20;
        fields = lib.mkForce "filename,name,generic,categories,keywords";
        show-actions = true;
      };
    };
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

  services.walker = {
    enable = true;
  };

  services.cliphist = {
    enable = true;
    allowImages = true;
  };

  # Enable and remove system package once 25.11 releases
  #programs.niriswitcher = {
  #  enable = true;
  #};
}
