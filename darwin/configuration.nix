# nix-darwin configuration for macOS
{ config, pkgs, ... }:

{
  imports = [
    ../shared/nix-settings.nix
  ];

  # Homebrew declarative configuration
  homebrew = {
    enable = true;
    
    # App installation preferences
    onActivation = {
      autoUpdate = true;        # Update homebrew itself
      upgrade = true;           # Upgrade all packages to latest versions
      cleanup = "zap";          # Uninstall packages not listed in config
      
      # Additional update options (optional)
      extraFlags = [
        "--verbose"             # Show detailed output during updates
      ];
    };
    
    # Global homebrew settings
    global = {
      brewfile = true;          # Use Brewfile for management
      lockfiles = false;        # Don't create lock files
    };
    
    # GUI Applications from your brew list
    casks = [
      # Cloud storage and sync
      "baidunetdisk"
      "google-drive"
      "nutstore"
      
      # Browsers
      "firefox"
      "google-chrome"
      
      # Development tools
      "github"
      "jetbrains-toolbox"
      "visual-studio-code"
      "cursor"
      
      # Design and productivity
      "canva" 
      "figma"
      "obsidian"
      "typora"
      
      # Communication
      "qq"
      "wechat"
      "whatsapp"
      
      # AI and productivity
      "chatgpt"
      "cherry-studio"
      
      # Network and system tools
      "clash-verge-rev"
      "stats"
      
      # Office and productivity
      "microsoft-office"
      "microsoft-auto-update"
      
      # Gaming and entertainment
      "steam"
      
      # Academic and research
      "zotero"
    ];
    
    # Formulae (command-line tools) - keeping empty for now since most are handled by nix
    brews = [
      # Add any CLI tools here if needed
    ];
    
    # Mac App Store apps (if any)
    masApps = {
      # Example: "Xcode" = 497799835;
    };
  };

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

  # macOS system-level shell configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    
    # Note: User aliases are handled by home-manager shared configuration
    # This only configures system-level ZSH settings
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
