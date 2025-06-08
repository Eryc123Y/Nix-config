# This file stores shared tools and utilities
{ config, pkgs, ... }:

{
  # Shared tools and utilities for home-manager
  home.packages = with pkgs; [
    ollama
    
    # command-line utilities
    kitty # setting under shell.nix

    # video editing
    openshot-qt

    # communication
    telegram-desktop
  ];
}