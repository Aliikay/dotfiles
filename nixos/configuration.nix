# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-stable, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  boot.initrd.availableKernelModules = [
    "aesni_intel"
    "cryptd"
  ];
  boot.tmp.cleanOnBoot = true;
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
  
  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Enable cachix for hyprland flake caching
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
  
  # Allow for broken packages
  nixpkgs.config.allowBroken = true;
  
  # Automatic System Updates
  systemd.services."nixos-auto-upgrade" = {
		description = "NixOS Automatic Updates";
  	restartIfChanged = false;
  	unitConfig.X-StopOnRemoval = false;
  	
  	path = with pkgs; [
        coreutils
        gnutar
        xz.bin
        sudo
        gzip
        libnotify
        gitMinimal
        config.nix.package.out
        config.programs.ssh.package
    ];
    
    environment = config.nix.envVars // {
      inherit (config.environment.sessionVariables) NIX_PATH;
      HOME = "/root";
    };
    
		script = let
        nixos-rebuild = "${config.system.build.nixos-rebuild}/bin/nixos-rebuild"; 
    in ''
		  REBUILD=${nixos-rebuild} /etc/nixos/nixos/update-nixos-auto-script.sh
		'';
		serviceConfig = {
		  Type = "oneshot";
		  User = "root";
		};
		
		startAt = "Sat 05:00:00";
		after = [ "network-online.target" ];
		wants = [ "network-online.target" ];
	};
  systemd.timers."nixos-auto-upgrade" = {
		  timerConfig = {
		    Persistent = true;
		    RandomizedDelaySec = "15min";
		  };
	};
  
  # Automatic Garbage Collection for Generations
  nix.gc = {
  	automatic = true;
  	dates = "weekly";
  	options = "--delete-older-than 30d";
  };
  
  # Automatic store optimization
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "03:45" ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  
  # Hardware
  #hardware = {
  #	opengl = {
  #		enable = true;
  #		driSupport32Bit = true;
  #		package = pkgs-unstable.mesa.drivers;
  #		package32 = pkgs-unstable.pkgsi686Linux.mesa.drivers;
  #	};
  #};
  
  # Hyprland
  programs.hyprland = {
  	enable = true;
  	xwayland.enable = true;
  	package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ xdg-desktop-portal-gtk ];
  
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
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.sudo.extraConfig = ''
  	Defaults passwd_timeout=0
  '';
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

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alikay = {
    isNormalUser = true;
    description = "alikay";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "input" "libvirtd" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Music Production tweaks
  musnix = {
  	enable = true;
  	# kernel.realtime = true;
  };
  
  # Setup steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };
  
  # Virtual Machines
  virtualisation.libvirtd.enable = true;
  virtualisation.waydroid.enable = true;
  programs.virt-manager.enable = true;
  
  # Flatpaks
  services.flatpak.enable = true;
  services.flatpak.packages = [
    "md.obsidian.Obsidian"
    "com.usebottles.bottles"
    "com.github.tchx84.Flatseal"
    "de.haeckerfelix.Fragments"
    "com.gitfiend.GitFiend"
    "com.google.Chrome"
    "org.pipewire.Helvum"
    "de.haeckerfelix.Shortwave"
    "com.nextcloud.desktopclient.nextcloud"
    "org.prismlauncher.PrismLauncher"
    "it.mijorus.smile"
    "com.spotify.Client"
    "io.github.spacingbat3.webcord"
    "us.zoom.Zoom"
    "com.system76.Popsicle"
  ];
  
  # Flatpak auto updates
  services.flatpak.update.auto = {
		enable = true;
		onCalendar = "weekly"; # Default value
	};
 
  # List packages installed in unstable system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
     foot
     pkgs-stable.aseprite
     bear
     btop
     blueberry
     bibata-cursors
     blender-hip
     brightnessctl
     celluloid
     dart-sass
     docker
     distrobox
     eww
     ffmpeg
     ffmpegthumbnailer
     firejail
     fish
     fuzzel
     gamescope
     gedit
     gimp
     grim
     gnome.sushi
     gnome.totem
     gnome.gnome-software
     gnome.gnome-tweaks
     git
     gh
     heroic
     
     hyprpaper
     hyprpicker
     pyprland
     
     pkgs-stable.itch
     krita
     killall
     
     kdePackages.kate
     kdePackages.dolphin
     
     libreoffice
     libsForQt5.qt5ct
     qt6Packages.qt6ct
     lutris
     melonDS
     nautilus-open-any-terminal
     neofetch
     nil
     nh
     libnotify
     nix-tree
     onlyoffice-bin
     #obsidian
     obs-studio
     pavucontrol
     psensor
     powertop
     renoise
     slurp
     thermald
     thunderbird
     vlc
     wine
     webp-pixbuf-loader
     waybar
     unityhub
     udiskie
     yabridge
     yabridgectl
     
     uwuify
     
     inputs.nixos-conf-editor.packages.${system}.nixos-conf-editor
     inputs.nix-software-center.packages.${system}.nix-software-center
     audacity
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
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
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
