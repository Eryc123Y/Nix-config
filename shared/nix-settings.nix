# Shared Nix settings for both NixOS and nix-darwin
{ config, pkgs, ... }:

{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "eric" ];
      auto-optimise-store = true;
    };
    
    # Garbage collection
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    
    optimise.automatic = true;
  };

  nixpkgs.config.allowUnfree = true;
}
