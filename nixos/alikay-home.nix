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
    #inputs.ags.homeManagerModules.default
    ./modules/home-manager/desktop-entries.nix
    ./modules/home-manager/gnome-extensions.nix
    ./modules/home-manager/dconf.nix
    ./modules/home-manager/update-notifier.nix
    #./modules/home-manager/hyprland.nix
    #./modules/home-manager/niri.nix

    # Current rice
    #./modules/rices/original/home.nix
    #./modules/rices/diinki-retrofuture/home.nix
    ./modules/rices/gruvbox/home.nix
  ];

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

  # .icons
  #home.file.".icons" = {
  #  source = ../home-folders/alikay/.icons;
  #  recursive = true; # link recursively
  #};

  # templates
  home.file."Templates" = {
    source = ../home-folders/alikay/Templates;
    recursive = true;
  };

  # Git
  programs.git = {
    enable = true;
    settings = {
      user.name = "Alikay";
      user.email = "1401288@gmail.com";
      init.defaultBranch = "main";
    };
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

  # Godot Export templates for current stable and unstable versions
  #home.file.".local/share/godot/export_templates/${builtins.replaceStrings ["-"] ["."] pkgs.godot_4-export-templates-bin.version}" = {
  #  source = "${pkgs.godot_4-export-templates-bin}/share/godot/export_templates/${builtins.replaceStrings ["-"] ["."] pkgs.godot_4-export-templates-bin.version}";
  #};

  home.file.".local/share/godot/export_templates/${
    builtins.replaceStrings ["-"] ["."] pkgs-unstable.godot_4-export-templates-bin.version
  }" = {
    source = "${pkgs-unstable.godot_4-export-templates-bin}/share/godot/export_templates/${
      builtins.replaceStrings ["-"] ["."] pkgs-unstable.godot_4-export-templates-bin.version
    }";
  };

  # BTOP
  programs.btop = {
    enable = true;
    #settings = {
    #  color_theme = "horizon";
    #  theme_background = false;
    #};
  };

  # Atuin
  programs.atuin.enable = true;

  # Fish
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      # fastfetch -l "None"
      fish_config prompt choose scales
      bind up _atuin_bind_up
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

    functions = {
      # Allows Yazi to be opened with y and close into the current directory in the terminal
      y = "function y
       	set tmp (mktemp -t \"yazi-cwd.XXXXXX\")
       	yazi $argv --cwd-file=\"$tmp\"
       	if read -z cwd < \"$tmp\"; and [ -n \"$cwd\" ]; and [ \"$cwd\" != \"$PWD\" ]
        		builtin cd -- \"$cwd\"
       	end
       	rm -f -- \"$tmp\"
      end";
    };
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
        #"title"
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

  # Yazi
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      mgr = {
        show_hidden = false;
        sort_dir_first = true;

        #sort_by = "mtime";
        #sort_reverse = true;
        sort_by = "alphabetical";
        sort_reverse = false;
      };
    };
  };

  # OBS Plugins
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-livesplit-one
    ];
  };

  # Zeditor
  programs.zed-editor = {
    enable = true;
    userSettings = {
      soft_wrap = "editor_width";
      diagnostics = {
        inline = {
          enabled = true;
        };
      };
      disable_ai = true;
      helix_mode = false;
    };
  };

  # Micro
  programs.micro = {
    enable = true;
  };

  # RMPC
  programs.rmpc = {
    enable = true;
  };

  # Ncspot (NCurses Spotify Client)
  programs.ncspot = {
    enable = true;
  };

  # Mangohud
  programs.mangohud = {
    enable = true;
  };

  # MPV Scripts
  programs.mpv = {
    enable = true;

    package = (
      pkgs.mpv-unwrapped.wrapper {
        scripts = with pkgs.mpvScripts; [
          uosc
          mpris
        ];

        mpv = pkgs.mpv-unwrapped.override {
          waylandSupport = true;
        };
      }
    );

    config = {
      profile = "high-quality";
      hwdec = "auto";
      #ytdl-format = "bestvideo+bestaudio";
      #cache-default = 4000000;
    };
  };

  # Ghostty
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "SpaceMono Nerd Font";

      window-decoration = "auto";
      window-padding-y = 5;
      window-padding-x = 5;
      window-height = 28;
      window-width = 105;

      adw-toolbar-style = "flat";
    };
    enableFishIntegration = true;
    installBatSyntax = true;
  };

  # Kitty
  programs.kitty = {
    enable = false;
  };

  # Alacritty
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty-graphics;
    settings = {
      window = {
        decorations = "None";
        padding = {
          x = 10;
          y = 10;
        };
        dimensions = {
          columns = 105;
          lines = 28;
        };
      };

      cursor.style = {
        shape = "Beam";
        blinking = "On";
      };
    };
  };

  # Helix
  programs.helix = {
    enable = true;
  };

  # PATH
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/dotfiles/scripts"
    "$HOME/bin"
  ];

  # Variables
  home.sessionVariables = {
    #TERMINAL = "blackbox";
    EDITOR = "micro";
    GIT_EDITOR = "re.sonny.Commit";
  };

  # Aliases
  home.shellAliases = {
    cat = "bat --pager=none";
    nano = "micro";
    sbcl = "rlwrap sbcl";
    ls = "eza";
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
