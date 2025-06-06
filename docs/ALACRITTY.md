# Alacritty Terminal Configuration

This document describes the cross-platform Alacritty terminal configuration in this Nix setup.

## Overview

Alacritty is configured through Home Manager in `home-manager/shared/alacritty.nix` and provides a consistent terminal experience across both macOS and NixOS.

## Key Features

### 🎨 **Visual Configuration**
- **Theme**: Tokyo Night color scheme with dark background
- **Font**: JetBrains Mono with platform-specific sizing (14pt on macOS, 12pt on Linux)
- **Opacity**: 95% background transparency
- **Window**: Platform-appropriate decorations (buttonless on macOS, full on Linux)

### ⌨️ **Keyboard Shortcuts**

#### Cross-Platform Shortcuts
- **Copy**: `Cmd+C` (macOS) / `Ctrl+Shift+C` (Linux)
- **Paste**: `Cmd+V` (macOS) / `Ctrl+Shift+V` (Linux)
- **Search Forward**: `Cmd+F` (macOS) / `Ctrl+Shift+F` (Linux)
- **Search Backward**: `Cmd+B` (macOS) / `Ctrl+Shift+B` (Linux)
- **New Window**: `Cmd+N` (macOS) / `Ctrl+Shift+N` (Linux)

#### Font Size
- **Increase**: `Cmd/Ctrl + Plus`
- **Decrease**: `Cmd/Ctrl + Minus`
- **Reset**: `Cmd/Ctrl + 0`

#### Scrolling
- **Line Up**: `Cmd+K` (macOS) / `Ctrl+Shift+K` (Linux)
- **Line Down**: `Cmd+J` (macOS) / `Ctrl+Shift+J` (Linux)
- **Page Up**: `Shift + PageUp`
- **Page Down**: `Shift + PageDown`
- **Top**: `Shift + Home`
- **Bottom**: `Shift + End`

#### Utility
- **Clear History**: `Cmd+K` (macOS) / `Ctrl+K` (Linux)
- **Vi Mode**: `Shift+Ctrl+Space`
- **Fullscreen**: `Cmd+Ctrl+Return` (macOS) / `Alt+Return` (Linux)
- **Quit**: `Cmd+Q` (macOS) / `Ctrl+Shift+Q` (Linux)

#### macOS-Specific
- **Hide**: `Cmd+H`
- **Minimize**: `Cmd+M`
- **Close Window**: `Cmd+W`

### 🔗 **URL and File Hints**
- **Open URLs**: `Ctrl+Shift+U` - Click on URLs to open them
- **Open Files**: `Ctrl+Shift+F` - Click on file paths to open them
- **Hint Alphabet**: `jfkdls;ahgurieowpq` (optimized for efficiency)

### 🖱️ **Mouse Support**
- **Middle Click**: Paste selection
- **Right Click**: Expand selection
- **Ctrl+Click** (Linux) / **Cmd+Click** (macOS): Expand selection

## Platform-Specific Differences

### macOS
- Uses `Command` key for most shortcuts (following macOS conventions)
- Buttonless window decorations for clean appearance
- Larger default font size (14pt)
- Shell: `/nix/store/.../zsh` with `--login` flag

### Linux/NixOS
- Uses `Ctrl+Shift` combinations for most shortcuts
- Full window decorations with title bar
- Smaller default font size (12pt)
- IPC socket enabled for `alacritty msg` commands
- GTK dark theme integration

## Shell Integration

- **Default Shell**: Zsh with login mode
- **Environment**: `TERM=xterm-256color`
- **Working Directory**: Inherits from parent process
- **nix-shell Detection**: Automatic prompt modification when in nix-shell

## Configuration Management

The configuration is managed declaratively through Nix:

- **File Location**: `~/.config/alacritty/alacritty.toml` (symlinked to Nix store)
- **Source**: `home-manager/shared/alacritty.nix`
- **Activation**: Automatic via Home Manager during `./rebuild.sh`
- **Live Reload**: Enabled - changes take effect immediately when rebuilding

## Customization

To modify the Alacritty configuration:

1. Edit `home-manager/shared/alacritty.nix`
2. Run `./validate.sh` to check syntax
3. Run `./rebuild.sh` to apply changes
4. Commit changes: `git add -A && git commit -m "Update Alacritty config"`

## Troubleshooting

### Font Issues
- Ensure JetBrains Mono is installed (handled automatically by Nix)
- Check font rendering with: `alacritty --print-events`

### Color Problems
- Verify terminal supports 256 colors: `echo $TERM`
- Test color output: `curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/ | bash`

### Keybinding Conflicts
- Check system keybindings don't conflict
- Test with: `alacritty --print-events` and watch for key events

### Performance Issues
- Disable transparency: Set `opacity = 1.0`
- Check GPU acceleration is working
- Monitor with: `htop` while using terminal

## Integration with Development Workflow

Alacritty integrates seamlessly with the development environment:

- **Zsh Configuration**: Shares same enhanced zsh setup from `shared/zsh.nix`
- **Development Aliases**: All platform-specific aliases work normally
- **nix-shell Integration**: Visual indicator in prompt when in development shells
- **Cross-Platform Consistency**: Same experience whether on macOS or NixOS

## Version Information

- **Configuration Format**: TOML (Alacritty 0.12+)
- **Management**: Home Manager programs.alacritty
- **Updates**: Automatic with system updates via `./rebuild.sh update`
