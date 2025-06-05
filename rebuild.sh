#!/usr/bin/env bash

# Build and switch script for Eric's Nix configuration

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Function to detect platform
detect_platform() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "nixos"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        if [[ "$(uname -m)" == "arm64" ]]; then
            echo "darwin-aarch64"
        else
            echo "darwin-x86_64"
        fi
    else
        echo "unsupported"
        exit 1
    fi
}

# Function to build configuration
build_config() {
    local platform="$1"
    local action="${2:-switch}"
    
    echo "Building configuration for platform: $platform"
    echo "Action: $action"
    
    # Run validation for switch action
    if [[ "$action" == "switch" ]] && [[ -x "./validate.sh" ]]; then
        echo "🔍 Running pre-build validation..."
        ./validate.sh || {
            echo "❌ Validation failed. Aborting build."
            exit 1
        }
        echo "✅ Validation passed."
        echo ""
    fi
    
    case "$platform" in
        "nixos")
            echo "Building NixOS configuration..."
            sudo nixos-rebuild "$action" --flake .#EricPC
            ;;
        "darwin-x86_64")
            echo "Building macOS configuration (Intel)..."
            darwin-rebuild "$action" --flake .#EricMac
            ;;
        "darwin-aarch64")
            echo "Building macOS configuration (Apple Silicon)..."
            darwin-rebuild "$action" --flake .#EricMac-aarch64
            ;;
        *)
            echo "Unsupported platform: $platform"
            exit 1
            ;;
    esac
}

# Main logic
PLATFORM=$(detect_platform)
ACTION="${1:-switch}"

case "$ACTION" in
    "switch"|"boot"|"test"|"build"|"dry-run"|"dry-activate")
        build_config "$PLATFORM" "$ACTION"
        ;;
    "update")
        echo "Updating flake inputs..."
        nix flake update
        echo "Update complete. Run './rebuild.sh' to apply changes."
        ;;
    "check")
        echo "Checking flake configuration..."
        nix flake check
        ;;
    "clean")
        echo "Running garbage collection..."
        if [[ "$PLATFORM" == "nixos" ]]; then
            sudo nix-collect-garbage -d
        else
            nix-collect-garbage -d
        fi
        ;;
    "help"|"-h"|"--help")
        echo "Usage: $0 [ACTION]"
        echo ""
        echo "Actions:"
        echo "  switch      Build and switch to new configuration (default)"
        echo "  boot        Build and switch on next boot"
        echo "  test        Build and switch temporarily"
        echo "  build       Build configuration without switching"
        echo "  dry-run     Show what would be built"
        echo "  dry-activate Show what would be activated"
        echo "  update      Update flake inputs"
        echo "  check       Check flake configuration"
        echo "  clean       Run garbage collection"
        echo "  help        Show this help message"
        echo ""
        echo "Detected platform: $PLATFORM"
        ;;
    *)
        echo "Unknown action: $ACTION"
        echo "Run '$0 help' for usage information."
        exit 1
        ;;
esac

echo "Done!"
