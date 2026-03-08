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
  # List packages installed in unstable system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #foot
    #ascii-draw
    atuin
    aria2
    archipelago
    ani-cli
    android-tools
    android-studio
    aspell
    aspellDicts.en
    #amberol
    #alpaca
    alejandra # nix file formatter
    apostrophe
    #ardour
    #alvr
    appimage-run
    #audio-sharing
    base16-shell-preview
    base16-universal-manager
    bat
    batmon
    #bear
    #blanket
    #blockbench
    #boxbuddy
    btop
    #blackbox-terminal
    bibata-cursors
    #blender
    brightnessctl
    #bustle
    cava
    #cavalier
    cartero
    clapgrep
    #clisp
    celluloid
    cartridges
    collision
    #cartero
    commit
    #cubiomes-viewer
    #davinci-resolve
    #dart-sass
    decibels
    delta
    #decker
    #drawing
    #decker
    docker
    #dotnet-sdk_9
    dotnet-sdk_10
    #dotnet-sdk_11
    #dialect
    distrobox
    distroshelf
    dust
    dysk
    #enter-tex
    exhibit
    eloquent
    euphonica
    clinfo
    clang-tools

    #easyeffects
    eyedropper
    eza
    f3d
    fastfetch
    famistudio
    ffmpeg
    ffmpegthumbnailer

    foliate
    file-roller
    filezilla
    footage
    fragments
    fractal
    #gedit
    #geany
    gearlever # appimage integrator
    #(pkgs-unstable.gimp3-with-plugins.override {
    #  plugins = with pkgs-unstable.gimp3Plugins; [
    #gmic
    #  ];
    #})
    gimp3
    gradia

    gowall # cli to convert images and icons to color themes
    #gradience
    #glaxnimate

    sushi
    totem
    nautilus
    nautilus-python
    gnome-software
    gnome-tweaks
    gnome-sound-recorder
    #gnome-maps
    ghex
    #gnome-graphs
    #gnome-frog
    gnome-extension-manager
    #gnome-obfuscate
    dconf-editor
    zenity
    #gnome-podcasts
    gnome-decoder
    gnomecast # chrome cast

    #github-desktop
    gh
    ghostty
    halftone
    handbrake
    pkgs-unstable.heroic
    #health
    helvum
    hyfetch

    iconic
    identity
    impression
    itch
    krita
    keypunch
    komikku
    kooha
    killall

    #kdePackages.kate
    #kdePackages.dolphin #removed because it caused firefox to ignore default file manager and open dolphin instead
    #kdePackages.kdenlive
    #kdePackages.kdenlive
    #kdePackages.xwaylandvideobridge
    #kdePackages.kfind
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugin-kvantum

    libreoffice
    libsForQt5.qt5ct
    qt6Packages.qt6ct

    lazygit
    libclang
    lazydocker
    localsend
    lutris
    mangohud
    #mangojuice # mangohud is declarative so this doesnt work
    macchina
    #marker
    #metronome
    micro
    monophony
    mousam
    #moonlight-qt
    mpv
    mousai
    mission-center
    nautilus-open-any-terminal
    ncdu
    #neofetch
    newsflash
    nextcloud-client
    #newsflash
    nil
    nh
    nvtopPackages.full
    libnotify
    nix-tree
    onlyoffice-desktopeditors
    #obsidian
    #obs-studio
    paperwork
    #parsec-bin
    paleta
    papers
    #paper-clip
    pciutils
    pdfarranger
    #protonup-qt
    protonplus
    protontricks
    prismlauncher
    #popsicle
    #pods
    pitivi
    pinta
    #pixelorama
    ptyxis
    pipeline
    #pgadmin4-desktopmode
    #pika-backup
    parabolic
    #psensor #deprecated due to lack of maintenence

    pkgs.rocmPackages.clr
    pkgs.rocmPackages.rocblas
    pkgs.rocmPackages.hipblas

    qtscrcpy

    r2modman
    # razergenie
    ripgrep
    recordbox
    #pkgs-unstable.renpy
    #rstudio
    #rocm-opencl-icd doesnt exist anymore?
    #rocm-opencl-runtime
    sly
    scrcpy
    shortwave
    setzer
    share-preview
    smile
    #superTuxKart
    showtime
    sqlitebrowser
    #sqlitestudio
    switcheroo
    #sysprof
    speedtest
    #tangram
    textpieces

    #(pkgs.texlive.combine {
    #  inherit
    #    (pkgs.texlive)
    #    scheme-tetex
    #    enumitem
    #    sourcesanspro
    #    tcolorbox
    #    synctex
    #    xstring
    #    fontawesome5
    #    ;
    #})
    texliveFull

    texturepacker
    textcompare
    #trenchbroom
    #trackma
    trackma-gtk
    tic-80
    tldr
    turtle
    thunderbird
    tuba
    upscaler
    valent
    vlc
    vscode.fhs
    video-trimmer
    wineWowPackages.stable
    #warp
    webp-pixbuf-loader
    #(pkgs-unstable.winboat.override { nodejs_24 = pkgs.nodejs_24; })
    pkgs-unstable.winboat
    #winboat
    #wike
    unityhub
    #x2goclient
    xfce.thunar
    yt-dlp
    youtube-tui
    yazi
    uwuify
    pkgs-unstable.zed-editor
    #zellij

    #inputs.nixos-conf-editor.packages.${system}.nixos-conf-editor
    #inputs.nix-software-center.packages.${system}.nix-software-center

    #inputs.pip2nix.defaultPackage.${system}
  ];
}
