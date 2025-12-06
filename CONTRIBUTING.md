# Contributing to Neovim Multi-Language Profile Setup

Thank you for considering contributing! Here's how you can help:

## Adding a New Language Profile

1. **Fork the repository**

2. **Edit init.lua** to add your language:
   - Add to LSP configuration filetype list
   - Add LSP server to ensure_installed
   - Configure the LSP server
   - Add filetype to relevant plugins
   - Create autocmd for your language

3. **Test your changes**
   - Install the modified config
   - Open a file of your language type
   - Verify LSP, keybindings, and features work

4. **Update README.md**
   - Add your language to the features table
   - Document keybindings and features

5. **Submit a Pull Request**

## Bug Reports

Please include:
- Neovim version
- Operating system
- Steps to reproduce
- Error messages

## Code Style

- Use 2-space indentation for Lua
- Comment complex sections
- Keep keybindings consistent

Thank you for contributing! 🎉
