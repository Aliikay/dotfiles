{
  config,
  pkgs,
  pkgs-unstable,
  pkgs-stable,
  pkgs-last-stable,
  inputs,
  ...
}: {
  # Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    #systemdIntegration = true;
    plugins = [
      #inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      #inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
    ];
    #package = inputs.hyprland.packages.${pkgs.system}.hyprland;

    extraConfig = ''
      source=~/.config/hypr/main.conf
    '';
  };

  # Wpaperd
  programs.wpaperd = {
    enable = true;
    settings = {
      default = {
        path = "${config.home.homeDirectory}/dotfiles/wallpapers";
        duration = "24h";
        sorting = "random";
      };
    };
  };

  # AGS
  programs.ags = {
    enable = true;
    configDir = null;

    extraPackages = with pkgs; [
      gtksourceview
      gtksourceview4
      ollama
      python311Packages.material-color-utilities
      python311Packages.pywayland
      pywal
      sassc
      webkitgtk
      webp-pixbuf-loader
      ydotool
    ];
  };
}
