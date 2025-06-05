# Eric's Cross-Platform Nix Configuration

This repository contains a well-organized Nix configuration that supports both NixOS and macOS (via nix-darwin), using only the unstable nixpkgs channel and latest nix-darwin channel.

## Structure

```
├── flake.nix                    # Main flake configuration
├── README.md                    # This file
├── nixos/                       # NixOS-specific configurations
│   ├── configuration.nix        # Main NixOS system configuration
│   ├── hardware-configuration.nix # Hardware-specific settings
│   ├── zsh.nix                  # ZSH shell configuration
│   ├── jetbrains.nix            # JetBrains IDE support
│   ├── android-studio.nix       # Android development
│   ├── gnome.nix                # GNOME desktop environment
│   └── kde.nix                  # KDE desktop environment
├── darwin/                      # macOS-specific configurations
│   └── configuration.nix        # Main nix-darwin system configuration
├── shared/                      # Shared configurations
│   └── nix-settings.nix         # Common Nix settings for both platforms
├── home-manager/                # Home Manager configurations
│   ├── nixos.nix                # NixOS home configuration (with GUI apps)
│   ├── darwin.nix               # macOS home configuration (programming only)
│   └── shared/                  # Shared home configurations
│       ├── base.nix             # Base home-manager settings
│       └── programming.nix      # Cross-platform programming environment
└── overlays/                    # Custom package overlays
    └── mako.nix
```

## Features

### Cross-Platform Programming Environment
The configuration provides a consistent programming environment across both NixOS and macOS, including:

- **Languages**: Python (with data science packages), Java, C/C++, R, Node.js
- **Build Tools**: Maven, Gradle, CMake
- **Development Tools**: Git, Docker, various debuggers
- **Documentation**: Pandoc, Typst, Quarto
- **Utilities**: Shell enhancements, compression tools, etc.

### Platform-Specific Features

#### NixOS
- Complete desktop environment (GNOME/KDE support)
- GUI applications (browsers, IDEs, communication tools, etc.)
- Gaming and entertainment packages
- Full system configuration including graphics drivers

#### macOS (nix-darwin)
- Programming environment only (no GUI applications)
- Assumes homebrew is already installed for GUI apps
- System preferences and defaults configuration
- Seamless integration with existing macOS setup

## Usage

### Building NixOS Configuration
```bash
sudo nixos-rebuild switch --flake .#EricPC
```

### Building macOS Configuration (Intel)
```bash
darwin-rebuild switch --flake .#EricMac
```

### Building macOS Configuration (Apple Silicon)
```bash
darwin-rebuild switch --flake .#EricMac-aarch64
```

### Updating
```bash
nix flake update
```

## Design Principles

1. **Single Source of Truth**: Uses only nixpkgs-unstable and latest nix-darwin
2. **Platform Separation**: Clear separation between NixOS and macOS configurations
3. **Shared Programming Environment**: Consistent development tools across platforms
4. **No Redundancy**: GUI applications only on NixOS, leveraging existing homebrew on macOS
5. **Modular Structure**: Easy to maintain and extend individual components

## Customization

- Edit `home-manager/shared/programming.nix` to modify the cross-platform development environment
- Edit `home-manager/nixos.nix` to add/remove GUI applications on NixOS
- Edit `nixos/configuration.nix` for NixOS system-level changes
- Edit `darwin/configuration.nix` for macOS system-level changes

## Notes

- The configuration assumes username "eric" - update accordingly if different
- macOS configuration intentionally excludes homebrew to avoid conflicts
- All GUI applications and IDEs are only installed on NixOS
- Programming tools and CLI utilities are shared across platforms
