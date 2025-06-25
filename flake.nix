# flake.nix
{
  description = "Eric's cross-platform Nix configuration";

  inputs = {
    # Use only unstable nixpkgs channel
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Latest nix-darwin channel
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Latest home-manager channel
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... }:
    let
      mkSystem = system: modules: nixpkgs.lib.nixosSystem {
        inherit system;
        modules = modules ++ [
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            nixpkgs.config.allowUnfree = true;
          }
        ];
      };

      mkDarwin = system: modules: nix-darwin.lib.darwinSystem {
        inherit system;
        modules = modules ++ [
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            nixpkgs.config.allowUnfree = true;
            
            # Override packages that cause libfaketime build issues
            nixpkgs.overlays = [(final: prev: {             
              libfaketime = prev.libfaketime.overrideAttrs (oldAttrs: {
                doCheck = false;
              });
              
              # Override R to disable TeX dependencies
              R = prev.R.overrideAttrs (oldAttrs: {
                # Disable TeX Live dependencies that conflict with our overlay
                texLive = null;
                withRecommendedPackages = false;
              });
              
              # Disable TeX Live packages that cause issues
              texliveBasic = prev.hello;
              texliveMedium = prev.hello;
              texliveFull = prev.hello;
              
              # Fix for TBB regression causing Nix build failures on aarch64-darwin
              # See: https://github.com/nixos/nixpkgs/issues/418695
              # This can be removed once the upstream fix propagates
              tbb_2021 = prev.tbb_2021.overrideAttrs (oldAttrs: {
                version = "2021.12.0";
                src = prev.fetchFromGitHub {
                  owner = "oneapi-src";
                  repo = "oneTBB";
                  rev = "v2021.12.0";
                  sha256 = "sha256-yG/Fs+3f9hNKzZ8le+W7+JDZk9hMzPsVAzbq0yTcUTc=";
                };
              });
            })];
          }
        ];
      };
    in {
      # NixOS Configuration
      nixosConfigurations.EricPC = mkSystem "x86_64-linux" [
        ./nixos/configuration.nix
        {
          home-manager.users.eric = import ./home-manager/nixos.nix;
        }
      ];

      # nix-darwin Configuration
      darwinConfigurations.EricMac = mkDarwin "x86_64-darwin" [
        ./darwin/configuration.nix
        {
          home-manager.users.eric = import ./home-manager/darwin.nix;
        }
      ];

      # Also support Apple Silicon
      darwinConfigurations.EricMac-aarch64 = mkDarwin "aarch64-darwin" [
        ./darwin/configuration.nix
        {
          home-manager.users.eric = import ./home-manager/darwin.nix;
        }
      ];
    };
}

