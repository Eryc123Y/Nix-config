{ config, pkgs, ... }:

{
  # Add Python packages to the user's environment
home.packages = [
  pkgs.conda
  pkgs.pandoc
];
}