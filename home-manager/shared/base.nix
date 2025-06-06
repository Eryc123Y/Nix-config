# Base home-manager configuration
{ config, pkgs, lib, ... }:

{
  home.stateVersion = "25.11";
  home.username = "eric";
  
  # Import shared programming environment
  imports = [
    ./programming.nix
    ./zsh.nix
  ];
  
  # Basic user settings
  home.sessionVariables = {
    EDITOR = "micro";
  };
}
