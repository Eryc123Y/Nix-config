# Linux-specific programming packages
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Linux-specific development tools
    valgrind  # Memory debugging (not available on macOS)
    strace    # System call tracer
  ];
}
