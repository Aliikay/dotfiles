{
  config,
  pkgs,
  pkgs-stable,
  inputs,
  ...
}: {
  xdg.desktopEntries = {
    rebuild = {
      name = "Rebuild";
      genericName = "System Utility";
      exec = "alacritty -e /home/alikay/dotfiles/scripts/rebuild.sh";
      terminal = false;
      icon = "/home/alikay/dotfiles/icons/nixos-rebuild.png";
      categories = [
        "System"
        "Utility"
      ];
    };

    splittunnel = {
      name = "Split Tunnel Apps";
      genericName = "System Utility";
      exec = "/home/alikay/dotfiles/scripts/run-apps-with-split-tunnel.sh";
      terminal = false;
      icon = "/home/alikay/dotfiles/icons/run-apps-split-tunnel.png";
      categories = [
        "System"
        "Utility"
      ];
    };

    stream-utilities = {
      name = "Stream Utilities";
      genericName = "System Utility";
      exec = "/home/alikay/dotfiles/scripts/start-stream-utilities.sh";
      terminal = false;
      categories = [
        "System"
        "Utility"
      ];
    };

    renpy = {
      name = "Renpy";
      genericName = "Programming";
      exec = "renpy";
      terminal = false;
      icon = "/home/alikay/dotfiles/icons/renpy.png";
      categories = [
        "Development"
        "Game"
      ];
    };

    material-maker = {
      name = "Material Maker";
      genericName = "Programming";
      exec = "material-maker";
      terminal = false;
      icon = "/home/alikay/dotfiles/icons/material-maker.png";
      categories = [
        "Development"
        "Game"
      ];
    };

    decker = {
      name = "Decker";
      genericName = "Programming";
      exec = "decker";
      terminal = false;
      icon = "/home/alikay/dotfiles/icons/decker.png";
      categories = [
        "Development"
        "Game"
      ];
    };

    anime = {
      name = "Anime";
      genericName = "Media Player";
      exec = "/home/alikay/dotfiles/scripts/watch-anime.sh";
      terminal = false;
      icon = "/home/alikay/dotfiles/icons/killua.png";
      categories = ["AudioVideo"];
    };

    game-dev-tools = {
      name = "Game Dev Tools";
      genericName = "Programming";
      exec = "/home/alikay/dotfiles/scripts/game-dev-tools.sh";
      terminal = false;
      icon = "/home/alikay/dotfiles/icons/game-dev.png";
      categories = ["AudioVideo"];
    };

    zen-profile-manager = {
      name = "Zen Profiles";
      genericName = "Internet Browser";
      exec = "flatpak run app.zen_browser.zen --ProfileManager";
      terminal = false;
      icon = ./../../../icons/zen-profiles.png;
      categories = ["Network"];
    };

    work-tools = {
      name = "Work Tools";
      genericName = "System Utility";
      exec = "/home/alikay/dotfiles/scripts/work-tools.sh";
      terminal = false;
      icon = ./../../../icons/work.png;
      categories = ["Network"];
    };

    picocad = {
      name = "PicoCAD";
      genericName = "3D Modelling";
      exec = "/home/alikay/dotfiles/scripts/launch-picocad.sh";
      terminal = false;
      icon = ./../../../icons/picocad.png;
      categories = ["AudioVideo"];
    };

    toggle-screen-record = {
      name = "Toggle Screen Record";
      genericName = "System Utility";
      exec = "/home/alikay/dotfiles/scripts/screen-record.sh";
      terminal = false;
      icon = ./../../../icons/screen-record.png;
      categories = ["AudioVideo"];
    };
  };
}
