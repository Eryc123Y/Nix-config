{ config, pkgs, ... }:

{
  # GNOME
  services.xserver.desktopManager.gnome = {
  	enable = true;
  	#extraGSettingsOverridePackages = [ pkgs.mutter ];
          #extraGSettingsOverrides = ''
        #[org.gnome.mutter]
        #experimental-features=['scale-monitor-framebuffer', 'xwayland-native-scaling']
      #'';
  };
  services.unclutter.enable = false;
  
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  # XDG portal
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    config.common.default = [ "gnome" ];
  };

  # GNOME Package
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.user-themes 
    gnomeExtensions.appindicator 
    gnomeExtensions.dock-from-dash
    gnomeExtensions.clipboard-indicator 
    gnomeExtensions.just-perfection
    whitesur-gtk-theme
    gnome-session
    gnome-randr
    gnomeExtensions.user-themes
    gnomeExtensions.appindicator 
    gnomeExtensions.dock-from-dash
    gnomeExtensions.clipboard-indicator 
    gnomeExtensions.just-perfection
  ];
}
