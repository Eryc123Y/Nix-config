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
    # Keep jq as it's useful for JSON processing in general
    jq
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
    # Use micro as the default editor on macOS since kate is Linux-only
    EDITOR = "micro";
    # Homebrew is now managed by nix-darwin
    HOMEBREW_NO_AUTO_UPDATE = "1";
    # Ensure homebrew paths are available
    PATH = "$PATH:/opt/homebrew/bin:/usr/local/bin";
  };

}
