#!/bin/bash

# Improved OSK GNOME Extension Installer
# Downloads and installs the Improved OSK extension for GNOME Shell
# Compatible with GNOME Shell versions 3.38, 40, 41, 42
# For later use https://extensions.gnome.org/extension/6595/enhanced-osk/

set -e  # Exit on any error

# Colors for pretty output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Extension details
EXTENSION_URL="https://extensions.gnome.org/extension-data/improvedosknick-shmyrev.dev.v9.shell-extension.zip"
EXTENSION_UUID="improvedosk@nick-shmyrev.dev"
EXTENSION_NAME="Improved OSK"
EXTENSION_DIR="$HOME/.local/share/gnome-shell/extensions"
TEMP_DIR="/tmp/improved-osk-installer"

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check GNOME Shell version compatibility
check_gnome_version() {
    if command_exists gnome-shell; then
        local version=$(gnome-shell --version | grep -oP '\d+\.\d+' | head -1)
        local major=$(echo $version | cut -d. -f1)
        
        print_status "Detected GNOME Shell version: $version"
        
        # Check if version is supported (3.38, 40, 41, 42)
        if [[ "$version" == "3.38" ]] || [[ "$major" -ge 40 && "$major" -le 42 ]]; then
            print_success "GNOME Shell version is supported!"
            return 0
        else
            print_warning "GNOME Shell version $version may not be fully supported."
            print_warning "Supported versions: 3.38, 40, 41, 42"
            read -p "Continue anyway? (y/N): " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                print_error "Installation aborted."
                exit 1
            fi
        fi
    else
        print_warning "Could not detect GNOME Shell version. Continuing..."
    fi
}

# Function to create necessary directories
create_directories() {
    print_status "Creating extension directories..."
    mkdir -p "$EXTENSION_DIR"
    mkdir -p "$TEMP_DIR"
}

# Function to download the extension
download_extension() {
    print_status "Downloading $EXTENSION_NAME..."
    
    if command_exists wget; then
        wget -q --show-progress -O "$TEMP_DIR/extension.zip" "$EXTENSION_URL"
    elif command_exists curl; then
        curl -L -o "$TEMP_DIR/extension.zip" "$EXTENSION_URL"
    else
        print_error "Neither wget nor curl found. Please install one of them."
        exit 1
    fi
    
    if [[ -f "$TEMP_DIR/extension.zip" ]]; then
        print_success "Extension downloaded successfully!"
    else
        print_error "Failed to download extension."
        exit 1
    fi
}

# Function to install the extension
install_extension() {
    print_status "Installing $EXTENSION_NAME..."
    
    # Remove existing installation if it exists
    if [[ -d "$EXTENSION_DIR/$EXTENSION_UUID" ]]; then
        print_warning "Existing installation found. Removing..."
        rm -rf "$EXTENSION_DIR/$EXTENSION_UUID"
    fi
    
    # Extract the extension
    if command_exists unzip; then
        unzip -q "$TEMP_DIR/extension.zip" -d "$EXTENSION_DIR/$EXTENSION_UUID"
        print_success "Extension installed to $EXTENSION_DIR/$EXTENSION_UUID"
    else
        print_error "unzip command not found. Please install unzip."
        exit 1
    fi
}

# Function to enable the extension
enable_extension() {
    print_status "Attempting to enable extension..."
    
    if command_exists gnome-extensions; then
        # Check if extension is recognized
        if gnome-extensions list --user | grep -q "$EXTENSION_UUID"; then
            gnome-extensions enable "$EXTENSION_UUID" 2>/dev/null && {
                print_success "Extension enabled successfully!"
            } || {
                print_warning "Could not enable extension automatically."
            }
        else
            print_warning "Extension not yet recognized by GNOME Shell."
            print_status "You may need to:"
            echo "  1. Log out and log back in, OR"
            echo "  2. Press Alt+F2, type 'r', and press Enter (X11 only), OR"
            echo "  3. Restart your session"
        fi
    else
        print_warning "gnome-extensions command not found."
    fi
}

# Function to cleanup temporary files
cleanup() {
    print_status "Cleaning up temporary files..."
    rm -rf "$TEMP_DIR"
}

# Function to show post-installation instructions
show_instructions() {
    echo
    print_success "🎉 Installation complete!"
    echo
    echo "📋 What's next:"
    echo "  • The Improved OSK extension adds extra keys to the on-screen keyboard"
    echo "  • It includes Arrow keys, Esc, Tab, Ctrl, Alt, Super, F1-12"
    echo "  • Supports key combinations like Ctrl+C, Alt+Tab, etc."
    echo "  • Has configurable keyboard size for landscape/portrait"
    echo "  • Includes a statusbar indicator to toggle the keyboard"
    echo
    echo "🔧 To configure the extension:"
    echo "  • Open GNOME Extensions app or visit https://extensions.gnome.org/"
    echo "  • Find '$EXTENSION_NAME' in your installed extensions"
    echo "  • Click the settings/gear icon to configure"
    echo
    echo "📖 For more information:"
    echo "  • GitHub: https://github.com/nick-shmyrev/improved-osk-gnome-ext"
    echo "  • GNOME Extensions: https://extensions.gnome.org/extension/1508/improved-osk/"
    echo
    print_status "Happy typing! 🐾"
}

# Main installation function
main() {
    echo "🐾 Improved OSK GNOME Extension Installer"
    echo "=========================================="
    echo
    
    # Check prerequisites
    check_gnome_version
    
    # Install the extension
    create_directories
    download_extension
    install_extension
    enable_extension
    cleanup
    show_instructions
}

# Trap to ensure cleanup on exit
trap cleanup EXIT

# Run the installer
main "$@" 
