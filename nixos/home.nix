{config, pkgs, pkgs-unstable, pkgs-stable, pkgs-last-stable, inputs, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "alikay";
  home.homeDirectory = "/home/alikay";
  
  imports = [ 
  	inputs.ags.homeManagerModules.default 
  	./modules/desktop-entries.nix
  ];

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };
  
  # set cursor size and dpi for 4k monitor
  #xresources.properties = {
  #  "Xcursor.size" = 16;
  #  "Xft.dpi" = 172;
  #};

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    ollama
    pywal
    sassc
    (python311.withPackages (p: [
    	p.material-color-utilities
    	p.pywayland    
    ]))
    cowsay
    
  # Gnome Extensions
  ] ++ (with pkgs-unstable.gnomeExtensions; [
  	blur-my-shell
  	forge
  	dash-to-dock
  	color-picker
  	dash-to-panel
  	what-watch
  	appindicator
  	useless-gaps
  	somafm-internet-radio
  	user-avatar-in-quick-settings
  	rectangle
  	window-title-is-back
  	just-perfection
  	openweather
  	pano
  	cpufreq
  	quick-web-search
  	arcmenu
  	vitals
  	coverflow-alt-tab
  	gnome-clipboard
  	clipboard-indicator
  	gsconnect
  	gtile
  	paperwm
  	media-controls
  	quick-settings-audio-panel
  	pip-on-top
  	fuzzy-app-search
  	twitchlive-panel
  	logo-widget
  	logo-menu
  	quick-settings-tweaker
  	quick-settings-audio-panel
  	ddterm
  	miniview
  	top-bar-organizer
  	burn-my-windows
  	caffeine
  	#open-bar #needs to be installed imperativly because it requires write permissions to the installation directory
  	search-light
  	space-bar
  	rounded-corners
  	panel-corners
  	auto-activities
  	hide-top-bar
  	autohide-battery
  	gnome-40-ui-improvements
  	app-icons-taskbar
  	battery-health-charging
  	mullvad-indicator
  	usable-overview
  	tray-icons-reloaded
  	fly-pie
  	window-gestures
  	vertical-workspaces
  	media-progress
  	tiling-shell
  ]);
  
  # .config
  home.file.".config" = {
    source = ../.config;
    recursive = true;   # link recursively
  };
  
  # templates
  home.file."Templates" = {
  	source = ../templates;
  	recursive = true;
  };
  
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
  
  # Git
  programs.git = {
    enable = true;
    userName = "Alikay";
    userEmail = "1401288@gmail.com";
  };
  
  # Fish
  programs.fish = {
  	enable = true;
  };
  
  # Vim
  programs.vim = {
  	enable = true;
  };
  
  # Dconf
  dconf.settings = {
  	# Virt manager
  	"org/virt-manager/virt/manager/connections" = {
  		autoconnect = ["qemuL///system"];
  		uris = ["qemu:///system"];
  	};
  	"org/gnome/mutter" = { 
  		experimental-features = [ "scale-monitor-framebuffer" ];
  	};
  };
  
  # Notify changes with the auto update script
  systemd.user.services.auto-update-notify-watcher = {
  	Unit = {
  		Description = "Watches for data on the auto update notifier pipe and passes it to libnotify";
  	};
  	Install = {
  		WantedBy = [ "default.target" ];
  	};
  	Service = {
  		ExecStart = "${pkgs.writeShellScript "notify-watcher" ''
  			#!/bin/sh
  			FILE=$HOME/.upgrade-script-pipe
  			while true; do
  				sleep 5
  				if test -f "$FILE"; then
  					read line < "$FILE" ; notify-send "NixOS Auto Updates" "$line"
  					rm "$FILE"
  				fi
  			done
  		''}";
  	};
  };
  
  # PATH
  home.sessionPath = [ "$HOME/.local/bin" "$HOME/dotfiles/scripts" "$HOME/bin"];
  
  # Variables
  home.sessionVariables = {
  	#TERMINAL = "blackbox";
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
