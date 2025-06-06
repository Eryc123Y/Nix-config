# macOS-specific home-manager configuration (programming environment only)
{ config, pkgs, lib, ... }:

{
  imports = [
    ./shared/base.nix
    # Note: programming-linux.nix is not imported here as it contains Linux-specific tools
  ];

  home.homeDirectory = "/Users/eric";

  # macOS-specific packages (programming environment only, no GUI apps)
  home.packages = with pkgs; [
    # macOS-specific command-line utilities
    # (Most programming tools are already in shared/programming.nix)
  ];

  # macOS-specific programs
  programs = {
    # Git configuration with macOS-specific settings
    git = {
      enable = true;
      extraConfig = {
        #credential.helper = "osxkeychain";
      };
    };
  };


  # ollama settings
  services.ollama = {
    enable = true;
  };


  # macOS-specific environment variables
  home.sessionVariables = {
    # Homebrew is now managed by nix-darwin
    HOMEBREW_NO_AUTO_UPDATE = "1";
    # Ensure homebrew paths are available
    PATH = "$PATH:/opt/homebrew/bin:/usr/local/bin";
  };
}
