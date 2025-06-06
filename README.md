# Eric's Cross-Platform Nix Configuration

This repository contains a unified, flake-based Nix configuration that supports both **NixOS** and **macOS** (via nix-darwin), providing a consistent development environment across platforms while maintaining platform-specific customizations.

## 📊 Project Status

✅ **NixOS Configuration**: Fully operational and actively used  
🚧 **macOS Configuration**: Designed and validated, pending hardware testing  
✅ **Cross-Platform Programming Environment**: Complete with Java, Python, Node.js, C/C++, R  
✅ **Documentation**: Comprehensive setup and usage guide  
✅ **Package Structure**: Organized with custom authentication packages

## 🏗️ Architecture

The configuration uses a **shared-first approach** with platform-specific overlays:

```text
├── 📋 flake.nix                    # Main flake with NixOS + Darwin configurations
├── 📖 README.md                    # This documentation
├── 🔧 rebuild.sh                   # Helper script for rebuilding configurations
├── ✅ validate.sh                  # Configuration validation script
├── 🐧 nixos/                       # NixOS-specific system configurations
│   ├── configuration.nix           # Main NixOS system configuration
│   ├── hardware-configuration.nix  # Hardware-specific settings (auto-generated)
│   ├── zsh.nix                     # System-level ZSH configuration
│   ├── jetbrains.nix               # JetBrains IDE runtime support (nix-ld)
│   ├── android-studio.nix          # Android development environment (ADB)
│   ├── gnome.nix                   # GNOME desktop environment & extensions
│   └── kde.nix                     # KDE Plasma desktop environment & apps
├── 🍎 darwin/                      # macOS-specific system configurations
│   └── configuration.nix           # Main nix-darwin system configuration
├── 🏠 home-manager/                # Home Manager user configurations
│   ├── nixos.nix                   # NixOS user config (with GUI apps)
│   ├── darwin.nix                  # macOS user config (CLI tools only)
│   └── shared/                     # Cross-platform configurations
│       ├── base.nix                # Base home-manager settings & imports
│       ├── programming.nix         # Core programming environment
│       ├── programming-linux.nix   # Linux-specific development tools
│       └── zsh.nix                 # Enhanced cross-platform ZSH configuration
├── 🔗 shared/                      # Platform-agnostic configurations
│   └── nix-settings.nix            # Common Nix daemon settings & garbage collection
└── 📦 packages/                    # Custom package definitions
    ├── default.nix                 # Package collection entry point
    └── signon/                     # Custom authentication packages for KDE
        ├── signond.nix
        ├── signon-ui.nix
        ├── signon-plugin-oauth2.nix
        ├── wrapper.nix
        └── fake-user-agent.patch
```

## ✨ Features

### 🛠️ Cross-Platform Programming Environment

Consistent development tools across both platforms:

**Languages & Runtimes:**

- **Java**: JDK 21 (global), project-specific via nix-shell
- **Python**: Python 3 with data science stack (NumPy, Pandas, Scikit-learn, Jupyter)
- **Node.js**: Latest with Yarn Berry
- **C/C++**: GCC, CMake, GDB, LLDB
- **R**: Statistical computing environment

**Build Tools & Package Managers:**

- Maven, Gradle (Java)
- CMake, pkg-config (C/C++)
- Docker for containerization

**Documentation & Text Processing:**

- Pandoc, Typst, Quarto
- PlantUML, Graphviz for diagrams

**Development Utilities:**

- Git with global configuration
- Shell enhancements (tldr, neofetch, micro editor)
- **Enhanced ZSH**: Cross-platform shell with Oh My Zsh, platform-specific aliases, and advanced completion
- Compression utilities (p7zip)

### 🐧 NixOS-Specific Features

Complete desktop computing environment:

**Desktop Environments:**

- GNOME (modern, user-friendly)
- KDE Plasma (customizable, feature-rich)

**GUI Applications:**

- **Browsers**: Firefox, Arc, Brave
- **IDEs**: JetBrains Toolbox, VS Code, Cursor
- **Communication**: Telegram, Discord, Teams, WeChat, Zoom
- **Productivity**: Obsidian, Anki, Zotero, Calibre, Typora
- **Media**: Haruna media player, Lutris, Bottles gaming
- **Creative Tools**: Figma Linux, Rnote, Xournal++
- **Academic**: Mathpix Snipping Tool, LM Studio, Eudic Dictionary
- **AI/ML**: Ollama CUDA, local AI model support
- **File Management**: MEGAsync cloud sync
- **Text Processing**: Full TeXLive distribution
- **Network Tools**: Clash Verge Rev, V2Ray, BaiduPCS-Go
- **Remote Access**: Sunshine, Deskreen
- **PDF Tools**: Okular (KDE)

