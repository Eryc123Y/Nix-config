{ config, pkgs, ... }:

{
  home.stateVersion = "24.11"; # Adjust if needed
  home.username = "eric";
  home.homeDirectory = "/home/eric";
  nixpkgs.config.allowUnfree = true;

  programs.vscode = {
    enable = true;
    # Additional configuration options available
  };

  # Import your modular configs
  imports = [
    ./modules/shell.nix
    ./modules/editors.nix
    ./modules/applications.nix
    ./modules/devenv.nix
    ./modules/python.nix
    ./modules/java.nix
    ./modules/C.nix
    ./modules/R.nix
    #./modules/sql.nix
  ];




  # Other top-level configurations...
}
