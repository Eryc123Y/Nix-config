{ config, pkgs, ... }:

{
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
    eval "$(${pkgs.thefuck}/bin/thefuck --alias)"
  '';

    ohMyZsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" ];
      theme = "robbyrussell";
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
  };

    history = {
      size = 10000;
      path = "$HOME/.zsh_history";
      ignoreAllDups = true;
      ignorePatterns = [ "rm *" "pkill *" "cp *" ];
    };
  };

}
