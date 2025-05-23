{
  description = "Alikay's System";

  inputs = {
    # Default to the June 2024 branch
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    # Latest unstable branch of nixos
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Pinned version of the unstable branch, for when stuff breaks
    nixpkgs-pinned.url = "github:nixos/nixpkgs/8b3c65bb34f8758be725ce3216c73e6ca043d274";

    # Latest stable branch of nixpkgs, used for version rollback
    # The current latest version is 24.05
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # Last stable branch of nixpkgs, used for version rollback
    # The current latest version is 23.11
    nixpkgs-last-stable.url = "github:nixos/nixpkgs/nixos-23.11";

    # Makes various tweaks for audio production
    musnix = {url = "github:musnix/musnix";};

    # Flatpaks
    nix-flatpak.url = "github:gmodena/nix-flatpak"; # unstable branch. Use github:gmodena/nix-flatpak/?ref=<tag> to pin releases.

    # Ags
    ags.url = "github:Aylur/ags";

    # Flake version for command-not-found
    flake-programs-sqlite.url = "github:wamserma/flake-programs-sqlite";
    flake-programs-sqlite.inputs.nixpkgs.follows = "nixpkgs";

    # Hyprland
    #hyprland.url = "github:hyprwm/Hyprland/v0.40.0";
    #hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      #inputs.hyprland.follows = "hyprland";
    };

    # NixOS Conf Manager
    nixos-conf-editor.url = "github:snowfallorg/nixos-conf-editor";
    nix-software-center.url = "github:snowfallorg/nix-software-center";

    # pip2nix, autogenerate nix packages based on pip files
    pip2nix.url = "github:nix-community/pip2nix";

    # stylix to theme the entire system
    stylix.url = "github:danth/stylix/release-24.11";
    #stylix.url = "github:danth/stylix";
    #stylix.url = "github:danth/stylix/ffba1f1bab63ea49541f812c72a4fcf305461d67";

    # Framework specific tweaks
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # Home-manager, used for managing user configuration
    home-manager = {
      #url = "github:nix-community/home-manager";
      url = "github:nix-community/home-manager/release-24.11";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secrets - comment out if you want to use this system yourself
    # This flake contains a bunch of stuff that I can't include in the main repo (blobs, keys, etc...)
    secrets.url = "/home/alikay/dotfile-secrets";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixpkgs-pinned,
    nixpkgs-stable,
    nixpkgs-last-stable,
    home-manager,
    ...
  }: let
    mySpecialArgs = {
      inherit inputs;
      # To use packages from nixpkgs-unstable,
      # we configure some parameters for it first
      pkgs-stable = import nixpkgs-stable {
        # Refer to the `system` parameter from
        # the outer scope recursively
        inherit inputs;
        system = "x86_64-linux";
        config.allowUnfree = true;
      };

      pkgs-last-stable = import nixpkgs-last-stable {
        # Refer to the `system` parameter from
        # the outer scope recursively
        inherit inputs;
        system = "x86_64-linux";
        config.allowUnfree = true;
      };

      pkgs-unstable = import nixpkgs-unstable {
        # Refer to the `system` parameter from
        # the outer scope recursively
        inherit inputs;
        system = "x86_64-linux";
        config.allowUnfree = true;
      };

      pkgs-pinned = import nixpkgs-pinned {
        inherit inputs;
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    };

    generic-system = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = mySpecialArgs;
      modules = [
        inputs.nixos-hardware.nixosModules.framework-11th-gen-intel
        #inputs.nixos-hardware.nixosModules.common-gpu-amd
        inputs.musnix.nixosModules.musnix
        inputs.nix-flatpak.nixosModules.nix-flatpak
        #hyprland.nixosModules.default
        #inputs.secrets.nixosModules.config

        ./nixos/configuration.nix
        ./nixos/modules/packages.nix
        ./nixos/modules/stylix.nix
        ./nixos/modules/auto-update.nix
        #./nixos/modules/hyprland.nix
        ./nixos/modules/nix-ld.nix
        ./nixos/modules/godot.nix
        ./nixos/modules/lsp.nix
        ./nixos/modules/emulation.nix
        ./nixos/modules/audio-production.nix
        #./nixos/modules/cmput-325.nix

        inputs.flake-programs-sqlite.nixosModules.programs-sqlite
        inputs.stylix.nixosModules.stylix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = mySpecialArgs;
          home-manager.users.alikay = import ./nixos/alikay-home.nix;
          home-manager.users.alikay-alt = import ./nixos/alikay-alt-home.nix;
          home-manager.users.guest = import ./nixos/guest-home.nix;
          home-manager.users.demo-station = import ./nixos/demo-station-home.nix;

          # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
        }
      ];
    };
  in {
    #, hyprland, ... }: {
    nixosConfigurations.alikay = generic-system;
  };
}
