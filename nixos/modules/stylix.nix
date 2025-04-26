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
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-pale.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-city-dark.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/horizon-dark.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/uwunicorn.yaml";

    #image = ../../wallpapers/gruvbox/kurapika-gruv.png;
    #image = ../../wallpapers/catppuccin/gradient-synth-cat.png;
    #image = ../../wallpapers/other/gon-and-killua.png;
    #image = ../../wallpapers/other/galaxy.jpg;
    #image = ../../wallpapers/other/illex-forest-night.png;
    image = ../../wallpapers/xenoblade/cauldros-distance.png;

    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Classic";

    targets.grub.useImage = true;

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
        package = pkgs.nerdfonts;
        name = "SpaceMono Nerd Font";
      };
    };

    polarity = "dark";
  };
}
