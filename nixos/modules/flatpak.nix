{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  #pkgs-stable,
  #pkgs-last-stable,
  inputs,
  ...
}: {
  # Flatpaks
  services.flatpak.enable = true;
  services.flatpak.remotes = [
    {
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }
  ];
  services.flatpak.packages = [
    "md.obsidian.Obsidian"
    "com.usebottles.bottles"
    "com.github.tchx84.Flatseal"
    # "com.gitfiend.GitFiend"
    # "com.google.Chrome"
    #"com.nextcloud.desktopclient.nextcloud"
    #"org.prismlauncher.PrismLauncher"
    #"com.spotify.Client"
    #"io.github.spacingbat3.webcord"
    "us.zoom.Zoom"
    # "io.github.Foldex.AdwSteamGtk"
    #"dev.vencord.Vesktop"
    #"com.github.muriloventuroso.easyssh"
    #"in.srev.guiscrcpy"
    # "com.kristianduske.TrenchBroom"
    #"camp.nook.nookdesktop"
    #"dev.gbstudio.gb-studio"
    "io.github.zen_browser.zen" # not in nixpkgs yet
    #"io.github.ec_.Quake3e.OpenArena" #version in the repos doesnt work
    #"de.hummdudel.Libellus" #not in nixpkgs yet
    #"nl.emphisia.icon" #not in nixpkgs yet
    #"org.twinery.Twine" #not in nixpkgs yet
    #"org.vinegarhq.Vinegar" # not in nixpkgs yet
    #"io.gitlab.theevilskeleton.Upscaler" # version in nixpkgs is broken
    #"io.github.flattool.Warehouse"
    "net.codelogistics.webapps" # not in nixpkgs
    #"io.github.josephmawa.TextCompare" # not in nixpkgs
    # "page.codeberg.libre_menu_editor.LibreMenuEditor" # not in nixpkgs
    #"org.godotengine.GodotSharp" # broken rn for some reason idk why
    "org.kde.kdenlive"
    #"space.gaiasky.GaiaSky"
    #"net.krafting.HexColordle"
    "io.github.mfat.sshpilot" # not in nixpkgs
    #"as.may.moat" # not in nixpkgs
    # "io.github.wartybix.Constrict" # not in nixpkgs
    "com.google.AndroidStudio"
  ];

  # Flatpak auto updates
  services.flatpak.update.auto = {
    enable = true;
    onCalendar = "weekly"; # Default value
  };

  # Flatpak overrides
  services.flatpak.overrides = {
    global = {
      Environment = {
        QT_STYLE_OVERRIDE = "kvantum";
      };

      Context = {
        filesystems = [
          "xdg-config/gtk-3.0:ro"
          "/home/alikay/.icons:ro"
          "xdg-config/gtk-4.0"
          "/usr/share/icons:ro"
          "xdg-config/Kvantum:ro"
        ];
      };
    };
  };
}
