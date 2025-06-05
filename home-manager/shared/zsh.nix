{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    # Oh My Zsh configuration
    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "git" 
        "sudo" 
        "docker" 
        "nix-shell"
        "command-not-found"
        "history-substring-search"
        "colored-man-pages"
      ];
      theme = "agnoster";
    };

    # Cross-platform aliases
    shellAliases = {
      # Navigation
      ll = "ls -la";
      la = "ls -la";
      ".." = "cd ..";
      "..." = "cd ../..";
      
      # Nix operations
      gc = "nix-collect-garbage";
      update = "nix flake update";
      check = "nix flake check";
      
      # Configuration management (platform-specific, can be overridden)
      nx = lib.mkDefault "cd /etc/nixos/";  # Can be overridden per platform
      
      # Development shortcuts
      ghub = "cd ~/Documents/GitHub";
      
      # Quick editing
      desktop = lib.mkIf pkgs.stdenv.isLinux "code ~/.local/share/applications/";
      
      # Common utilities
      grep = "grep --color=auto";
      mkdir = "mkdir -p";
      
      # Platform-specific aliases (conditional)
    } // lib.optionalAttrs pkgs.stdenv.isLinux {
      # Linux-specific aliases
      switch = "sudo nixos-rebuild switch --flake .";
      monashvpn = "sudo gpclient connect vpn.gp.monash.edu";
      wechat = "wechat-uos";
      refresh = "killall plasmashell && kstart5 plasmashell";
    } // lib.optionalAttrs pkgs.stdenv.isDarwin {
      # macOS-specific aliases
      switch = "darwin-rebuild switch --flake .";
      brew-update = "brew update && brew upgrade";
    };

    # History configuration
    history = {
      size = 10000;
      save = 10000;
      share = true;
      ignoreDups = true;
      ignoreSpace = true;
      extended = true;
    };

    # Additional configuration
    initContent = ''
      # Set EDITOR
      export EDITOR="micro"
      
      # Custom prompt info for nix-shell
      if [[ -n "$IN_NIX_SHELL" ]]; then
        export PS1="(nix-shell) $PS1"
      fi
      
      # Platform-specific PATH additions
      ${lib.optionalString pkgs.stdenv.isLinux ''
        # Linux-specific PATH additions
        export PATH="$HOME/.local/bin:$PATH"
      ''}
      
      ${lib.optionalString pkgs.stdenv.isDarwin ''
        # macOS-specific PATH additions
        export PATH="/opt/homebrew/bin:$PATH"
        export PATH="/usr/local/bin:$PATH"
      ''}
      
      # Enhanced zsh completion system
      autoload -Uz compinit
      if [[ -n ''${ZDOTDIR:-''${HOME}}/.zcompdump(#qN.mh+24) ]]; then
        compinit
      else
        compinit -C
      fi
      
      # Case-insensitive completion
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
      
      # Better completion for kill command
      zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
      
      # Enable directory stack
      setopt AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT
      
      # Better globbing
      setopt EXTENDED_GLOB
      
      # Don't beep on error
      setopt NO_BEEP
    '';
  };
}
