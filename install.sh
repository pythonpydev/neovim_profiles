#!/bin/bash

# Neovim Multi-Language Profile Setup - Automated Installer
# This script installs Neovim and all dependencies for the multi-language profile setup

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print functions
print_header() {
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}ℹ $1${NC}"
}

# Check if running on Linux
if [[ "$OSTYPE" != "linux-gnu"* ]]; then
    print_error "This script is designed for Linux systems only."
    exit 1
fi

print_header "Neovim Multi-Language Profile Setup - Installer"
echo ""
print_info "This script will install Neovim and all required dependencies."
echo ""
read -p "Continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

# Backup existing Neovim configuration
print_header "Step 1: Backing Up Existing Configuration"
if [ -d "$HOME/.config/nvim" ]; then
    BACKUP_DIR="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
    print_info "Backing up existing Neovim config to $BACKUP_DIR"
    mv "$HOME/.config/nvim" "$BACKUP_DIR"
    print_success "Backup created"
fi

if [ -d "$HOME/.local/share/nvim" ]; then
    BACKUP_DIR="$HOME/.local/share/nvim.backup.$(date +%Y%m%d_%H%M%S)"
    print_info "Backing up existing Neovim data to $BACKUP_DIR"
    mv "$HOME/.local/share/nvim" "$BACKUP_DIR"
    print_success "Backup created"
fi

# Update package lists
print_header "Step 2: Updating Package Lists"
sudo apt update
print_success "Package lists updated"

# Install Neovim
print_header "Step 3: Installing Neovim"
if command -v nvim &> /dev/null; then
    NVIM_VERSION=$(nvim --version | head -n 1 | cut -d' ' -f2)
    print_info "Neovim $NVIM_VERSION already installed"
    
    # Check if version is sufficient (0.11.0+)
    REQUIRED_VERSION="0.11.0"
    if printf '%s\n%s\n' "$REQUIRED_VERSION" "$NVIM_VERSION" | sort -V -C; then
        print_success "Neovim version $NVIM_VERSION meets requirement (0.11.0+)"
    else
        print_error "Neovim version $NVIM_VERSION is too old (requires 0.11.0+)"
        print_info "Upgrading to latest version..."
        sudo add-apt-repository ppa:neovim-ppa/unstable -y
        sudo apt update
        sudo apt install -y neovim
        print_success "Neovim upgraded"
    fi
else
    print_info "Installing Neovim 0.11.0+..."
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt update
    sudo apt install -y neovim
    print_success "Neovim installed"
fi

# Install essential dependencies
print_header "Step 4: Installing Essential Dependencies"
print_info "Installing build tools, Git, Node.js, Python..."
sudo apt install -y \
    build-essential \
    git \
    curl \
    wget \
    nodejs \
    npm \
    python3 \
    python3-pip \
    ripgrep \
    fd-find \
    xdg-utils

print_success "Essential dependencies installed"

# Install Markdown tools
print_header "Step 5: Installing Markdown Tools"
print_info "Installing pandoc and LaTeX for PDF export..."
sudo apt install -y pandoc texlive-latex-base texlive-latex-recommended texlive-xetex
print_success "Markdown tools installed (with XeLaTeX for Unicode support)"

# Install Glow
print_info "Installing glow (Markdown preview)..."
if ! command -v glow &> /dev/null; then
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
    sudo apt update
    sudo apt install -y glow
    print_success "Glow installed"
else
    print_success "Glow already installed"
fi

# Create glow config directory
mkdir -p "$HOME/.config/glow/styles"

# Install Shell script tools
print_header "Step 6: Installing Shell Script Tools (Optional)"
print_info "Installing shellcheck (optional for shell script linting)..."
read -p "Install shellcheck? (recommended) (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo apt install -y shellcheck
    print_success "ShellCheck installed"
else
    print_info "Skipping shellcheck (can install later: sudo apt install shellcheck)"
fi

print_info "Installing shfmt (optional for shell script formatting)..."
read -p "Install shfmt? (recommended) (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if ! command -v shfmt &> /dev/null; then
        if command -v go &> /dev/null; then
            GO111MODULE=on go install mvdan.cc/sh/v3/cmd/shfmt@latest
            print_success "shfmt installed via Go"
        else
            print_info "Go not found, shfmt can be installed via Mason in Neovim"
            print_success "shfmt will be available after first Neovim launch"
        fi
    else
        print_success "shfmt already installed"
    fi
else
    print_info "Skipping shfmt"
fi

# Install Python tools
print_header "Step 7: Installing Python Tools"
print_info "Installing black (Python formatter)..."
pip3 install --user black
print_success "Black installed"

# Install C++ tools
print_header "Step 8: Installing C++ Tools"
print_info "Installing clangd..."
sudo apt install -y clangd
print_success "Clangd installed"

# Ask about Rust
print_header "Step 9: Rust Installation (Optional)"
read -p "Install Rust and rust-analyzer? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if ! command -v rustc &> /dev/null; then
        print_info "Installing Rust..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env"
        rustup component add rust-analyzer
        print_success "Rust and rust-analyzer installed"
    else
        print_info "Rust already installed, adding rust-analyzer..."
        rustup component add rust-analyzer
        print_success "rust-analyzer added"
    fi
fi

# Copy configuration files
print_header "Step 10: Installing Neovim Configuration"
print_info "Creating Neovim config directory..."
mkdir -p "$HOME/.config/nvim"

# Check if init.lua exists in the same directory as this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/init.lua" ]; then
    print_info "Copying init.lua..."
    cp "$SCRIPT_DIR/init.lua" "$HOME/.config/nvim/"
    print_success "Configuration file copied"
else
    print_error "init.lua not found in $SCRIPT_DIR"
    print_info "Please manually copy init.lua to ~/.config/nvim/"
    exit 1
fi

# Install plugins
print_header "Step 11: Installing Neovim Plugins"
print_info "Starting Neovim to install plugins..."
print_info "This may take a few minutes. Please wait..."
echo ""

# Run Neovim headless to install plugins
nvim --headless "+Lazy! sync" +qa

print_success "Plugins installed"

# Final setup
print_header "Step 12: Final Setup"
print_info "Installing LSP servers via Mason..."

# Note: Mason will auto-install LSP servers on first use
print_info "LSP servers will be automatically installed when you open relevant file types"
print_info "You can also manually install via :Mason command in Neovim"

# Completion
print_header "✨ Installation Complete!"
echo ""
print_success "Neovim multi-language profile setup is now installed!"
echo ""
print_info "Configuration details:"
echo "  • Uses native vim.lsp.config API (Neovim 0.11+)"
echo "  • LSP servers managed by Mason"
echo "  • Linting via nvim-lint"
echo "  • Formatting via conform.nvim"
echo ""
print_info "Next steps:"
echo "  1. Start Neovim: nvim"
echo "  2. Wait for remaining plugins to load"
echo "  3. Run :Mason to check LSP server status"
echo "  4. Open a file to test the appropriate profile!"
echo ""
print_info "Quick test:"
echo "  nvim test.py    # Test Python profile"
echo "  nvim test.md    # Test Markdown profile"
echo "  nvim test.sh    # Test Shell script profile"
echo "  nvim test.html  # Test HTML profile"
echo ""
print_info "Optional: Install shellcheck for shell script linting:"
echo "  sudo apt install shellcheck"
echo ""
print_info "For help, see: https://github.com/pythonpydev/nvim_setup"
echo ""
print_success "Happy coding! 🚀"
