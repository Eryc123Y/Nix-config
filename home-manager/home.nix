{ config, pkgs, lib, ... }:

{
  
  home.stateVersion = "24.11"; # Adjust if needed
  home.username = "eric";
  home.homeDirectory = "/home/eric";
  #disabledModules = [
  #"modules/services/window-managers/labwc/labwc.nix"
  #"home-manager/modules/services/window-managers/labwc/labwc.nix"
  #"services/window-managers/labwc/labwc.nix"
  #];
  #services.mako.enable = true;
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

  # Ensure Home Manager's GTK and dconf modules are enabled
  gtk = {
    enable = true;
    theme = {
      name = "WhiteSur-dark"; # Assuming you want the dark variant of WhiteSur, please confirm the exact name
      package = pkgs.whitesur-gtk-theme;
    };
    iconTheme = {
      name = "Adwaita"; # Or another icon theme name you installed and want to use, e.g., Papirus
      package = pkgs.adwaita-icon-theme; # Or pkgs.papirus-icon-theme
    };
    cursorTheme = {
       name = "Adwaita"; # Or the cursor theme name you want to use
       package = pkgs.adwaita-icon-theme; # Or another cursor theme package
       size = 24;
    };
  };

  # Using home.pointerCursor is better as it configures both GTK and X11
  home.pointerCursor = {
    name = "Adwaita"; # Replace with the desired cursor theme name
    package = pkgs.adwaita-icon-theme; # Replace with the corresponding package
    size = 24;
    gtk.enable = true;
    # x11.enable = true; # If needed
  };

  # Configure dconf (e.g., enable extensions, set Shell theme)
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      # Set GTK theme (usually handled by gtk.theme, but sometimes dconf is needed)
      # gtk-theme = "WhiteSur-dark";
      # icon-theme = "Papirus"; # If using Papirus
      cursor-theme = "Adwaita"; # If using Adwaita cursor
      cursor-size = 24;
      color-scheme = "prefer-dark"; # If you want to use dark mode
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      # Enable extensions installed via systemPackages
      # Note: The extension identifiers need to be accurate
      enabled-extensions = [];
      # If you want to favorite apps to the Dash
      # favorite-apps = [ 'firefox.desktop', 'org.gnome.Nautilus.desktop', ... ];
    };

    # Configure the User Themes extension to apply the Shell theme
    "org/gnome/shell/extensions/user-theme" = {
      name = "WhiteSur-dark"; # Set the Shell theme name (needs to match the Shell theme name provided by the GTK theme package)
    };
  };


  # Other top-level configurations...
}
