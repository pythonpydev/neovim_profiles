# Changelog

All notable changes to this project will be documented in this file.

## [2.0.1] - 2025-12-09

### Fixed

- **Markdown preview scrolling issue**
  - Preview window is now fully scrollable with normal vim keybindings
  - Changed from terminal buffer to regular buffer with glow output
  - Can now navigate large markdown files with `j`, `k`, `Ctrl+d`, `Ctrl+u`, `gg`, `G`
  
### Added

- **Preview keybindings**
  - `q` to close preview window
  - `r` to refresh preview after saving changes
  - Notification showing available keybindings when preview opens

### Improved

- Preview is now read-only but scrollable
- Better user experience for reviewing large documents
- Preview window uses consistent light theme styling

---

## [2.0.0] - 2025-12-09

### Major Changes - Breaking

⚠️ **Requires Neovim 0.11.0+** - This version uses the new native `vim.lsp.config` API

### Changed

- **Migrated to native vim.lsp.config API** - Removed dependency on `nvim-lspconfig` plugin
  - Now uses Neovim's built-in LSP configuration framework
  - More future-proof and follows Neovim's official direction
  - Smaller plugin footprint, faster startup

- **Replaced null-ls.nvim with modern alternatives**
  - Linting: Now using `nvim-lint` (null-ls is archived/deprecated)
  - Formatting: Now using `conform.nvim`
  - Better maintained and more actively developed

- **Shell script tools made optional**
  - `shellcheck` and `shfmt` are now optional dependencies
  - Configuration gracefully handles missing tools
  - No errors when tools are not installed

### Fixed

- Fixed deprecation warning when opening `*.sh` files
- Fixed error: "attempt to index field '_request_name_to_capability'"
- Improved compatibility with Neovim 0.12.0-dev

### Improved

- Better error handling for missing optional dependencies
- Clearer installation prompts for optional tools
- Updated documentation to reflect modern API usage
- Version checking in install script

### Technical Details

**Before (deprecated):**
```lua
local lspconfig = require("lspconfig")
lspconfig.bashls.setup({ ... })
```

**After (modern):**
```lua
vim.lsp.config.bashls = {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash' },
  ...
}
vim.lsp.enable('bashls')
```

---

## [1.0.0] - 2024

### Initial Release

- Multi-language profile support
- Auto-detecting file type configuration
- LSP support for Python, Shell, C++, Rust, HTML, CSS
- Markdown preview and export features
- Text file writing mode
- Mason-based LSP server management