**System Features:**

- Audio/video codecs and drivers
- Graphics drivers and hardware acceleration  
- Network management and VPN support
- Custom fonts (JetBrains Mono)
- **Android Development**: ADB tools and Android Studio support via nix-ld
- **JetBrains IDE Support**: Enhanced runtime support for all JetBrains IDEs
- **Global Protect VPN**: Enterprise VPN client integration

### 📦 Custom Packages

This configuration includes custom package definitions for enhanced authentication support:

**KDE Authentication Stack:**
- `signond` - Authentication daemon with OAuth2 support
- `signon-ui` - User interface for authentication dialogs  
- `signon-plugin-oauth2` - OAuth2 plugin for modern authentication
- Custom patches and wrappers for improved integration

These packages are primarily used for KDE desktop authentication and can be found in the `packages/signon/` directory.

### 🍎 macOS-Specific Features

Programming-focused environment that complements existing macOS setup:

**Philosophy**: Assumes Homebrew manages GUI applications

- Core development tools and CLI utilities
- Terminal-based programming environment
- System integration via nix-darwin
- No GUI application conflicts with App Store/Homebrew

### 🐚 Enhanced Cross-Platform ZSH Configuration

Consistent shell experience across both platforms with intelligent platform detection:

**Features:**

- **Oh My Zsh**: Enhanced with plugins (git, sudo, docker, nix-shell, command-not-found, history-substring-search, colored-man-pages)
- **Platform-Specific Aliases**: Automatic detection and appropriate commands
  - Linux: `switch` → `sudo nixos-rebuild switch --flake .`
  - macOS: `switch` → `darwin-rebuild switch --flake .`
  - Platform-specific shortcuts (VPN, desktop refresh, brew updates)
- **Advanced Completion**: Case-insensitive, intelligent matching, enhanced kill command completion
- **History Management**: Shared history, duplicate filtering, extended format (10,000 entries)
- **Development Enhancements**: nix-shell detection, directory stack, better globbing
- **Cross-Platform PATH**: Automatic inclusion of platform-specific paths (/opt/homebrew, ~/.local/bin)

## 🚀 Quick Start

### Prerequisites

**For NixOS:**

- NixOS 23.11+ with flakes enabled
- Git for cloning the repository

**For macOS:**

- macOS with Nix package manager installed
- nix-darwin installed and configured
- Flakes enabled in Nix configuration

> **Note**: This configuration is actively tested on NixOS. macOS support is designed but requires testing on actual macOS hardware.

### Initial Setup

1. **Clone the repository:**

   ```bash
   git clone <repository-url> /etc/nixos  # On NixOS
   # or
   git clone <repository-url> ~/.config/nix-darwin  # On macOS
   cd /etc/nixos  # or ~/.config/nix-darwin
   ```

2. **Customize for your system:**

   ```bash
   # Update username if different from "eric"
   find . -name "*.nix" -exec sed -i 's/eric/your-username/g' {} \;
   
   # On NixOS: Update hardware configuration
   sudo nixos-generate-config --show-hardware-config > nixos/hardware-configuration.nix
   ```

### 🔄 Building & Switching

**NixOS:**

```bash
# Validate configuration first (recommended)
./validate.sh

# Build and switch to new configuration
sudo nixos-rebuild switch --flake .#EricPC

# Or use the helper script
./rebuild.sh
```

**macOS (Intel):**

```bash
# Validate configuration first (recommended)
./validate.sh

darwin-rebuild switch --flake .#EricMac
```

**macOS (Apple Silicon):**

```bash
# Validate configuration first (recommended)
./validate.sh

darwin-rebuild switch --flake .#EricMac-aarch64
```

### 📈 Updating

```bash
# Update flake inputs (nixpkgs, home-manager, nix-darwin)
nix flake update

# Rebuild with new packages
sudo nixos-rebuild switch --flake .#EricPC  # NixOS
# or
darwin-rebuild switch --flake .#EricMac     # macOS

# Check what will be updated before applying
nix flake check  # Validate configuration
```

## 🎛️ Customization Guide

### Adding Programming Languages

Edit `home-manager/shared/programming.nix`:

```nix
home.packages = with pkgs; [
  # ...existing packages...
  
  # Add new language
  go
  rustc
  cargo
];
```

### Adding GUI Applications (NixOS only)

Edit `home-manager/nixos.nix`:

```nix
home.packages = with pkgs; [
  # ...existing packages...
  
  # Add new GUI application
  gimp
  libreoffice
];
```

### Adding System Services

**NixOS** - Edit `nixos/configuration.nix`:

```nix
services.postgresql = {
  enable = true;
  package = pkgs.postgresql_15;
};
```

**macOS** - Edit `darwin/configuration.nix`:

