# Base home-manager configuration
{ config, pkgs, lib, ... }:

{
  home.stateVersion = "25.11";
  home.username = "eric";
  
  # Import shared programming environment
  imports = [
    ./programming.nix
    ./shell.nix
    ./utils.nix
  ];
  
  # Basic user settings
  home.sessionVariables = {
    EDITOR = "kate"; # Change EDITOR to kate
  };
}
