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
  # Stylix theme
  stylix = {
    enable = true;
    autoEnable = true;

    # Theme colors can also be declared manually, and themes can be found with nix build nixpkgs#base16-schemes -> cd result -> nix run nixpkgs#eza -- --tree
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/uwunicorn.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";

    image = ./desk-gruvbox-material.jpg;

    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Classic";
    cursor.size = 32;

    targets.grub.useWallpaper = true;

    targets.plymouth.enable = true;
    targets.plymouth.logoAnimated = false;

    fonts = {
      sansSerif = {
        #package = pkgs.inter;
        #name = "Inter";

        package = pkgs.poppins;
        name = "Poppins";
      };

      #serif = {
      #  package = pkgs.poppins;
      #  name = "Poppins";
      #};

      monospace = {
        package = pkgs.nerd-fonts.space-mono;
        name = "SpaceMono Nerd Font";
      };
    };

    polarity = "dark";

    targets.qt.platform = lib.mkForce "qtct";
  };

  environment.systemPackages = with pkgs; [
    wofi
    eww
    waybar
    #pkgs-unstable.niriswitcher
    walker
  ];
}
