{ config, pkgs, ... }:

{
  # System-level ZSH configuration for NixOS (minimal, user config handled by home-manager)
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    syntaxHighlighting.enable = true;
    
    # Only system-wide settings here - user aliases are in home-manager
    shellInit = ''
      # System-wide ZSH initialization
      # User-specific settings are handled by home-manager
    '';
  };
}
