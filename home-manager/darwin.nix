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
        credential.helper = "osxkeychain";
      };
    };
  };

  # macOS-specific environment variables
  home.sessionVariables = {
    # Disable homebrew auto-update since brew is already installed
    HOMEBREW_NO_AUTO_UPDATE = "1";
  };

  # Override ZSH aliases for macOS
  programs.zsh.shellAliases = {
    # macOS-specific configuration directory
    nx = "cd ~/.config/nix-darwin/";
  };
}