```nix
services.nix-daemon.enable = true;
```

### Environment Variables

Edit `home-manager/shared/programming.nix`:

```nix
home.sessionVariables = {
  EDITOR = "micro";
  CUSTOM_VAR = "value";
};
```

## 🔧 Advanced Usage

### Project-Specific Development

Use nix-shell for project-specific tools:

```bash
# Create shell.nix in your project
nix-shell -p jdk17 maven  # Use JDK 17 for legacy project
nix-shell -p python38     # Use specific Python version
```

### Custom Packages

Add custom packages in `packages/`:

1. Create package definition: `packages/mypackage/default.nix`
2. Add to `packages/default.nix`
3. Reference in configurations

### System Configuration Details

**Garbage Collection & Optimization:**
- Automatic garbage collection every 7 days
- Store optimization enabled for reduced disk usage
- Configurable per platform in `shared/nix-settings.nix`

**JetBrains IDE Support:**
- `nix-ld` enabled with comprehensive library support
- JCEF (Java Chromium Embedded Framework) included
- SDL, audio, graphics, and desktop integration libraries
- Supports all JetBrains IDEs including IntelliJ IDEA, PyCharm, WebStorm

**Android Development:**
- ADB (Android Debug Bridge) system-wide
- Android Studio compatibility via nix-ld
- Emulator support with hardware acceleration

**Linux-Specific Development Tools:**
- Valgrind for memory debugging and profiling
- strace for system call tracing
- Hardware-specific optimizations for AMD CPUs

### Multiple Configurations

The flake supports multiple machine configurations:

```nix
# In flake.nix, add new configurations:
nixosConfigurations.WorkLaptop = mkSystem "x86_64-linux" [
  ./nixos/work-configuration.nix
  # ...
];
```

## 🛠️ Helper Scripts

This configuration includes two essential helper scripts to streamline common operations:

### `./validate.sh` - Configuration Validation

Validates the configuration before applying changes to catch syntax errors and configuration issues early:

**Usage:**
```bash
./validate.sh          # Full validation with detailed output
```

**What it checks:**
- ✅ Flake syntax validation (`nix flake check --no-build`)
- 🏗️ Available configuration outputs
- 📋 Platform detection and next steps guidance

**Example output:**
```
🔍 Validating Cross-Platform Nix Configuration...

📋 Checking flake syntax...
✅ Flake syntax is valid

🏗️ Available configurations:
├───darwinConfigurations: unknown
└───nixosConfigurations

🎉 Configuration validation complete!
```

### `./rebuild.sh` - Comprehensive Build Script

Intelligent rebuild script with automatic platform detection and comprehensive build options:

**Usage:**
```bash
./rebuild.sh [ACTION]
```

**Available Actions:**

| Action | Description | Example |
|--------|-------------|---------|
| `switch` | Build and switch to new configuration (default) | `./rebuild.sh` or `./rebuild.sh switch` |
| `boot` | Build and switch on next boot | `./rebuild.sh boot` |
| `test` | Build and switch temporarily (reverted on reboot) | `./rebuild.sh test` |
| `build` | Build configuration without switching | `./rebuild.sh build` |
| `dry-run` | Show what would be built without building | `./rebuild.sh dry-run` |
| `dry-activate` | Show what would be activated | `./rebuild.sh dry-activate` |
| `update` | Update flake inputs (nixpkgs, home-manager, etc.) | `./rebuild.sh update` |
| `check` | Check flake configuration syntax | `./rebuild.sh check` |
| `clean` | Run garbage collection to free disk space | `./rebuild.sh clean` |
| `help` | Show detailed usage information | `./rebuild.sh help` |

**Platform Detection:**
- **NixOS**: Automatically runs `sudo nixos-rebuild [action] --flake .#EricPC`
- **macOS Intel**: Automatically runs `darwin-rebuild [action] --flake .#EricMac`
- **macOS Apple Silicon**: Automatically runs `darwin-rebuild [action] --flake .#EricMac-aarch64`

**Safety Features:**
- 🔍 **Pre-build validation**: Automatically runs `./validate.sh` before `switch` operations
- ⚠️ **Error handling**: Stops on validation failures to prevent broken configurations
- 🏗️ **Platform awareness**: Detects your platform and uses appropriate commands

**Common Workflows:**
```bash
# Standard rebuild workflow
./validate.sh          # Optional: check configuration first
./rebuild.sh            # Build and switch

# Development workflow
./rebuild.sh test       # Test changes temporarily
./rebuild.sh switch     # Apply permanently if tests pass

# Maintenance workflow
./rebuild.sh update     # Update package inputs
./rebuild.sh            # Apply updated packages
./rebuild.sh clean      # Clean up old generations
```

## 🚀 Development Workflow

### Recommended Development Process

