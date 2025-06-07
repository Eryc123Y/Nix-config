# nix-darwin configuration for macOS
{ config, pkgs, ... }:

{
  imports = [
    ../shared/nix-settings.nix
    ./homebrew.nix
  ];

  # macOS system settings
  system = {
    stateVersion = 4;
    primaryUser = "eric";  # Required for system defaults to work
    
    defaults = {
      dock = {
        autohide = true;
        orientation = "bottom";
        show-recents = false;
        tilesize = 48;
      };
      
      finder = {
        AppleShowAllExtensions = true;
        ShowPathbar = true;
        ShowStatusBar = true;
      };
      
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        InitialKeyRepeat = 14;
        KeyRepeat = 1;
      };
    };
  };

  # Fix for GID mismatch
  ids.gids.nixbld = 350;

  # macOS system-level programs configuration
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      enableBashCompletion = true;
      
      # Note: User aliases are handled by home-manager shared configuration
      # This only configures system-level ZSH settings
    };
  };

  # Services configuration
  services = {
    # Simple hotkey daemon for macOS
    skhd = {
      enable = true;
      skhdConfig = ''
        # Open Kitty terminal with ctrl + t
        ctrl - t : /etc/profiles/per-user/eric/bin/kitty
      '';
    };
  };

  # Essential packages for development (no GUI apps)
  environment.systemPackages = with pkgs; [
    # Essential development tools
    git
    curl
    wget
    
    # Text editors (terminal-based)
    micro
    
    # Basic utilities
    coreutils
    findutils
    gnused
    gnutar
    gzip
    
    # Development tools that are commonly needed system-wide
    docker
  ];

  # Services - nix-daemon is automatically enabled
  # services.nix-daemon.enable = true;  # No longer needed

  # User configuration
  users.users.eric = {
    name = "eric";
    home = "/Users/eric";
    shell = pkgs.zsh;
  };

  # Fonts (basic programming fonts)
  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    source-han-sans
    powerline-fonts # Powerline fonts for terminal for zsh theme
  ];

  # Enable Touch ID for sudo (if available)
  # Note: This setting may not be available in all nix-darwin versions
  # security.pam.enableSudoTouchId = true;
}
