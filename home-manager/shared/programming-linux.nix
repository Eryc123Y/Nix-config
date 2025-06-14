# Linux-specific programming packages
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Linux-specific development tools
    valgrind  # Memory debugging (not available on macOS)
    strace    # System call tracer
    
    # packages with nix-darwin compatibility issues
    quarto
    R
    texliveFull
    
    # Communication apps with Linux dependencies
    telegram-desktop  # Has KDE dependencies not available on macOS
    
  ];
}
