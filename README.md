# Neovim Multi-Language Profile Setup

A modern, auto-detecting Neovim configuration with intelligent profile switching for multiple programming languages and file types. No manual configuration needed - just open a file and the right tools activate automatically!

## ✨ Features

### 🚀 Auto-Detecting Language Profiles

This Neovim setup automatically loads the appropriate tools, LSP servers, and keybindings based on the file type you're editing:

| Language/Type | File Extensions | Features |
|---------------|----------------|----------|
| 📝 **Markdown** | `.md` | Live browser preview, PDF/HTML export, custom syntax highlighting |
| 🐍 **Python** | `.py` | Pyright LSP, Black formatter, autocomplete, linting |
| 🐚 **Shell** | `.sh`, `.bash` | Bash LSP, ShellCheck linting, shfmt formatting |
| ⚙️ **C/C++** | `.cpp`, `.c`, `.h` | Clangd LSP, CMake integration, auto-pairs |
| 📄 **Text** | `.txt` | Distraction-free writing, spell check, word count |
| 🦀 **Rust** | `.rs` | rust-analyzer, cargo integration, clippy |
| 🌐 **HTML** | `.html` | HTML LSP, Emmet, auto-close tags, browser preview |
| 🎨 **CSS** | `.css` | CSS LSP, live color preview, Emmet |

### 🌍 Global Features (All File Types)

- **File Explorer**: nvim-tree with icons
- **Which-Key**: Shows available keybindings when you pause
- **Treesitter**: Advanced syntax highlighting
- **Modern UI**: Clean, responsive interface

---

## 📦 What Gets Installed

### Core Components
- **lazy.nvim**: Modern plugin manager
- **Mason**: LSP server installer
- **nvim-cmp**: Autocompletion engine
- **LuaSnip**: Snippet engine
- **Treesitter**: Advanced syntax parsing
- **nvim-lint**: Linting framework (replaces null-ls)
- **conform.nvim**: Formatting framework

### Language Servers (LSP)
- Uses native **vim.lsp.config** API (Neovim 0.11+)
- `pyright` - Python
- `bashls` - Bash/Shell
- `clangd` - C/C++
- `rust-analyzer` - Rust
- `html` - HTML
- `cssls` - CSS

### Additional Tools
- `markdown-preview.nvim` - Live browser-based markdown preview
- `pandoc` - Markdown to PDF/HTML conversion
- `shellcheck` - Shell script linting (optional)
- `shfmt` - Shell script formatting (optional)
- `black` - Python code formatting

---

## ⚡ Quick Start

### Prerequisites

- **Linux** (Ubuntu/Debian-based recommended)
- **Git** installed
- **curl** installed

### Automated Installation

```bash
# Download the setup script
curl -o install.sh https://raw.githubusercontent.com/pythonpydev/nvim_setup/main/install.sh

# Make it executable
chmod +x install.sh

# Run the installer
./install.sh
```

The script will:
1. Install Neovim (if not already installed)
2. Install dependencies (Node.js, Python, etc.)
3. Backup your existing Neovim config (if any)
4. Install this configuration
5. Install all plugins and LSP servers

---

## 🛠️ Manual Installation

### Step 1: Install Neovim 0.11.0+

#### Ubuntu/Debian
```bash
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim
```

#### Verify Installation
```bash
nvim --version
# Should show version 0.11.0 or higher (required for vim.lsp.config API)
```

### Step 2: Install Required Dependencies

```bash
# Essential build tools
sudo apt install build-essential git curl nodejs npm python3 python3-pip

# Markdown tools (including XeLaTeX for Unicode PDF support)
sudo apt install pandoc texlive-latex-base texlive-latex-recommended texlive-xetex

# Shell script tools
sudo apt install shellcheck

# Install shfmt
GO111MODULE=on go install mvdan.cc/sh/v3/cmd/shfmt@latest

# Python tools
pip3 install black

# C++ tools (if needed)
sudo apt install clangd

# Rust (if needed)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rust-analyzer
```

### Step 3: Backup Existing Config

```bash
# Backup your current Neovim config (if you have one)
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
mv ~/.local/state/nvim ~/.local/state/nvim.backup
```

### Step 4: Install This Configuration

```bash
# Clone this repository
git clone https://github.com/pythonpydev/nvim_setup.git

# Create Neovim config directory
mkdir -p ~/.config/nvim

# Copy the configuration
cp nvim_setup/init.lua ~/.config/nvim/
```

### Step 5: Install Plugins

```bash
# Start Neovim
nvim

# The plugin manager will auto-install on first run
# Once it opens, run:
:LazySync

# Wait for all plugins to install, then restart Neovim
:qa

# Open Neovim again
nvim
```

---

## 📚 Usage Guide

### Markdown Files (`.md`)

**Keybindings:**
- `F5` - Live preview in browser (auto-updates as you type)
- `F6` - Export to PDF (requires texlive-xetex for Unicode)
- `F7` - Export to HTML

**Commands:**
- `:MarkdownPreview` - Open live preview in browser
- `:MarkdownPreviewStop` - Stop preview server
- `:MarkdownPreviewToggle` - Toggle preview on/off
- `:MarkdownPDF` - Export to PDF
- `:MarkdownHTML` - Export to HTML

