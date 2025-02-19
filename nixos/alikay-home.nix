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
  # TODO please change the username & home directory to your own
  home.username = "alikay";
  home.homeDirectory = "/home/alikay";

  imports = [
    inputs.ags.homeManagerModules.default
    ./modules/home-manager/desktop-entries.nix
    ./modules/home-manager/gnome-extensions.nix
    ./modules/home-manager/dconf.nix
    ./modules/home-manager/update-notifier.nix
    ./modules/home-manager/hyprland.nix
  ];

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # set cursor size and dpi for 4k monitor
  #xresources.properties = {
  #  "Xcursor.size" = 16;
  #  "Xft.dpi" = 172;
  #};

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    cowsay
    bottom
  ];

  # .config
  home.file.".config" = {
    source = ../home-folders/alikay/.config;
    recursive = true; # link recursively
  };

  # templates
  home.file."Templates" = {
    source = ../home-folders/alikay/Templates;
    recursive = true;
  };

  # Git
  programs.git = {
    enable = true;
    userName = "Alikay";
    userEmail = "1401288@gmail.com";
  };

  # MPD
  #services.mpd = {
  #  enable = true;
  #  musicDirectory = "${config.home.homeDirectory}/Music";
  #};

  # Link firejail to home, for itch launcher
  home.file.".config/itch/prereqs/firejail-386/firejail" = {
    source = "${pkgs.firejail}/bin/firejail";
  };
  home.file.".config/itch/prereqs/firejail-amd64/firejail" = {
    source = "${pkgs.firejail}/bin/firejail";
  };

  # BTOP
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "horizon";
    };
  };

  # Fish
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      # fastfetch -l "None"
      fish_config prompt choose scales
      eval "$(atuin init fish)"
    '';

    plugins = [
      #{ name = "hydro"; src = pkgs.fishPlugins.hydro.src; }
      {
        name = "puffer";
        src = pkgs.fishPlugins.puffer.src;
      }
      {
        name = "pisces";
        src = pkgs.fishPlugins.pisces.src;
      }
    ];
  };

  # Direnv
  programs.direnv = {
    enable = true;
    #enableFishIntegration = true; # see note on other shells below
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  #Fastfetch
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        #source = "nix_small";
        padding = {
          right = 1;
        };
      };
      display = {
        size = {
          binaryPrefix = "si";
        };
        color = "blue";
        separator = "   ";
      };
      modules = [
        "title"
        {
          type = "datetime";
          key = "Date";
          format = "{1}-{3}-{11}";
        }
        {
          type = "datetime";
          key = "Time";
          format = "{14}:{17}:{20}";
        }

        # Hardware
        "cpu"
        "gpu"
        "battery"

        # System
        "kernel"
        "packages"

        # Desktop
        "de"
        "uptime"

        # Player
        #"player"
        #"media"
        #"break"

        # Colors
        "colors"
      ];
    };
  };

  # Zellij
  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
    settings = {
      default_shell = "fish";
    };
  };

  # OBS Plugins
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-livesplit-one
    ];
  };

  # Ghostty
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "SpaceMono Nerd Font";
      window-decoration = "none";
    };
    enableFishIntegration = true;
    installBatSyntax = true;
  };

  # Stylix
  stylix = {
    enable = true;
    autoEnable = true;

    targets.btop.enable = false;
  };

  # PATH
  home.sessionPath = ["$HOME/.local/bin" "$HOME/dotfiles/scripts" "$HOME/bin"];

  # Variables
  home.sessionVariables = {
    #TERMINAL = "blackbox";
    EDITOR = "micro";
  };

  # Aliases
  home.shellAliases = {
    cat = "bat --pager=none";
    nano = "micro";
    sbcl = "rlwrap sbcl";
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
