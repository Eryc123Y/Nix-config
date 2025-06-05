# Base home-manager configuration
{ config, pkgs, lib, ... }:

{
  home.stateVersion = "24.11";
  home.username = "eric";
  
  # Import shared programming environment
  imports = [
    ./programming.nix
  ];
  
  # Basic user settings
  home.sessionVariables = {
    EDITOR = "micro";
  };
  
  # Shell configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      ll = "ls -la";
      la = "ls -la";
      ".." = "cd ..";
      "..." = "cd ../..";
    };
  };
}
