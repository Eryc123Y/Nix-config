{ config, pkgs, ... }:

{
  # KDE Plasma
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  

  # XDG portal
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-kde ];
    config.common.default = [ "kde" ];
  };

  # KDE packages
  environment.systemPackages = with pkgs; [
    kdePackages.dolphin
    kdePackages.ark
    kdePackages.kate
    kdePackages.konsole
    kdePackages.okular
    kdePackages.kdeconnect-kde
    # keyboard
    kdePackages.spectacle
    kdePackages.plasma-thunderbolt
    kdePackages.plasma-integration
    # plugins
    kdePackages.kaccounts-integration
    kdePackages.kaccounts-providers
    kdePackages.kdepim-addons
    kdePackages.kio-gdrive
    kdePackages.kontact
    kdePackages.akonadi
    kdePackages.kdepim-runtime
    kdePackages.bluez-qt
    kdePackages.signond
    kdePackages.signon-kwallet-extension
    kdePackages.alpaka # ollama client
  ];

  environment.sessionVariables = {
  NIX_PROFILES = "${pkgs.lib.concatStringsSep " " (pkgs.lib.reverseList config.environment.profiles)}";
};

}
