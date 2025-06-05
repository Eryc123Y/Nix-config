# Shared Nix settings for both NixOS and nix-darwin
{ config, pkgs, ... }:

{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "eric" ];
      # Note: auto-optimise-store is problematic on macOS, use optimise.automatic instead
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
