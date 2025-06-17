{ config, pkgs, ... }:

{
  # GNOME
  services.desktopManager.gnome = {
  	enable = true;
  	#extraGSettingsOverridePackages = [ pkgs.mutter ];
          #extraGSettingsOverrides = ''
        #[org.gnome.mutter]
        #experimental-features=['scale-monitor-framebuffer', 'xwayland-native-scaling']
      #'';
  };
  services.unclutter.enable = false;
  
  services.displayManager.gdm = {
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
    whitesur-gtk-theme
    gnome-session
    gnome-randr
    gnomeExtensions.user-themes
    gnomeExtensions.appindicator 
    gnomeExtensions.dock-from-dash
    gnomeExtensions.runcat # performance monitor
    gnomeExtensions.vitals
    gnomeExtensions.force-quit
    gnomeExtensions.clipboard-indicator 
    gnomeExtensions.just-perfection
    gnomeExtensions.kimpanel
    gnomeExtensions.astra-monitor
    gnome-control-center
  ];
}
