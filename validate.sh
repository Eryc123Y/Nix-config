#!/usr/bin/env bash

# Configuration Validation Script
# Validates the cross-platform Nix configuration

set -e

# Check for quiet flag
QUIET=false
if [[ "$1" == "--quiet" ]]; then
    QUIET=true
fi

if [[ "$QUIET" == "false" ]]; then
    echo "🔍 Validating Cross-Platform Nix Configuration..."
    echo
fi

# Check if we're in the right directory
if [[ ! -f "flake.nix" ]]; then
    echo "❌ Error: flake.nix not found. Run this script from the configuration directory."
    exit 1
fi

# Validate flake syntax
if [[ "$QUIET" == "false" ]]; then
    echo "📋 Checking flake syntax..."
fi

if nix flake check --no-build 2>/dev/null; then
    if [[ "$QUIET" == "false" ]]; then
        echo "✅ Flake syntax is valid"
    fi
else
    echo "❌ Flake syntax validation failed"
    exit 1
fi

if [[ "$QUIET" == "false" ]]; then
    # Show available configurations
    echo
    echo "🏗️ Available configurations:"
    nix flake show . 2>/dev/null | grep -E "(nixosConfigurations|darwinConfigurations)"
    
    echo
    echo "🎉 Configuration validation complete!"
    echo
    echo "Next steps:"
    if [[ -f "/etc/NIXOS" ]]; then
        echo "  • Apply configuration: sudo nixos-rebuild switch --flake .#EricPC"
        echo "  • Or use the helper: ./rebuild.sh"
    else
        echo "  • Apply configuration: darwin-rebuild switch --flake .#EricMac"
        echo "  • Or use the helper: ./rebuild.sh"
    fi
    echo "  • Update packages: nix flake update"
fi
