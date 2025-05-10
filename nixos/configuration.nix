# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  pkgs-stable,
  pkgs-last-stable,
  inputs,
  ...
}: let
  mpvScripts = with pkgs.mpvScripts; [
    mpris
    uosc
  ];
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    modules/all-ways-egpu.nix
    modules/gstreamer.nix
  ];

  # Overlays
  nixpkgs.overlays = [
    (final: prev: {mpv = prev.mpv.override {scripts = mpvScripts;};})
    (final: prev: {ani-cli = prev.ani-cli.override {mpv = final.mpv;};})
  ];

  # Bootloader.
  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "/dev/vda";
  # boot.loader.grub.useOSProber = true;

  # boot.initrd.availableKernelModules = [
  #   "aesni_intel"
  #   "cryptd"
  # ];

  # Kernel Package
  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.tmp.cleanOnBoot = true;

  # Disable boot messages to not interrupt the boot splash
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;

  # Enable plymouth for a good looking boot splash
  boot.plymouth = {
    enable = true;
  };

  boot.kernelParams = [
    # Disable the boot messages
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];

  boot.extraModprobeConfig = ''
    options amdgpu pcie_gen_cap=0x40000
  '';

  # Bootloader.
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 20;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-69f62bf0-92d5-426b-aa83-eebed3395eca".device = "/dev/disk/by-uuid/69f62bf0-92d5-426b-aa83-eebed3395eca";

  # Networking
  networking.hostName = "alikay"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Environment Variables
  environment.sessionVariables = rec {
    QT_QPA_PLATFORMTHEME = "qt6ct";
    NIXOS_OZONE_WL = "1";
    #NAUTILUS_4_EXTENSION_DIR = "${pkgs.gnome.nautilus-python}/lib/nautilus/extensions-4";
  };
  environment.pathsToLink = [
    "/share/nautilus-python/extensions"
  ];

  # Fix missing gstreamer plugins for nautilus (audio / video file properties)
  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" [
    pkgs.gst_all_1.gst-plugins-good
    pkgs.gst_all_1.gst-plugins-bad
    pkgs.gst_all_1.gst-plugins-ugly
    pkgs.gst_all_1.gst-libav
  ];

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Allow for broken packages
  nixpkgs.config.allowBroken = false;

  # Automatic Garbage Collection for Generations
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Automatic store optimization
  nix.optimise.automatic = true;
  nix.optimise.dates = ["03:45"];

  # Filesystem trim
  services.fstrim.enable = true;

  # Enable power management
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  # Enable ThermalD
  services.thermald.enable = true;

  # Enable TLP
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      #CPU_SCALING_GOVERNOR_ON_BAT = "performance";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      #CPU_ENERGY_PERF_POLICY_ON_BAT = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 50;
      #CPU_MAX_PERF_ON_BAT = 100;

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 1;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 80; # 80 and bellow it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 90; # 90 and above it stops charging
    };
  };
  services.power-profiles-daemon.enable = false;

  # Make nix follow the input in flake: helps nixd make correct suggestions
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.gnome.gnome-user-share.enable = true;
  services.gnome.gnome-online-accounts.enable = true;

  # Hardware
  hardware = {
    graphics = {
      enable = lib.mkForce true;
      #driSupport = lib.mkForce true;
      #driSupport32Bit = lib.mkForce true;
      #package = pkgs-unstable.mesa.drivers;
      #package32 = pkgs-unstable.pkgsi686Linux.mesa.drivers;

      # OpenCL Support
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
        #rocm-opencl-icd #doesnt exist anymore
        #rocm-opencl-runtime
      ];
    };

    # AMD GPU
    amdgpu = {
      opencl.enable = true;
    };
  };

  # Allow programs to find the HIP binary
  systemd.tmpfiles.rules = let
    rocmEnv = pkgs.symlinkJoin {
      name = "rocm-combined";
      paths = with pkgs.rocmPackages; [
        rocblas
        hipblas
        clr
      ];
    };
  in [
    "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
  ];

  # Configure systemd limits for lutris esync
  systemd.extraConfig = "DefaultLimitNOFILE=524288";
  security.pam.loginLimits = [
    {
      domain = "alikay";
      type = "hard";
      item = "nofile";
      value = "524288";
    }
  ];

  #systemd.tmpfiles.rules = [
  #  "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  #];

  xdg.portal.enable = true;
  # Removed since GNOME already adds this, add back if getting rid of GNOME
  #xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Mullvad
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [gutenprint hplip splix brlaser brgenml1lpr brgenml1cupswrapper];
  };

  # Enable AVAHI for printing
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Security
  security.sudo.extraConfig = ''
    Defaults passwd_timeout=0
  '';
  security.apparmor.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "freeimage-unstable-2021-11-01" #Allow for trenchbroom to be installed
    "dotnet-sdk-6.0.428" #Required for godot_4-mono
  ];

  # MPD daemon
  services.mpd = {
    enable = true;
    musicDirectory = "${config.users.users.alikay.home}/Music";
    user = "alikay";
    extraConfig = ''
      audio_output {
      	type "pipewire"
      	name "MPD Pipewire Output"
      }
    '';

    #network.listenAddress = "any"; # used for non-localhost connections
    startWhenNeeded = true;
  };

  systemd.services.mpd.environment = {
    # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
    XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.alikay.uid}"; # User-id must match services.mpd.user. MPD will look inside this directory for the PipeWire socket.
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alikay = {
    isNormalUser = true;
    description = "alikay";
    extraGroups = ["networkmanager" "wheel" "audio" "video" "render" "input" "libvirtd" "media"];
    packages = with pkgs; [
    ];
  };

  users.users.alikay-alt = {
    isNormalUser = true;
    description = "alikay-alt";
    extraGroups = ["networkmanager" "wheel" "audio" "video" "render" "input" "libvirtd" "media"];
    packages = with pkgs; [
    ];
  };

  users.users.guest = {
    isNormalUser = true;
    description = "Guest Account";
    extraGroups = ["networkmanager" "audio" "video" "render" "input" "libvirtd" "media"];
    packages = with pkgs; [
    ];
  };

  users.users.demo-station = {
    isNormalUser = true;
    description = "Demo Station";
    extraGroups = ["networkmanager" "audio" "video" "render" "input" "libvirtd" "media"];
    packages = with pkgs; [
    ];
  };

  users.groups.media = {
    members = ["mpd"];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Setup steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;

  # Enable firefox
  programs.firefox = {
    enable = true;
  };

  # Virtual Machines
  virtualisation.libvirtd.enable = true;
  virtualisation.waydroid.enable = true;
  #virtualisation.virtualbox.host.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  programs.virt-manager.enable = true;

  # Enable Podman
  virtualisation.podman = {
    enable = true;
  };

  # Enable ADB
  programs.adb.enable = true;

  # Enable Firejail
  programs.firejail.enable = true;

  # Enable fish
  programs.fish.enable = true;

  # Enable atuin (shell history)
  services.atuin.enable = true;

  # Set the default shell to fish
  users.defaultUserShell = pkgs.fish;

  # Appimage Support
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };

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
    "com.gitfiend.GitFiend"
    "com.google.Chrome"
    #"com.nextcloud.desktopclient.nextcloud"
    #"org.prismlauncher.PrismLauncher"
    "com.spotify.Client"
    #"io.github.spacingbat3.webcord"
    #"us.zoom.Zoom"
    "io.github.Foldex.AdwSteamGtk"
    "dev.vencord.Vesktop"
    "ca.parallel_launcher.ParallelLauncher"
    #"com.github.muriloventuroso.easyssh"
    "in.srev.guiscrcpy"
    #"camp.nook.nookdesktop"
    "dev.gbstudio.gb-studio"
    "io.github.zen_browser.zen" #not in nixpkgs yet
    "io.github.ec_.Quake3e.OpenArena" #version in the repos doesnt work
    #"de.hummdudel.Libellus" #not in nixpkgs yet
    "nl.emphisia.icon" #not in nixpkgs yet
    "org.twinery.Twine" #not in nixpkgs yet
    "org.vinegarhq.Vinegar" # not in nixpkgs yet
    "io.gitlab.theevilskeleton.Upscaler" # version in nixpkgs is broken
    "io.github.flattool.Warehouse"
    "net.codelogistics.webapps" # not in nixpkgs
    "io.github.josephmawa.TextCompare" # not in nixpkgs
    "page.codeberg.libre_menu_editor.LibreMenuEditor" # not in nixpkgs
    #"org.godotengine.GodotSharp" # broken rn for some reason idk why
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

  # Making blackbox the default terminal
  programs.nautilus-open-any-terminal = {
    enable = false;
    terminal = "blackbox";
  };

  # Enable man pages
  documentation = {
    enable = true;
    man.enable = true;
    dev.enable = true;
  };

  fonts.packages = with pkgs; [
    nerdfonts
    corefonts
    vistafonts
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    8000 #Development
    8080
    7777

    # Slipstresm
    7770
    7779

    47777

    9943
    9944 # ALVR

    25565 #Minecraft

    53317 # Localsend
  ];
  networking.firewall.allowedTCPPortRanges = [
    {
      from = 1714;
      to = 1764;
    } # KDE Connect
  ];

  networking.firewall.allowedUDPPorts = [
    8000 #Development
    8080
    7777

    # Slipstresm
    7770
    7779

    47777

    9943
    9944 # ALVR

    25565 #Minecraft

    53317 #Localsend
  ];
  networking.firewall.allowedUDPPortRanges = [
    {
      from = 1714;
      to = 1764;
    } # KDE Connect
  ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
