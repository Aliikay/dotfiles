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
  # List packages installed in unstable system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #foot
    pkgs-stable.aseprite
    ascii-draw
    atuin
    aria2
    ani-cli
    amberol
    alpaca
    alejandra #nix file formatter
    apostrophe
    #ardour
    alvr
    appimage-run
    audio-sharing
    base16-shell-preview
    base16-universal-manager
    bat
    bear
    blanket
    blockbench
    boxbuddy
    btop
    #blackbox-terminal
    bibata-cursors
    blender-hip
    #blender
    brightnessctl
    bustle
    cava
    cavalier
    clapgrep
    #clisp
    celluloid
    cartridges
    collision
    cartero
    commit
    cubiomes-viewer
    davinci-resolve
    #dart-sass
    decibels
    decker
    drawing
    #decker
    #droidcam
    docker
    dotnet-sdk
    dialect
    distrobox
    #enter-tex
    exhibit
    clinfo
    clang-tools

    easyeffects
    eyedropper
    f3d
    fastfetch
    ffmpeg
    ffmpegthumbnailer

    foliate
    footage
    fragments
    fractal
    furnace
    #gedit
    geany
    gearlever # appimage integrator
    (pkgs-unstable.gimp3-with-plugins.override {
      plugins = with pkgs-unstable.gimp3Plugins; [
        gmic
      ];
    })

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
    gnome-maps
    ghex
    gnome-graphs
    gnome-frog
    gnome-extension-manager
    gnome-obfuscate
    dconf-editor
    zenity
    gnome-podcasts
    gnome-decoder
    gnomecast #chrome cast

    git
    github-desktop
    gh
    ghostty
    halftone
    handbrake
    heroic
    #health
    helvum
    hyfetch

    identity
    impression
    inkscape
    pkgs-last-stable.itch
    krita
    keypunch
    komikku
    killall

    #kdePackages.kate
    #kdePackages.dolphin #removed because it caused firefox to ignore default file manager and open dolphin instead
    #kdePackages.kdenlive
    kdenlive
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
    material-maker
    marker
    metronome
    micro
    monophony
    mousam
    moonlight-qt
    mpv
    mpc-cli
    mousai
    mission-center
    nautilus-open-any-terminal
    ncdu
    #neofetch
    neovim
    nextcloud-client
    newsflash
    nil
    nh
    nvtopPackages.full
    libnotify
    nix-tree
    onlyoffice-bin
    #obsidian
    obs-studio
    paperwork
    paleta
    papers
    #paper-clip
    #pciutils
    pdfarranger
    #protonup-qt
    protonplus
    prismlauncher
    popsicle
    #pods
    plattenalbum
    pitivi
    pinta
    #pixelorama
    ptyxis
    pipeline
    #pika-backup
    parabolic
    #psensor #deprecated due to lack of maintenence

    pkgs.rocmPackages.clr
    pkgs.rocmPackages.rocblas
    pkgs.rocmPackages.hipblas

    ripgrep
    recordbox
    renpy
    #rstudio
    #rocm-opencl-icd doesnt exist anymore?
    #rocm-opencl-runtime
    sly
    scrcpy
    shortwave
    setzer
    share-preview
    sidequest
    smile
    #superTuxKart
    showtime
    sqlitebrowser
    #sqlitestudio
    switcheroo
    sysprof
    speedtest
    #tangram
    textpieces

    (pkgs.texlive.combine {
      inherit
        (pkgs.texlive)
        scheme-tetex
        enumitem
        sourcesanspro
        tcolorbox
        synctex
        ;
    })

    texturepacker
    #trenchbroom
    #trackma
    trackma-gtk
    tldr
    turtle
    thunderbird
    tuba
    vlc
    vscode.fhs
    video-trimmer
    wineWowPackages.stable
    #warp
    webp-pixbuf-loader
    wike
    unityhub
    #x2goclient
    xwaylandvideobridge
    yt-dlp
    uwuify
    pkgs-unstable.zed-editor
    #zellij

    inputs.nixos-conf-editor.packages.${system}.nixos-conf-editor
    inputs.nix-software-center.packages.${system}.nix-software-center

    inputs.pip2nix.defaultPackage.${system}
  ];
}
