{ config, pkgs, ... }:

{
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    syntaxHighlighting.enable = true;


    ohMyZsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" "thefuck" ];
      theme = "agnoster";
    };

    shellAliases = {
      nx = "cd /etc/nixos/";
      hm = "code ~/.config/home-manager";
      desktop = "code ~/.local/share/applications/";
      monashvpn = "sudo gpclient connect vpn.gp.monash.edu";
      ghub = "cd ~/Documents/GitHub";
      manus = "cd ~/Documents/OpenManus";
      wechat = "wechat-uos";
      update = "sudo nix flake update";
      switch = "sudo nixos-rebuild switch --flake .";
      refresh = "killall plasmashell && kstart5 plasmashell";
    };
  };

  programs.thefuck = {
    enable = true;
    alias = "fuck";
  };

}
