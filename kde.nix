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
    kdePackages.qtwayland       # Wayland支持
    kdePackages.qtsvg           # SVG渲染支持
    kdePackages.dolphin
    kdePackages.ark
    kdePackages.kate
    kdePackages.konsole
    kdePackages.okular
    kdePackages.kdeconnect-kde
    kdePackages.spectacle
    kdePackages.plasma-thunderbolt
    kdePackages.plasma-integration
    # plugins
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
    kdePackages.signon-kwallet-extension
    kdePackages.alpaka # ollama client
  ];

  environment.sessionVariables = {
  NIX_PROFILES = "${pkgs.lib.concatStringsSep " " (pkgs.lib.reverseList config.environment.profiles)}";
};

}