1. **Before Making Changes:**
   ```bash
   ./validate.sh  # Check current configuration syntax
   ```

2. **Making Configuration Changes:**
   ```bash
   # Edit configuration files
   micro nixos/configuration.nix  # or relevant file
   ./validate.sh                  # Validate changes
   ./rebuild.sh test             # Test temporarily
   ```

3. **Applying Changes Permanently:**
   ```bash
   ./rebuild.sh switch           # Apply permanently
   ```

4. **Regular Maintenance:**
   ```bash
   ./rebuild.sh update          # Update package inputs
   ./rebuild.sh                 # Apply updates
   ./rebuild.sh clean           # Clean old generations
   ```

### Platform-Specific Workflows

**NixOS Development:**
- Full desktop environment testing available
- GUI applications can be tested immediately
- System services and kernel modules supported

**macOS Development (Planned):**
- CLI-focused development environment
- Integration with existing Homebrew setup
- Terminal-based workflow optimization

## 🐛 Troubleshooting

### Common Issues

**Build Failures:**

```bash
# Clean build cache
nix-collect-garbage -d
nix flake check  # Validate configuration

# Check flake outputs
nix flake show .
```

**Package Conflicts:**

```bash
# Check for conflicting packages
nix-env -q  # List installed packages
nix-env -e package-name  # Remove conflicting package
```

**Java Environment:**

```bash
echo $JAVA_HOME              # Should point to JDK 21
java -version                # Current Java in PATH
$JAVA_HOME/bin/java -version # JAVA_HOME version
```

**ZSH Configuration:**

```bash
# Check if ZSH configuration is active
echo $SHELL                  # Should be /run/current-system/sw/bin/zsh
which switch                 # Should show platform-appropriate alias
zsh --version                # ZSH version info
```

### Getting Help

1. Check Nix documentation: <https://nixos.org/manual/>
2. Home Manager manual: <https://nix-community.github.io/home-manager/>
3. nix-darwin documentation: <https://github.com/LnL7/nix-darwin>

## 📋 Configuration Reference

### Configuration Reference

**Flake Inputs:**
- `nixpkgs` - NixOS/nixpkgs unstable channel (latest packages)
- `home-manager` - User environment management (follows nixpkgs)
- `nix-darwin` - macOS system configuration (follows nixpkgs)

**Versioning Strategy:**
- Uses unstable nixpkgs for latest package versions
- All inputs synchronized via `follows` for consistency
- Flake lock ensures reproducible builds across machines

### Flake Outputs

- `nixosConfigurations.EricPC` - NixOS system for x86_64-linux
- `darwinConfigurations.EricMac` - macOS system for x86_64-darwin  
- `darwinConfigurations.EricMac-aarch64` - macOS system for aarch64-darwin

### Key Files

- `flake.nix` - Main configuration entry point
- `home-manager/shared/programming.nix` - Cross-platform development environment
- `nixos/configuration.nix` - NixOS system configuration  
- `darwin/configuration.nix` - macOS system configuration

### Environment Details

- **Java**: JDK 21 (JetBrains) as primary, project-specific via nix-shell
- **Shell**: Zsh with completions and syntax highlighting
- **Editor**: Micro (EDITOR variable)
- **Package Manager**: Nix with flakes, unified across platforms

---

## 📋 Project Summary

This cross-platform Nix configuration has been successfully implemented with the following achievements:

### ✅ **Completed Features**
- **Unified Flake Architecture**: Single configuration supporting both NixOS and macOS
- **Cross-Platform Programming Environment**: Consistent development tools across platforms
- **Enhanced ZSH Configuration**: Shared shell environment with platform-specific optimizations
- **Modular Organization**: Shared configurations with platform-specific customizations
- **Java Environment**: Resolved conflicts, JDK 21 primary with JetBrains JDK 17 for IDEs
- **Helper Scripts**: Validation and rebuild automation with platform detection
- **Live System Migration**: Successfully switched from legacy to unified configuration
- **Comprehensive Documentation**: Complete setup, usage, and troubleshooting guide

### 🚧 **Pending Implementation**
- **macOS Testing**: Darwin configuration requires testing on actual macOS hardware
- **Package Optimization**: Fine-tuning based on real-world macOS usage

### 🏗️ **Architecture Highlights**
- **Flake Inputs**: nixpkgs, home-manager, nix-darwin with proper dependency following
- **Configurations**: `EricPC` (NixOS), `EricMac` (Intel), `EricMac-aarch64` (Apple Silicon)
- **Module Structure**: `shared/`, `nixos/`, `darwin/`, `home-manager/` organization
- **Package Management**: Custom authentication packages with organized structure

*This configuration provides a modern, maintainable, and consistent development environment across NixOS and macOS platforms.*