**Preview Features:**
- Live reload - changes appear instantly in browser
- Synchronized scrolling between editor and preview
- Compact spacing (minimal whitespace)
- Light theme optimized for readability
- Custom CSS for professional appearance

### Python Files (`.py`)

**Keybindings:**
- `F5` - Run Python file
- `F6` - Format with Black
- `gd` - Go to definition
- `K` - Show documentation
- `<leader>rn` - Rename variable
- `<leader>ca` - Code actions
- `<leader>f` - Format code
- `gr` - Show references

### Shell Scripts (`.sh`, `.bash`)

**Keybindings:**
- `F5` - Run script
- `F6` - Check with shellcheck
- `F7` - Make executable (chmod +x)
- `gd` - Go to definition
- `K` - Show hover info
- `<leader>f` - Format with shfmt

### C/C++ Files (`.cpp`, `.c`, `.h`)

**Keybindings:**
- `F5` - Compile and run
- `F6` - Compile only
- `F7` - Generate CMake
- `F8` - Build with CMake
- `gd` - Go to definition
- `gD` - Go to declaration
- `<leader>h` - Switch between .cpp and .h

### Text Files (`.txt`)

**Keybindings:**
- `F5` - Toggle distraction-free mode (Goyo)
- `F6` - Toggle paragraph focus (Limelight)
- `F7` - Toggle spell check
- `<leader>wc` - Show word count
- `]s` - Next misspelled word
- `[s` - Previous misspelled word
- `z=` - Spelling suggestions

### Rust Files (`.rs`)

**Keybindings:**
- `F5` - cargo run
- `F6` - cargo build
- `F7` - cargo test
- `F8` - cargo clippy
- `<leader>rr` - Show runnables
- `<leader>rc` - Open Cargo.toml

### HTML Files (`.html`)

**Keybindings:**
- `F5` - Open in browser
- `Ctrl+Y,` - Expand Emmet abbreviation
- `gd` - Go to definition
- `<leader>f` - Format code

**Emmet Examples:**
- Type `html:5` then `Ctrl+Y,` for HTML5 template
- Type `div.container>ul>li*3` then `Ctrl+Y,` for nested structure

### CSS Files (`.css`)

**Keybindings:**
- `Ctrl+Y,` - Expand Emmet abbreviation
- `gd` - Go to definition
- `<leader>f` - Format code

**Features:**
- Live color preview (color codes show as actual colors)

### Global Keybindings (All Files)

- `Ctrl+N` - Toggle file tree
- `<leader>r` - Refresh file tree
- `<leader>n` - Find current file in tree
- `\` - Leader key (default)

---

## 🔧 Customization

### Change Leader Key

Edit `~/.config/nvim/init.lua` and add at the top:

```lua
vim.g.mapleader = " "  -- Change leader to spacebar
```

### Disable a Profile

Comment out the unwanted profile section in `init.lua`:

```lua
-- Comment out the Python profile if you don't need it
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'python',
--   ...
-- })
```

### Add More LSP Servers

In the `ensure_installed` section:

```lua
ensure_installed = { "pyright", "bashls", "clangd", "rust_analyzer", "html", "cssls", "YOUR_LSP_HERE" },
```

---

## 🐛 Troubleshooting

### Plugin Installation Fails

```bash
# Clear plugin cache and reinstall
rm -rf ~/.local/share/nvim/lazy/*
nvim
:LazySync
```

### LSP Not Working

```bash
# Check Mason status
nvim
:Mason

# Manually install LSP server
:MasonInstall pyright
```

### Treesitter Errors

```bash
nvim
:TSUpdate
```

### Neovim Version Too Old

**Note:** This configuration requires Neovim 0.11.0+ for the modern vim.lsp.config API.

```bash
# Upgrade to latest Neovim
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt upgrade neovim

# Verify version
nvim --version  # Should be 0.11.0 or higher
```

---

## 📝 File Structure

```
~/.config/nvim/
├── init.lua              # Main configuration file

~/.local/share/nvim/
├── lazy/                 # Installed plugins
└── mason/                # Installed LSP servers
```

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Adding a New Language Profile

1. Add LSP server to `ensure_installed`
2. Configure LSP in the lspconfig section
3. Add file type to relevant plugins (`ft = { ... }`)
4. Create autocmd for the new file type
5. Define keybindings and settings

---

## 📜 License

MIT License - feel free to use and modify!

---

## 🙏 Acknowledgments

Built with these amazing plugins:
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [Mason](https://github.com/williamboman/mason.nvim) - LSP installer
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Autocompletion
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax highlighting
- [nvim-lint](https://github.com/mfussenegger/nvim-lint) - Linting framework
- [conform.nvim](https://github.com/stevearc/conform.nvim) - Formatting framework
- Uses native **vim.lsp.config** API (Neovim 0.11+)
- And many more incredible plugins!

---

## 📞 Support

If you encounter issues:
1. Check the [Troubleshooting](#-troubleshooting) section
2. Open an issue on GitHub
3. Make sure you're running Neovim 0.11.0+ (required for vim.lsp.config API)
4. For shell script linting, ensure shellcheck is installed: `sudo apt install shellcheck`

---

**Enjoy coding! 🚀**
