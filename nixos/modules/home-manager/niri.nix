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
    settings = {
      default = {
        path = "${config.home.homeDirectory}/dotfiles/wallpapers";
        duration = "24h";
        sorting = "random";
      };
    };
  };
}
