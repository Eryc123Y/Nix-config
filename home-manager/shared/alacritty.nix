# Cross-platform Alacritty terminal configuration
{ config, pkgs, lib, ... }:

{
  programs.alacritty = {
    enable = true;
    
    settings = {
      # Environment variables
      env = {
        TERM = "xterm-256color";
      };
      
      # Window configuration
      window = {
        # Window dimensions (changes require restart)
        dimensions = {
          columns = 0;  # 0 means auto-detect
          lines = 0;    # 0 means auto-detect
        };
        
        # Window position (changes require restart)
        # position = { x = 0; y = 0; };
        
        # Window padding (changes require restart)
        padding = {
          x = 8;
          y = 8;
        };
        
        # Spread additional padding evenly around the terminal content
        dynamic_padding = false;
        
        # Window decorations
        decorations = if pkgs.stdenv.isDarwin then "buttonless" else "full";
        
        # Background opacity
        opacity = 0.95;
        
        # Startup mode (changes require restart)
        startup_mode = "Windowed";  # Windowed, Maximized, Fullscreen
        
        # Window title
        title = "Alacritty";
        
        # Dynamic title
        dynamic_title = true;
        
        # Window class (Linux/BSD only)
        class = lib.mkIf pkgs.stdenv.isLinux {
          instance = "Alacritty";
          general = "Alacritty";
        };
        
        # GTK theme variant (Linux/BSD only)
        gtk_theme_variant = lib.mkIf pkgs.stdenv.isLinux "dark";
      };
      
      # Scrolling
      scrolling = {
        # Maximum number of lines in the scrollback buffer
        history = 10000;
        
        # Scrolling distance multiplier
        multiplier = 3;
      };
      
      # Font configuration
      font = {
        # Normal (roman) font face
        normal = {
          family = "JetBrains Mono";
          style = "Regular";
        };
        
        # Bold font face
        bold = {
          family = "JetBrains Mono";
          style = "Bold";
        };
        
        # Italic font face
        italic = {
          family = "JetBrains Mono";
          style = "Italic";
        };
        
        # Bold italic font face
        bold_italic = {
          family = "JetBrains Mono";
          style = "Bold Italic";
        };
        
        # Point size
        size = if pkgs.stdenv.isDarwin then 14.0 else 12.0;
        
        # Offset is the extra space around each character
        offset = {
          x = 0;
          y = 0;
        };
        
        # Glyph offset determines the locations of the glyphs within their cells
        glyph_offset = {
          x = 0;
          y = 0;
        };
        
        # Use built-in font for box drawing characters
        builtin_box_drawing = true;
      };
      
      # Bell configuration
      bell = {
        animation = "EaseOutExpo";
        duration = 0;
        color = "#ffffff";
        command = "None";
      };
      
      # Selection configuration
      selection = {
        # This string contains all characters that are used as separators for "semantic words" in Alacritty
        semantic_escape_chars = ",│`|:\"' ()[]{}<>\\t";
        
        # When set to true, selected text will be copied to the primary clipboard
        save_to_clipboard = true;
      };
      
      # Cursor configuration
      cursor = {
        # Cursor style
        style = {
          shape = "Block";  # Block, Underline, Beam
          blinking = "Never";  # Never, Off, On, Always
        };
        
        # Vi mode cursor style
        vi_mode_style = "None";
        
        # Cursor blinking interval in milliseconds
        blink_interval = 750;
        
        # If this is true, the cursor will be rendered as a hollow box when the window is not focused
        unfocused_hollow = true;
        
        # Thickness of the cursor relative to the cell width as floating point number from 0.0 to 1.0
        thickness = 0.15;
      };
      
      # Terminal configuration
      terminal = {
        # Controls the ability to write to the terminal with programs
        osc52 = "CopyPaste";  # Disabled, OnlyCopy, OnlyPaste, CopyPaste
      };
      
      # Live config reload (changes require restart)
      live_config_reload = true;
      
      # Shell program and its arguments
      shell = if pkgs.stdenv.isDarwin then {
        program = "${pkgs.zsh}/bin/zsh";
        args = [ "--login" ];
      } else {
        program = "${pkgs.zsh}/bin/zsh";
        args = [ "--login" ];
      };
      
      # Working directory
      working_directory = "None";  # "None" or path
      
      # Offer IPC using alacritty msg (unix only)
      ipc_socket = lib.mkIf pkgs.stdenv.isLinux true;
      
      # Color scheme (Tokyo Night theme)
      colors = {
        # Default colors
        primary = {
          background = "#1a1b26";
          foreground = "#c0caf5";
          dim_foreground = "#9a9eab";
          bright_foreground = "#ffffff";
        };
        
        # Cursor colors
        cursor = {
          text = "#1a1b26";
          cursor = "#c0caf5";
        };
        
        # Vi mode cursor colors
        vi_mode_cursor = {
          text = "#1a1b26";
          cursor = "#c0caf5";
        };
        
        # Search colors
        search = {
          matches = {
            foreground = "#1a1b26";
            background = "#a9b1d6";
          };
          focused_match = {
            foreground = "#1a1b26";
            background = "#9ece6a";
          };
        };
        
        # Hint colors
        hints = {
          start = {
            foreground = "#1a1b26";
            background = "#e0af68";
          };
          end = {
            foreground = "#1a1b26";
            background = "#a9b1d6";
          };
        };
        
        # Selection colors
        selection = {
          text = "CellForeground";
          background = "#283457";
        };
        
        # Normal colors
        normal = {
          black = "#15161e";
          red = "#f7768e";
          green = "#9ece6a";
          yellow = "#e0af68";
          blue = "#7aa2f7";
          magenta = "#bb9af7";
          cyan = "#7dcfff";
          white = "#a9b1d6";
        };
        
        # Bright colors
        bright = {
          black = "#414868";
          red = "#f7768e";
          green = "#9ece6a";
          yellow = "#e0af68";
          blue = "#7aa2f7";
          magenta = "#bb9af7";
          cyan = "#7dcfff";
          white = "#c0caf5";
        };
        
        # Dim colors
        dim = {
          black = "#15161e";
          red = "#f7768e";
          green = "#9ece6a";
          yellow = "#e0af68";
          blue = "#7aa2f7";
          magenta = "#bb9af7";
          cyan = "#7dcfff";
          white = "#a9b1d6";
        };
        
        # Indexed colors
        indexed_colors = [
          { index = 16; color = "#ff9e64"; }
          { index = 17; color = "#db4b4b"; }
        ];
      };
      
      # Keyboard bindings
      keyboard.bindings = [
        # Copy/Paste
        { key = "V"; mods = if pkgs.stdenv.isDarwin then "Command" else "Control|Shift"; action = "Paste"; }
        { key = "C"; mods = if pkgs.stdenv.isDarwin then "Command" else "Control|Shift"; action = "Copy"; }
        { key = "Insert"; mods = "Shift"; action = "PasteSelection"; }
        
        # Search
        { key = "F"; mods = if pkgs.stdenv.isDarwin then "Command" else "Control|Shift"; action = "SearchForward"; }
        { key = "B"; mods = if pkgs.stdenv.isDarwin then "Command" else "Control|Shift"; action = "SearchBackward"; }
        
        # New window/tab
        { key = "Return"; mods = if pkgs.stdenv.isDarwin then "Command" else "Control|Shift"; action = "SpawnNewInstance"; }
        { key = "N"; mods = if pkgs.stdenv.isDarwin then "Command" else "Control|Shift"; action = "SpawnNewInstance"; }
        
        # Font size adjustment
        { key = "Plus"; mods = if pkgs.stdenv.isDarwin then "Command" else "Control"; action = "IncreaseFontSize"; }
        { key = "Minus"; mods = if pkgs.stdenv.isDarwin then "Command" else "Control"; action = "DecreaseFontSize"; }
        { key = "Key0"; mods = if pkgs.stdenv.isDarwin then "Command" else "Control"; action = "ResetFontSize"; }
        
        # Scrolling
        { key = "K"; mods = if pkgs.stdenv.isDarwin then "Command" else "Control|Shift"; action = "ScrollLineUp"; }
        { key = "J"; mods = if pkgs.stdenv.isDarwin then "Command" else "Control|Shift"; action = "ScrollLineDown"; }
        { key = "PageUp"; mods = "Shift"; action = "ScrollPageUp"; }
        { key = "PageDown"; mods = "Shift"; action = "ScrollPageDown"; }
        { key = "Home"; mods = "Shift"; action = "ScrollToTop"; }
        { key = "End"; mods = "Shift"; action = "ScrollToBottom"; }
        
        # Clear screen/history
        { key = "K"; mods = if pkgs.stdenv.isDarwin then "Command" else "Control"; action = "ClearHistory"; }
        { key = "L"; mods = if pkgs.stdenv.isDarwin then "Command" else "Control"; action = "ClearLogNotice"; }
        
        # Vi mode
        { key = "Space"; mods = "Shift|Control"; action = "ToggleViMode"; }
        
        # Toggle fullscreen
        { key = "Return"; mods = if pkgs.stdenv.isDarwin then "Command|Control" else "Alt"; action = "ToggleFullscreen"; }
        
        # Quit
        { key = "Q"; mods = if pkgs.stdenv.isDarwin then "Command" else "Control|Shift"; action = "Quit"; }
        
        # Hide (macOS only)
      ] ++ lib.optionals pkgs.stdenv.isDarwin [
        { key = "H"; mods = "Command"; action = "Hide"; }
        { key = "M"; mods = "Command"; action = "Minimize"; }
        { key = "W"; mods = "Command"; action = "Quit"; }
      ];
      
      # Mouse bindings
      mouse = {
        # Click settings
        double_click = { threshold = 300; };
        triple_click = { threshold = 300; };
        
        # If this is true, the cursor is temporarily hidden when typing
        hide_when_typing = false;
        
        bindings = [
          { mouse = "Middle"; action = "PasteSelection"; }
          { mouse = "Right"; action = "ExpandSelection"; }
          { mouse = "Left"; mods = if pkgs.stdenv.isDarwin then "Command" else "Control"; action = "ExpandSelection"; }
        ];
      };
      
      # Hints for URLs, paths, etc.
      hints = {
        # Keys used for the hint labels
        alphabet = "jfkdls;ahgurieowpq";
        
        # List with all available hints
        enabled = [
          {
            # Regex for URLs
            regex = "(ipfs:|ipns:|magnet:|mailto:|gemini://|gopher://|https://|http://|news:|file:|git://|ssh:|ftp://)[^\\u0000-\\u001F\\u007F-\\u009F<>\"\\s{-}\\^⟨⟩`]+";
            hyperlinks = true;
            post_processing = true;
            persist = false;
            action = "Open";
            command = if pkgs.stdenv.isDarwin then "open" else "${pkgs.xdg-utils}/bin/xdg-open";
            binding = { key = "U"; mods = "Control|Shift"; };
            mouse = { mods = "None"; enabled = true; };
          }
          {
            # Regex for file paths
            regex = "(\\b|\\s|^)(/[^\\s<>\"'\\(\\)\\[\\]{}]+)";
            action = "Open";
            command = if pkgs.stdenv.isDarwin then "open" else "${pkgs.xdg-utils}/bin/xdg-open";
            binding = { key = "F"; mods = "Control|Shift"; };
          }
        ];
      };
      
      # Debug options
      debug = {
        render_timer = false;
        persistent_logging = false;
        log_level = "Warn";  # Off, Error, Warn, Info, Debug, Trace
        renderer = if pkgs.stdenv.isDarwin then "None" else "None";  # glsl3, gles2, gles2_pure, None
        print_events = false;
        highlight_damage = false;
        prefer_egl = false;
      };
    };
  };
}
