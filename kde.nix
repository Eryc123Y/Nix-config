{ config, pkgs, ... }:


#let
#  signon-plugin-oauth2 = pkgs.callPackage ./pkgs/signon/signon-plugin-oauth2.nix {};
#   signond = pkgs.callPackage ./pkgs/signon/signond.nix {
#    withOAuth2 = true;
#    inherit signon-plugin-oauth2;
#    withKWallet = true;
#    signon-kwallet-extension = pkgs.kdePackages.signon-kwallet-extension;
#  };
#
#  signon-ui = pkgs.callPackage ./pkgs/signon/signon-ui.nix {};
#in
{
  # KDE Plasma
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  # unmaintained
  #services.gsignond = {
   # enable = false;
    #plugins = [ signon-plugin-oauth2 ];
  #};
  

  # XDG portal
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde pkgs.libsForQt5.xdg-desktop-portal-kde ];
    config.common.default = [ "kde" ];
  };

  environment.systemPackages = with pkgs; [
    kdePackages.qtwayland       # Wayland支持
    kdePackages.qtsvg           # SVG渲染支持
    kdePackages.dolphin
    kdePackages.kdeconnect-kde
    kdePackages.plasma-thunderbolt
    kdePackages.plasma-integration
    # plugins & dependency
    kdePackages.analitza
    kdePackages.frameworkintegration
    kdePackages.qtstyleplugin-kvantum
    kdePackages.kde-gtk-config
    kdePackages.kaccounts-integration
    kdePackages.kaccounts-providers
    kdePackages.kdepim-addons
    kdePackages.kio             # 基础KIO框架
    kdePackages.kio-fuse        # 允许挂载远程位置
    kdePackages.kio-extras      # 添加额外协议和功能
    kdePackages.kio-admin       # 用于Dolphin中的管理员功能
    kdePackages.kdegraphics-thumbnailers  # 图像缩略图支持
    kdePackages.breeze-icons              # 标准KDE图标主题
    kdePackages.kservice                  # 服务管理
    shared-mime-info                      # 文件类型关联
    kdePackages.kio-gdrive # g-drive integration
    kdePackages.kontact
    kdePackages.akonadi
    kdePackages.kdepim-runtime
    kdePackages.bluez-qt # widget dependency
    kdePackages.signond # online account integration dependency
    libsignon-glib
    libsForQt5.qoauth # Qt library for OAuth authentication
    #kdePackages.signon-kwallet-extension
    kdePackages.alpaka # ollama client
    # app
    kdePackages.discover
    kdePackages.ktorrent
    kdePackages.ark
    kdePackages.kate
    kdePackages.konsole
    kdePackages.okular
    kdePackages.spectacle
    kdePackages.filelight
    kdePackages.partitionmanager
    kdePackages.yakuake
    kdePackages.ksystemlog
    kdePackages.kcharselect
    kdePackages.kweather
    kdePackages.kget
    kdePackages.kalgebra
  ];

  environment.sessionVariables = {
  NIX_PROFILES = "${pkgs.lib.concatStringsSep " " (pkgs.lib.reverseList config.environment.profiles)}";
};

}
