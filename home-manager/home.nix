{ config, pkgs, ... }:

{
  home.stateVersion = "24.11"; # Adjust if needed
  home.username = "eric";
  home.homeDirectory = "/home/eric";
  #disabledModules = [
  #"modules/services/window-managers/labwc/labwc.nix"
  #"home-manager/modules/services/window-managers/labwc/labwc.nix"
  #"services/window-managers/labwc/labwc.nix"
  #];
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
