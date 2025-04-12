# configuration.nix
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  imports =
    [ 
       #<home-manager/nixos>
      ./hardware-configuration.nix
      ./jetbrains.nix
      ./android-studio.nix
      ./kde.nix
      ./unstable.nix
    ];

  environment.etc."usr/bin/gpservice".source = "/nix/store/krng12kmniwx7373xm0j1880p3671axz-globalprotect-openconnect-1.4.9/bin/gpservice";
  

  #home-manager.users.eric = import ./home-manager/home.nix;
  #home-manager.useGlobalPkgs = true;
  #home-manager.useUserPackages = true;

  hardware.cpu.amd.updateMicrocode = true;
  # Bootloader.

  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.configurationLimit = 3;
  boot.loader = {
  grub = {
    enable = true;
    efiSupport = true;
    devices = [ "nodev" ];
    useOSProber = true;
  };
  timeout = 5;
  efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot"; # Ensure this matches your ESP mount point
  };
  };
  boot.initrd.kernelModules = [ "nvidia" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  boot.kernelModules = [ "br_netfilter" "kvm-amd" ];
  
  virtualisation.libvirtd.enable = true;


  networking.hostName = "EricPC"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Srcurity 
  security.polkit.extraConfig = ''
  polkit.addRule(function(action, subject) {
    if (subject.isInGroup("wheel")) {
      return "yes";
    }
  });
'';


  # Services
  services.gvfs.enable = true;
  services.flatpak.enable = false;
#  systemd.services.flatpak-repo = {
#  wantedBy = [ "multi-user.target" ];
#  path = [ pkgs.flatpak ];
#  script = ''
#    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
#  '';
#  };

  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  networking.firewall.allowedTCPPorts = [ 11434 ];

  # Set your time zone.
  time.timeZone = "Asia/Kuala_Lumpur";
  time.hardwareClockInLocalTime = true;
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "all"];
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "ms_MY.UTF-8";
    LC_IDENTIFICATION = "ms_MY.UTF-8";
    LC_MEASUREMENT    = "ms_MY.UTF-8";
    LC_MONETARY       = "ms_MY.UTF-8";
    LC_NAME           = "ms_MY.UTF-8";
    LC_NUMERIC        = "ms_MY.UTF-8";
    LC_PAPER          = "ms_MY.UTF-8";
    LC_TELEPHONE      = "ms_MY.UTF-8";
    LC_TIME           = "en_AU.UTF-8";
  };

  nixpkgs.config.allowUnfree = true;

  # garbage collection
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 5d";
    dates = "Sun 19:00";
  };
  nix.optimise.automatic = true;

  # Graphics
  services.xserver.videoDrivers = [ "nvidia" "modesetting" ];
  services.xserver.screenSection = ''
  Option "TearFree" "true" ''; 
 
 hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver      
      vaapiVdpau
      vpl-gpu-rt
      libvdpau-va-gl
    ];
    enable32Bit = true;
  };
hardware = {
  nvidia = {
  open = false;
  modesetting.enable = true;
  powerManagement.enable = true;
  nvidiaSettings = true;
  package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  nvidia-container-toolkit.enable = true;

};

  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # sunshine settings
  services.sunshine = {
    enable = false;
    capSysAdmin = true;
    openFirewall = true;
  };

  # bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  
  # Docker Settings
  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "btrfs";
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
      daemon.settings = {
        features = {
          cdi = true;
        };
      };
      extraOptions = "--exec-opt native.cgroupdriver=cgroupfs";
    };
  };



  # steam
  services.printing.enable = true;
  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; 
  dedicatedServer.openFirewall = true; 
  localNetworkGameTransfers.openFirewall = true; 
  fontPackages = with pkgs; [ source-han-sans  ];
  extraPackages = with pkgs; [
    corefonts
    noto-fonts-cjk-sans
    source-han-sans
  ];

  extraCompatPackages = with pkgs; [
    gamemode
    gamescope
    dxvk
    vkd3d
    mangohud
  ];
  
};

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        desiredgov = "performance";
        defaultgov = "balance";
        inhibit_screensaver = true;
      };
    };
    enableRenice = true;
  };

  # Hyprland settings
  #programs.kitty.enable = true; # required for Hyprland
  #programs.hyprland = {
    #enable = false;
    #xwayland.enable = false;
    #withUWSM = true;
  #};

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.xserver.digimend.enable = true;
  
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.eric = {
    isNormalUser = true;
    description = "Eric";
    extraGroups = [ 
    "networkmanager" "wheel" "docker" "libvirtd" "adbusers" "audio" "video"
    ];
    packages = with pkgs; [
    flatpak
    ];
  };
  nix.settings.trusted-users = [ "root" "eric" ];

  


  
  # fcitx5

  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
       # plasma6Support = true;
        addons = with pkgs; [
          kdePackages.fcitx5-chinese-addons # For Chinese language support
          kdePackages.fcitx5-qt # Qt integration (optional for KDE users)
          kdePackages.fcitx5-configtool
          fcitx5-rime  # Optional: RIME engine for Traditional Chinese
          fcitx5-gtk            # GTK integration
          fcitx5-nord
        ];
      };
    };
  };
  environment.variables = {
  XMODIFIERS = "@im=fcitx";
};


#  systemd.user.services.ibus-daemon = {
#  enable = true;
#  description = "IBus Daemon";
#  serviceConfig.ExecStart = "${pkgs.ibus}/bin/ibus-daemon --panel disable #--xim";
#  wantedBy = [ "default.target" ];
#};


fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;

    packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        source-han-sans
        noto-fonts-extra
        noto-fonts-emoji
        noto-fonts-emoji-blob-bin
        wqy_zenhei 
        source-han-sans
        source-han-serif
        jetbrains-mono
    ];

    fontconfig.defaultFonts = {
      serif = ["source-han-serif"];
      sansSerif = ["source-han-sans"];
      monospace = ["jetbrains-mono"];
      emoji = ["noto-fonts-emoji"];
    };
};

  nixpkgs.config.permittedInsecurePackages = [
                "archiver-3.5.1"
  ];


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  # system utilities
  cachix p7zip-rar peazip
  gpauth gpclient
  micro
  cudaPackages.cudatoolkit cudaPackages.cudnn
  #unstable.ollama-cuda unstable.open-webui
  git jetbrains-toolbox docker-client
  wget appimage-run gearlever wine 
  wgnord mdbtools 
  # hyprland packages
  #hyprland kitty rofi-wayland waybar nautilus
  #dunst blueman networkmanagerapplet
  # extentions
  cifs-utils samba 
  # Home-manager
  home-manager
  # steam packages
  steam vulkan-tools protonup-qt
  steam-run  
  gamemode
  # shell utilities
  tldr thefuck neofetch nvtopPackages.full
  # global apps
  libreoffice google-chrome 
  linuxKernel.packages.linux_6_6.digimend
    ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.nixos-rebuild switch --upgrade
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
