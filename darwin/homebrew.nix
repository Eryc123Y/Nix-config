# Homebrew configuration for macOS
{ config, pkgs, ... }:

{
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

      # Learning and education
      "eudic"
      "pdf-expert"
      
      # Browsers & web clients
      "firefox"
      "google-chrome"
      "bilibili"
      
      # Development tools
      "github"
      "jetbrains-toolbox"
      "visual-studio-code"
      "cursor"
      "kate"

      # macUI
      #"sketchybar" see home manager
      "font-hack-nerd-font"
      
      # Design and productivity
      "canva" 
      "figma"
      "obsidian"
      "typora"

      # Communication
      "qq"
      "wechat"
      "whatsapp"
      "microsoft-teams"
      "telegram-desktop"
      
      # AI and productivity
      "chatgpt"
      "cherry-studio"
      
      # Network and system tools
      "clash-verge-rev"
      #"stats"
      
      # Office and productivity
      "zoom"
      "slack"
      "microsoft-auto-update"
      
      # Gaming and entertainment
      "steam"
      
      # Academic and research
      "zotero"
      
      # Statistical computing and analysis
      "r"
      "rstudio"
      
      # Document preparation
      "mactex"  # Full MacTeX distribution includes TeXLive
    ];
    
    # Formulae (command-line tools) - keeping empty for now since most are handled by nix
    brews = [
      # AI and ML tools are now handled by nixpkgs
    ];
    
    # Mac App Store apps (if any)
    masApps = {
      # Example: "Xcode" = 497799835;
    };
  };
}
