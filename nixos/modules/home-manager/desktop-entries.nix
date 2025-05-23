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
      exec = "/home/alikay/dotfiles/scripts/rebuild.sh";
      terminal = true;
      icon = "/home/alikay/dotfiles/icons/nixos-rebuild.png";
      categories = ["System" "Utility"];
    };

    splittunnel = {
      name = "Split Tunnel Apps";
      genericName = "System Utility";
      exec = "/home/alikay/dotfiles/scripts/run-apps-with-split-tunnel.sh";
      terminal = false;
      icon = "/home/alikay/dotfiles/icons/run-apps-split-tunnel.png";
      categories = ["System" "Utility"];
    };

    convert-videos-to-webm = {
      name = "Convert To Webm";
      genericName = "System Utility";
      exec = "python /home/alikay/dotfiles/scripts/convert-videos-to-webm.py";
      terminal = true;
      categories = ["System" "Utility"];
    };

    stream-utilities = {
      name = "Stream Utilities";
      genericName = "System Utility";
      exec = "/home/alikay/dotfiles/scripts/start-stream-utilities.sh";
      terminal = false;
      categories = ["System" "Utility"];
    };

    renpy = {
      name = "Renpy";
      genericName = "Programming";
      exec = "renpy";
      terminal = false;
      icon = "/home/alikay/dotfiles/icons/renpy.png";
      categories = ["Development" "Game"];
    };

    material-maker = {
      name = "Material Maker";
      genericName = "Programming";
      exec = "material-maker";
      terminal = false;
      icon = "/home/alikay/dotfiles/icons/material-maker.png";
      categories = ["Development" "Game"];
    };

    decker = {
      name = "Decker";
      genericName = "Programming";
      exec = "decker";
      terminal = false;
      icon = "/home/alikay/dotfiles/icons/decker.png";
      categories = ["Development" "Game"];
    };

    anime = {
      name = "Anime";
      genericName = "Media Player";
      exec = "/home/alikay/dotfiles/scripts/watch-anime.sh";
      terminal = false;
      icon = "/home/alikay/dotfiles/icons/killua.png";
      categories = ["AudioVideo"];
    };
  };
}
