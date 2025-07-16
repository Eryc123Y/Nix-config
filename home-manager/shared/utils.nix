# This file stores shared tools and utilities
{ config, pkgs, ... }:

{
  # Shared tools and utilities for home-manager
  home.packages = with pkgs; [
    ollama
    
    # command-line utilities
    kitty # setting under shell.nix

    pgmodeler # PostgreSQL database modeler
    pgadmin4-desktopmode
    postgresql_17_jit


    # communication - moved to platform-specific configs
    # telegram-desktop  # Moved to Linux-specific config due to KDE dependencies
  ];
}