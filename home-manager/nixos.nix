# NixOS-specific home-manager configuration
{ config, pkgs, lib, ... }:

{
  imports = [
    ./shared/base.nix
    ./shared/programming-linux.nix
  ];

  home.homeDirectory = "/home/eric";

  # NixOS-specific packages (including GUI applications and IDEs)
  home.packages = with pkgs; [
    # Communication
    telegram-desktop
    discord
    teams-for-linux
    wechat-uos
    zoom-us
    
    # Browsers
    firefox
    
    # Development IDEs and GUI tools
    jetbrains-toolbox
    vscode
    code-cursor
    
    # Media and entertainment
    haruna
    
    # Productivity
    obsidian
    anki-bin
    zotero
    calibre
    typora
    
    # Creative tools
    figma-linux
    rnote
    xournalpp
    
    # File management and sync
    megasync
    
    # Gaming
    lutris
    bottles
    
    # Academic and scientific
    mathpix-snipping-tool
    lmstudio
    eudic # dictionary
    
    # Text processing
    texliveFull
    
    # Network and VPN
    clash-verge-rev
    baidupcs-go
    v2ray
    
    # AI and ML
    #ollama moved to shared/utils.nix
    
    # Archive tools
    arc_unpacker
    
    # Remote desktop and streaming
    sunshine
    deskreen
    
    # PDF viewers and document tools (KDE packages)
    kdePackages.okular
  ];

  # NixOS-specific programs
  programs = {
    # Add any NixOS-specific program configurations here
  };

  # NixOS-specific services
  services = {
    # Add any user services here
  };
}
