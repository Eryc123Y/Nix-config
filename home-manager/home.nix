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

  # 确保 Home Manager 的 GTK 和 dconf 模块启用
  gtk = {
    enable = true;
    theme = {
      name = "WhiteSur-dark"; # 假设你想用 WhiteSur 的暗色变体，请确认准确名称
      package = pkgs.whitesur-gtk-theme;
    };
    iconTheme = {
      name = "Adwaita"; # 或者你安装并想使用的其他图标主题名，例如 Papirus
      package = pkgs.gnome.adwaita-icon-theme; # 或者 pkgs.papirus-icon-theme
    };
    cursorTheme = {
       name = "Adwaita"; # 或者你想使用的光标主题名
       package = pkgs.gnome.adwaita-icon-theme; # 或者其他光标主题包
       size = 24;
    };
  };

  # 使用 home.pointerCursor 更佳，它会同时配置 GTK 和 X11
  home.pointerCursor = {
    name = "Adwaita"; # 替换为你想要的光标主题名
    package = pkgs.gnome.adwaita-icon-theme; # 替换为对应的包
    size = 24;
    gtk.enable = true;
    # x11.enable = true; # 如果需要
  };

  # 配置 dconf (例如启用扩展, 设置 Shell 主题)
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      # 设置 GTK 主题 (通常由 gtk.theme 处理，但有时需要 dconf)
      # gtk-theme = "WhiteSur-dark";
      # icon-theme = "Papirus"; # 如果使用 Papirus
      cursor-theme = "Adwaita"; # 如果使用 Adwaita 光标
      cursor-size = 24;
      color-scheme = "prefer-dark"; # 如果你想用暗色模式
    };

    "org/gnome/shell" = {
      # 启用你在 systemPackages 中安装的扩展
      # 注意：扩展的标识符需要准确
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "appindicatorsupport@rgcjonas.gmail.com" # AppIndicator 支持扩展的常见 ID
        # "dock-from-dash@micxgx.gmail.com" # Dock from Dash 的可能 ID (请确认)
        "clipboard-indicator@tudmotu.com"     # Clipboard Indicator 的可能 ID (请确认)
        "just-perfection-desktop@just-perfection" # Just Perfection 的可能 ID (请确认)
      ];
      # 如果你想收藏应用到 Dash
      # favorite-apps = [ 'firefox.desktop', 'org.gnome.Nautilus.desktop', ... ];
    };

    # 配置 User Themes 扩展以应用 Shell 主题
    "org/gnome/shell/extensions/user-theme" = {
      name = "WhiteSur-dark"; # 设置 Shell 主题名称 (需要与 GTK 主题包提供的 Shell 主题名匹配)
    };




  # Other top-level configurations...
}
