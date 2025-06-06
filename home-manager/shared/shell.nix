{ config, pkgs, lib, ... }:

{
  programs.kitty = {
  enable = true;

  # Kitty settings: these are mapped directly to kitty.conf options
  settings = {
    font_family = "JetBrainsMono Nerd Font";
    font_size = 14;
    # Appearance
    background_opacity = "0.90";
    enable_audio_bell = false;
    confirm_os_window_close = 0;
    window_padding_width = 10;
    tab_bar_edge = "top";
    tab_bar_style = "powerline";
    # Performance and behavior
    repaint_delay = 10;
    input_delay = 1;
    sync_to_monitor = true;
    # Clipboard and mouse
    copy_on_select = true;
    paste_actions = "quote-urls-at-prompt,confirm";
    mouse_hide_wait = "-1.0";
    # Scrolling
    scrollback_lines = 10000;
    wheel_scroll_multiplier = 5;
    # Colors (choose a theme you like, or set via 'theme' option below)
    foreground = "#d8dee9";
    background = "#2e3440";
    selection_foreground = "#2e3440";
    selection_background = "#d8dee9";
    # Cursor
    cursor_shape = "beam";
    cursor_blink_interval = 0;
    };
  # Note: Using custom colors above instead of theme to avoid themeFile deprecation
  };

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
        "command-not-found"
        "history-substring-search"
        "colored-man-pages"
      ];
      theme = "agnoster";
    };

    initExtra = lib.mkIf pkgs.stdenv.isDarwin ''
      # Custom prompt context for Agnoster theme on Darwin
      # This changes the displayed hostname to 'nix-darwin'
      # and sets the user@host segment to white text on a black background.
      prompt_context() {
        if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
          prompt_segment black white "%(!.%S%F{white}%n%f%s.%S%F{white}@nix-darwin%f%s)"
        fi
      }
    '';

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
      
      # Configuration management (platform-specific)
      nx = if pkgs.stdenv.isDarwin then "cd /Users/eric/nix" else "cd /etc/nixos/";
      
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
      switch = "sudo darwin-rebuild switch --flake '.#EricMac-aarch64'";
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
