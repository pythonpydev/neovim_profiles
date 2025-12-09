# Migration Guide - v1.0 to v2.0

## Summary

This update modernizes the Neovim configuration to use the latest Neovim 0.11+ APIs and replaces deprecated plugins with actively maintained alternatives.

## What Changed?

### 1. LSP Configuration - BREAKING CHANGE

**Old Method (deprecated):**
- Used `nvim-lspconfig` plugin
- Configuration via `require('lspconfig').server.setup()`

**New Method:**
- Uses native `vim.lsp.config` API (Neovim 0.11+)
- No external plugin needed for basic LSP setup
- Configuration via `vim.lsp.config.server = { ... }`

### 2. Linting & Formatting

**Old Method (deprecated):**
- Used `null-ls.nvim` (archived project)
- Single plugin for both linting and formatting

**New Method:**
- Linting: `nvim-lint` (actively maintained)
- Formatting: `conform.nvim` (actively maintained)
- Better separation of concerns

### 3. Shell Tools

**Old Behavior:**
- Required `shellcheck` and `shfmt` to be installed
- Would error if missing

**New Behavior:**
- Tools are optional
- Gracefully handles missing dependencies
- No errors if not installed

## Migration Steps

### If You're Using the Install Script

Simply run the updated install script - it handles everything:

```bash
cd /home/ed/MEGA/nvim_setup
./install.sh
```

### If You Have a Custom Setup

1. **Check Neovim version:**
   ```bash
   nvim --version  # Must be 0.11.0 or higher
   ```

2. **Backup your current config:**
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d)
   ```

3. **Copy new config:**
   ```bash
   cp /home/ed/MEGA/nvim_setup/init.lua ~/.config/nvim/
   ```

4. **Restart Neovim:**
   ```bash
   nvim
   # Plugins will auto-install
   ```

## What Stays the Same?

✅ All keybindings unchanged  
✅ Same file type profiles  
✅ Same functionality  
✅ Same commands (`:MarkdownPDF`, etc.)  
✅ Mason for LSP installation  

## Troubleshooting

### Error: "vim.lsp.config not found"

You need Neovim 0.11.0 or higher:

```bash
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt upgrade neovim
nvim --version
```

### Shell script linting not working

Install shellcheck (optional):

```bash
sudo apt install shellcheck
```

### Formatting not working

The new `conform.nvim` and `nvim-lint` plugins will auto-install via lazy.nvim. If issues persist:

```bash
nvim
:Lazy sync
```

## Benefits of Upgrading

1. **Future-proof** - Uses official Neovim APIs
2. **Better maintained** - All plugins are actively developed
3. **Faster startup** - Fewer external dependencies
4. **More stable** - No deprecated plugins that could break
5. **Cleaner codebase** - Modern API is more straightforward

## Need Help?

- Check `CHANGELOG.md` for detailed changes
- See `README.md` for full documentation
- Open an issue if problems persist

---

**Note:** Version 1.0 configurations will continue to work but will show deprecation warnings. Upgrading to v2.0 is recommended for the best experience.
