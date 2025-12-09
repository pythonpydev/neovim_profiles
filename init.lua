-- ~/.config/nvim/init.lua

-- Use existing Vim configuration
vim.opt.runtimepath:prepend('~/.vim')
vim.opt.runtimepath:append('~/.vim/after')
vim.opt.packpath = vim.opt.runtimepath:get()[1]
vim.cmd('source ~/.vimrc.backup')  -- Load old settings

-- ===============================================
-- TERMINAL & COLOR SETTINGS
-- ===============================================
-- Enable true colors in terminal (gnome-terminal supports this)
vim.opt.termguicolors = true

-- Always use light background
vim.opt.background = 'light'

-- Set light theme colors
vim.cmd('highlight CursorLine guibg=#E8E8E8 ctermbg=254 cterm=NONE gui=NONE')
vim.cmd('highlight CursorLineNr guifg=#D75F00 guibg=#E8E8E8 ctermfg=166 ctermbg=254 cterm=bold gui=bold')
vim.cmd('highlight Visual guibg=#D0D0D0 guifg=NONE ctermbg=252 ctermfg=NONE')
vim.cmd('highlight Normal guifg=#2E2E2E guibg=#FFFFFF ctermfg=236 ctermbg=231')

-- Set message colors for light background
vim.cmd('highlight MoreMsg guifg=#FF0000 gui=bold ctermfg=196 cterm=bold')
vim.cmd('highlight Question guifg=#FF0000 gui=bold ctermfg=196 cterm=bold')

-- Set markdown heading colors - bold orange for all headings
vim.cmd('highlight markdownH1 guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
vim.cmd('highlight markdownH2 guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
vim.cmd('highlight markdownH3 guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
vim.cmd('highlight markdownH4 guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
vim.cmd('highlight markdownH5 guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
vim.cmd('highlight markdownH6 guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
vim.cmd('highlight markdownHeadingDelimiter guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
vim.cmd('highlight @markup.heading.1.markdown guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
vim.cmd('highlight @markup.heading.2.markdown guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
vim.cmd('highlight @markup.heading.3.markdown guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
vim.cmd('highlight @markup.heading.4.markdown guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
vim.cmd('highlight @markup.heading.5.markdown guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
vim.cmd('highlight @markup.heading.6.markdown guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
vim.cmd('highlight @markup.heading.marker.markdown guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')

-- Override old F5/F6/F7 mappings with autocmd that runs after FileType
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    -- Clear any existing buffer-local F key mappings
    pcall(vim.api.nvim_buf_del_keymap, 0, 'n', '<F5>')
    pcall(vim.api.nvim_buf_del_keymap, 0, 'n', '<F6>')
    pcall(vim.api.nvim_buf_del_keymap, 0, 'n', '<F7>')
    
    -- Override markdown heading colors - bold orange for all headings
    -- Apply to both standard syntax and treesitter
    vim.cmd('highlight markdownH1 guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
    vim.cmd('highlight markdownH2 guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
    vim.cmd('highlight markdownH3 guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
    vim.cmd('highlight markdownH4 guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
    vim.cmd('highlight markdownH5 guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
    vim.cmd('highlight markdownH6 guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
    vim.cmd('highlight markdownHeadingDelimiter guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
    
    -- Treesitter markdown headings (override treesitter highlighting)
    vim.cmd('highlight @markup.heading.1.markdown guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
    vim.cmd('highlight @markup.heading.2.markdown guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
    vim.cmd('highlight @markup.heading.3.markdown guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
    vim.cmd('highlight @markup.heading.4.markdown guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
    vim.cmd('highlight @markup.heading.5.markdown guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
    vim.cmd('highlight @markup.heading.6.markdown guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
    vim.cmd('highlight @markup.heading.marker.markdown guifg=#FF8700 guibg=NONE gui=bold cterm=bold ctermfg=208')
    
    -- Light theme markdown colors
    vim.cmd('highlight markdownCode guifg=#005F00 guibg=#F0F0F0 ctermfg=22 ctermbg=255')
    vim.cmd('highlight markdownCodeBlock guifg=#005F00 guibg=#F0F0F0 ctermfg=22 ctermbg=255')
    vim.cmd('highlight markdownBold guifg=#AF5F00 gui=bold ctermfg=130 cterm=bold')
    vim.cmd('highlight markdownItalic guifg=#005FAF gui=italic ctermfg=25 cterm=italic')
    vim.cmd('highlight markdownListMarker guifg=#D75F00 ctermfg=166')
    vim.cmd('highlight markdownUrl guifg=#0000FF gui=underline ctermfg=21 cterm=underline')
    
    -- Set our new mappings
    -- F5: Preview (always light mode with black bold headings)
    vim.keymap.set('n', '<F5>', function()
      local file = vim.fn.expand('%:p')
      local style_path = vim.fn.expand('~/.config/glow/styles/light-preview.json')
      -- Open preview in a new split
      vim.cmd('botright vsplit')
      
      -- Set white background for this window before starting terminal
      vim.cmd('setlocal winhl=Normal:PreviewNormal,NormalNC:PreviewNormal')
      vim.cmd('highlight PreviewNormal guifg=#000000 guibg=#FFFFFF ctermfg=16 ctermbg=231')
      
      -- Start glow with custom light style (black bold headings, no # symbols)
      vim.cmd('terminal glow --style ' .. vim.fn.shellescape(style_path) .. ' ' .. vim.fn.shellescape(file))
      
      -- Ensure terminal uses light colors
      vim.cmd('setlocal termguicolors')
    end, { buffer = true, silent = true, desc = "Preview markdown" })
    
    -- F6: PDF Export
    vim.keymap.set('n', '<F6>', function()
      vim.cmd('write')
      local file = vim.fn.expand('%:p')
      local output = vim.fn.expand('%:p:r') .. '.pdf'
      
      vim.notify('Exporting PDF...', vim.log.levels.INFO)
      
      local cmd = string.format(
        'pandoc "%s" -o "%s" --pdf-engine=pdflatex -V geometry:margin=1in --highlight-style=tango',
        file, output
      )
      
      local result = vim.fn.system(cmd)
      if vim.v.shell_error == 0 then
        vim.notify('PDF exported → ' .. output, vim.log.levels.INFO)
        vim.fn.jobstart('xdg-open "' .. output .. '"', { detach = true })
      else
        vim.notify('PDF export failed: ' .. result, vim.log.levels.ERROR)
      end
    end, { buffer = true, silent = true, desc = "Export to PDF" })
    
    -- F7: HTML Export
    vim.keymap.set('n', '<F7>', function()
      vim.cmd('write')
      local file = vim.fn.expand('%:p')
      local output = vim.fn.expand('%:p:r') .. '.html'
      local title = vim.fn.expand('%:t:r')
      
      vim.notify('Exporting HTML...', vim.log.levels.INFO)
      
      local cmd = string.format(
        'pandoc "%s" -o "%s" -t html5 --embed-resources --standalone --metadata title="%s" --highlight-style=tango',
        file, output, title
      )
      
      local result = vim.fn.system(cmd)
      if vim.v.shell_error == 0 then
        vim.notify('HTML exported → ' .. output, vim.log.levels.INFO)
        vim.fn.jobstart('xdg-open "' .. output .. '"', { detach = true })
      else
        vim.notify('HTML export failed: ' .. result, vim.log.levels.ERROR)
      end
    end, { buffer = true, silent = true, desc = "Export to HTML" })
  end,
})

-- ===============================================
-- USER COMMANDS (Alternative to F-keys)
-- ===============================================

-- :MarkdownPreview - Preview with glow (side-by-side)
vim.api.nvim_create_user_command('MarkdownPreview', function()
  if vim.bo.filetype ~= 'markdown' then
    vim.notify('This command is only for markdown files', vim.log.levels.WARN)
    return
  end
  local file = vim.fn.expand('%:p')
  local style_path = vim.fn.expand('~/.config/glow/styles/notepadpp.json')
  vim.cmd('botright vsplit | terminal glow --style ' .. vim.fn.shellescape(style_path) .. ' ' .. vim.fn.shellescape(file))
end, { desc = "Preview markdown with glow" })

-- :MarkdownPreviewExternal - Open in external terminal (best colors)
vim.api.nvim_create_user_command('MarkdownPreviewExternal', function()
  if vim.bo.filetype ~= 'markdown' then
    vim.notify('This command is only for markdown files', vim.log.levels.WARN)
    return
  end
  local file = vim.fn.expand('%:p')
  -- Open in a new gnome-terminal window with glow
  vim.fn.jobstart('gnome-terminal -- glow ' .. vim.fn.shellescape(file), { detach = true })
  vim.notify('Opening preview in external terminal...', vim.log.levels.INFO)
end, { desc = "Preview markdown in external terminal" })

-- :MarkdownPDF - Export to PDF
vim.api.nvim_create_user_command('MarkdownPDF', function()
  if vim.bo.filetype ~= 'markdown' then
    vim.notify('This command is only for markdown files', vim.log.levels.WARN)
    return
  end
  
  vim.cmd('write')
  local file = vim.fn.expand('%:p')
  local output = vim.fn.expand('%:p:r') .. '.pdf'
  
  vim.notify('Exporting PDF...', vim.log.levels.INFO)
  
  local cmd = string.format(
    'pandoc "%s" -o "%s" --pdf-engine=pdflatex -V geometry:margin=1in --highlight-style=tango',
    file, output
  )
  
  local result = vim.fn.system(cmd)
  if vim.v.shell_error == 0 then
    vim.notify('PDF exported → ' .. output, vim.log.levels.INFO)
    vim.fn.jobstart('xdg-open "' .. output .. '"', { detach = true })
  else
    vim.notify('PDF export failed: ' .. result, vim.log.levels.ERROR)
  end
end, { desc = "Export markdown to PDF" })

-- :MarkdownHTML - Export to HTML
vim.api.nvim_create_user_command('MarkdownHTML', function()
  if vim.bo.filetype ~= 'markdown' then
    vim.notify('This command is only for markdown files', vim.log.levels.WARN)
    return
  end
  
  vim.cmd('write')
  local file = vim.fn.expand('%:p')
  local output = vim.fn.expand('%:p:r') .. '.html'
  local title = vim.fn.expand('%:t:r')
  
  vim.notify('Exporting HTML...', vim.log.levels.INFO)
  
  local cmd = string.format(
    'pandoc "%s" -o "%s" -t html5 --embed-resources --standalone --metadata title="%s" --highlight-style=tango',
    file, output, title
  )
  
  local result = vim.fn.system(cmd)
  if vim.v.shell_error == 0 then
    vim.notify('HTML exported → ' .. output, vim.log.levels.INFO)
    vim.fn.jobstart('xdg-open "' .. output .. '"', { detach = true })
  else
    vim.notify('HTML export failed: ' .. result, vim.log.levels.ERROR)
  end
end, { desc = "Export markdown to HTML" })

-- ===============================================
-- MODERN NEOVIM CONFIGURATION (2025)
-- ===============================================

-- Bootstrap lazy.nvim (modern Neovim plugin manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup with lazy.nvim
require("lazy").setup({
  -- File tree explorer (always available)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 35, side = "left" },
        renderer = { 
          highlight_git = true, 
          icons = { show = { file = true, folder = true } } 
        },
        filters = { dotfiles = false },
        update_focused_file = { enable = true },
      })
    end,
  },

  -- Which-key: shows available keybindings (always available)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require("which-key").setup({
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
        },
        window = {
          border = "rounded",
          position = "bottom",
        },
      })
    end,
  },

  -- ===============================================
  -- MARKDOWN PROFILE PLUGINS
  -- ===============================================
  
  -- Terminal markdown preview (glow) - only for markdown
  {
    "ellisonleao/glow.nvim",
    ft = "markdown",
    config = true,
    cmd = "Glow",
  },

  -- ===============================================
  -- TEXT FILE PROFILE PLUGINS
  -- ===============================================
  
  -- Goyo - distraction-free writing
  {
    "junegunn/goyo.vim",
    ft = "text",
    cmd = "Goyo",
  },
  
  -- Limelight - focus on current paragraph
  {
    "junegunn/limelight.vim",
    ft = "text",
    cmd = "Limelight",
  },
  
  -- Pencil - better text editing for prose
  {
    "preservim/vim-pencil",
    ft = "text",
  },

  -- ===============================================
  -- PYTHON PROFILE PLUGINS
  -- ===============================================
  
  -- LSP Configuration & Plugins (modern vim.lsp.config API)
  {
    "williamboman/mason.nvim",
    ft = { "python", "sh", "bash", "cpp", "c", "rust", "html", "css" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "bashls", "clangd", "rust_analyzer", "html", "cssls" },
        automatic_installation = true,
      })
      
      -- Use modern vim.lsp.config API (Neovim 0.11+)
      
      -- Setup pyright LSP
      vim.lsp.config.pyright = {
        cmd = { 'pyright-langserver', '--stdio' },
        filetypes = { 'python' },
        root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' },
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      }
      
      -- Setup bash-language-server LSP
      vim.lsp.config.bashls = {
        cmd = { 'bash-language-server', 'start' },
        filetypes = { 'sh', 'bash' },
        root_markers = { '.git' },
      }
      
      -- Setup clangd LSP for C++
      vim.lsp.config.clangd = {
        cmd = { 'clangd', '--background-index', '--clang-tidy' },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
        root_markers = { 'compile_commands.json', 'compile_flags.txt', '.git' },
      }
      
      -- Setup rust-analyzer LSP
      vim.lsp.config['rust_analyzer'] = {
        cmd = { 'rust-analyzer' },
        filetypes = { 'rust' },
        root_markers = { 'Cargo.toml', 'rust-project.json', '.git' },
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
            },
            checkOnSave = {
              command = "clippy",
            },
          },
        },
      }
      
      -- Setup HTML LSP
      vim.lsp.config.html = {
        cmd = { 'vscode-html-language-server', '--stdio' },
        filetypes = { 'html' },
        root_markers = { 'package.json', '.git' },
      }
      
      -- Setup CSS LSP
      vim.lsp.config.cssls = {
        cmd = { 'vscode-css-language-server', '--stdio' },
        filetypes = { 'css', 'scss', 'less' },
        root_markers = { 'package.json', '.git' },
      }
      
      -- Enable LSP servers via autocmd
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'python', 'sh', 'bash', 'c', 'cpp', 'rust', 'html', 'css' },
        callback = function(args)
          local servers = {
            python = 'pyright',
            sh = 'bashls',
            bash = 'bashls',
            c = 'clangd',
            cpp = 'clangd',
            rust = 'rust_analyzer',
            html = 'html',
            css = 'cssls',
          }
          local server = servers[vim.bo[args.buf].filetype]
          if server then
            vim.lsp.enable(server)
          end
        end,
      })
    end,
  },

  -- Autocompletion (latest versions)
  {
    "hrsh7th/nvim-cmp",
    ft = { "python", "sh", "bash", "cpp", "c", "rust", "html", "css" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      
      -- Load snippet support
      require("luasnip.loaders.from_vscode").lazy_load()
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        }),
      })
      
      -- File-type specific sources (enable luasnip only where it works)
      cmp.setup.filetype({ 'python', 'sh', 'bash', 'rust', 'cpp', 'c' }, {
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        })
      })
    end,
  },

  -- Python formatting with black
  {
    "psf/black",
    ft = "python",
    build = ":BlackUpgrade",
  },

  -- Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    ft = { "python", "markdown", "sh", "bash", "cpp", "c", "rust", "html", "css" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "python", "markdown", "markdown_inline", "bash", "cpp", "c", "rust", "html", "css" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- ===============================================
  -- SHELL SCRIPT PROFILE PLUGINS
  -- ===============================================
  
  -- ShellCheck linter integration (using nvim-lint instead of null-ls)
  {
    "mfussenegger/nvim-lint",
    ft = { "sh", "bash" },
    config = function()
      require('lint').linters_by_ft = {
        sh = {'shellcheck'},
        bash = {'shellcheck'},
      }
      
      -- Only run lint if shellcheck is available
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
        pattern = { "*.sh", "*.bash" },
        callback = function()
          if vim.fn.executable('shellcheck') == 1 then
            require("lint").try_lint()
          end
        end,
      })
    end,
  },
  
  -- Shell formatting with shfmt
  {
    "stevearc/conform.nvim",
    ft = { "sh", "bash" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          sh = { "shfmt" },
          bash = { "shfmt" },
        },
      })
    end,
  },

  -- ===============================================
  -- C++ PROFILE PLUGINS
  -- ===============================================
  
  -- C++ pair programming helpers
  {
    "jiangmiao/auto-pairs",
    ft = { "cpp", "c" },
  },
  
  -- CMake integration
  {
    "cdelledonne/vim-cmake",
    ft = { "cpp", "c", "cmake" },
  },

  -- ===============================================
  -- RUST PROFILE PLUGINS
  -- ===============================================
  
  -- Rust tools and utilities
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  
  -- Crates.io integration (show dependency versions)
  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup({
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
      })
    end,
  },

  -- ===============================================
  -- HTML/CSS PROFILE PLUGINS
  -- ===============================================
  
  -- Emmet support (fast HTML/CSS snippets)
  {
    "mattn/emmet-vim",
    ft = { "html", "css" },
  },
  
  -- Auto close HTML tags
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "xml" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  
  -- Color preview for CSS
  {
    "norcalli/nvim-colorizer.lua",
    ft = { "css", "html" },
    config = function()
      require("colorizer").setup({ "css", "html" })
    end,
  },
})

-- ===============================================
-- FILE TREE KEYBINDINGS
-- ===============================================

vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true, desc = "Toggle file tree" })
vim.keymap.set('n', '<leader>r', ':NvimTreeRefresh<CR>', { silent = true, desc = "Refresh file tree" })
vim.keymap.set('n', '<leader>n', ':NvimTreeFindFile<CR>', { silent = true, desc = "Find current file in tree" })

-- ===============================================
-- PYTHON PROFILE AUTO-CONFIGURATION
-- ===============================================

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    -- Python-specific settings
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
    vim.opt_local.textwidth = 88  -- Black's default line length
    
    -- Python LSP keybindings
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = true, desc = "Go to definition" })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = true, desc = "Show hover info" })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = true, desc = "Go to implementation" })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = true, desc = "Rename symbol" })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = true, desc = "Code actions" })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = true, desc = "Show references" })
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { buffer = true, desc = "Format code" })
    
    -- Python-specific commands
    vim.keymap.set('n', '<F5>', ':split | terminal python3 %<CR>', { buffer = true, desc = "Run Python file" })
    vim.keymap.set('n', '<F6>', ':Black<CR>', { buffer = true, desc = "Format with Black" })
    
    vim.notify('Python profile loaded', vim.log.levels.INFO)
  end,
})

-- Show notification when markdown profile loads
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.notify('Markdown profile loaded', vim.log.levels.INFO)
  end,
  once = false,
})

-- ===============================================
-- TEXT FILE PROFILE AUTO-CONFIGURATION
-- ===============================================

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'text',
  callback = function()
    -- Text file specific settings
    vim.opt_local.wrap = true          -- Wrap lines
    vim.opt_local.linebreak = true     -- Break at word boundaries
    vim.opt_local.textwidth = 80       -- 80 character width
    vim.opt_local.spell = true         -- Enable spell checking
    vim.opt_local.spelllang = 'en_us'  -- US English
    vim.opt_local.colorcolumn = '80'   -- Show column guide
    
    -- Softer tab settings for prose
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
    
    -- Enable pencil mode for better prose editing
    vim.cmd('PencilSoft')
    
    -- Text file keybindings
    vim.keymap.set('n', '<F5>', ':Goyo<CR>', { buffer = true, desc = "Toggle distraction-free mode" })
    vim.keymap.set('n', '<F6>', ':Limelight!!<CR>', { buffer = true, desc = "Toggle focus mode" })
    vim.keymap.set('n', '<F7>', ':set spell!<CR>', { buffer = true, desc = "Toggle spell check" })
    
    -- Word count command
    vim.keymap.set('n', '<leader>wc', function()
      local words = vim.fn.wordcount().words
      vim.notify('Word count: ' .. words, vim.log.levels.INFO)
    end, { buffer = true, desc = "Word count" })
    
    -- Navigation works on display lines (wrapped)
    vim.keymap.set('n', 'j', 'gj', { buffer = true, silent = true })
    vim.keymap.set('n', 'k', 'gk', { buffer = true, silent = true })
    
    vim.notify('Text file profile loaded (writing mode)', vim.log.levels.INFO)
  end,
})

-- ===============================================
-- SHELL SCRIPT PROFILE AUTO-CONFIGURATION
-- ===============================================

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'sh', 'bash' },
  callback = function()
    -- Shell script-specific settings
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
    vim.opt_local.textwidth = 80
    
    -- Shell LSP keybindings
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = true, desc = "Go to definition" })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = true, desc = "Show hover info" })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = true, desc = "Rename symbol" })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = true, desc = "Code actions" })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = true, desc = "Show references" })
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { buffer = true, desc = "Format code" })
    
    -- Shell script-specific commands
    vim.keymap.set('n', '<F5>', ':split | terminal bash %<CR>', { buffer = true, desc = "Run shell script" })
    vim.keymap.set('n', '<F6>', ':!shellcheck %<CR>', { buffer = true, desc = "Check with shellcheck" })
    vim.keymap.set('n', '<F7>', ':!chmod +x %<CR>', { buffer = true, desc = "Make executable" })
    
    -- Auto-insert shebang if file is empty
    if vim.fn.line('$') == 1 and vim.fn.getline(1) == '' then
      vim.fn.setline(1, '#!/usr/bin/env bash')
      vim.fn.append(1, '')
      vim.cmd('normal! 2G')
    end
    
    vim.notify('Shell script profile loaded', vim.log.levels.INFO)
  end,
})

-- ===============================================
-- C++ PROFILE AUTO-CONFIGURATION
-- ===============================================

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'cpp', 'c' },
  callback = function()
    -- C++ specific settings
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
    vim.opt_local.textwidth = 100
    vim.opt_local.commentstring = '// %s'
    
    -- C++ LSP keybindings
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = true, desc = "Go to definition" })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = true, desc = "Go to declaration" })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = true, desc = "Show hover info" })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = true, desc = "Go to implementation" })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = true, desc = "Rename symbol" })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = true, desc = "Code actions" })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = true, desc = "Show references" })
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { buffer = true, desc = "Format code" })
    vim.keymap.set('n', '<leader>h', ':ClangdSwitchSourceHeader<CR>', { buffer = true, desc = "Switch .cpp/.h" })
    
    -- C++ build and run commands
    vim.keymap.set('n', '<F5>', function()
      local file = vim.fn.expand('%:p')
      local output = vim.fn.expand('%:p:r')
      vim.cmd('split | terminal g++ -std=c++17 -Wall -Wextra ' .. vim.fn.shellescape(file) .. ' -o ' .. vim.fn.shellescape(output) .. ' && ' .. vim.fn.shellescape(output))
    end, { buffer = true, desc = "Compile and run C++" })
    
    vim.keymap.set('n', '<F6>', function()
      local file = vim.fn.expand('%:p')
      local output = vim.fn.expand('%:p:r')
      vim.cmd('!g++ -std=c++17 -Wall -Wextra ' .. vim.fn.shellescape(file) .. ' -o ' .. vim.fn.shellescape(output))
    end, { buffer = true, desc = "Compile C++" })
    
    vim.keymap.set('n', '<F7>', ':CMakeGenerate<CR>', { buffer = true, desc = "Generate CMake" })
    vim.keymap.set('n', '<F8>', ':CMakeBuild<CR>', { buffer = true, desc = "Build with CMake" })
    
    vim.notify('C++ profile loaded', vim.log.levels.INFO)
  end,
})

-- ===============================================
-- RUST PROFILE AUTO-CONFIGURATION
-- ===============================================

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'rust',
  callback = function()
    -- Rust specific settings
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
    vim.opt_local.textwidth = 100
    vim.opt_local.commentstring = '// %s'
    
    -- Rust LSP keybindings
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = true, desc = "Go to definition" })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = true, desc = "Go to declaration" })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = true, desc = "Show hover info" })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = true, desc = "Go to implementation" })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = true, desc = "Rename symbol" })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = true, desc = "Code actions" })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = true, desc = "Show references" })
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { buffer = true, desc = "Format code" })
    
    -- Rust-specific commands
    vim.keymap.set('n', '<F5>', ':split | terminal cargo run<CR>', { buffer = true, desc = "Cargo run" })
    vim.keymap.set('n', '<F6>', ':split | terminal cargo build<CR>', { buffer = true, desc = "Cargo build" })
    vim.keymap.set('n', '<F7>', ':split | terminal cargo test<CR>', { buffer = true, desc = "Cargo test" })
    vim.keymap.set('n', '<F8>', ':split | terminal cargo clippy<CR>', { buffer = true, desc = "Cargo clippy (lint)" })
    
    -- Rust tools extras
    vim.keymap.set('n', '<leader>rr', ':RustRunnables<CR>', { buffer = true, desc = "Rust runnables" })
    vim.keymap.set('n', '<leader>rd', ':RustDebuggables<CR>', { buffer = true, desc = "Rust debuggables" })
    vim.keymap.set('n', '<leader>rc', ':RustOpenCargo<CR>', { buffer = true, desc = "Open Cargo.toml" })
    vim.keymap.set('n', '<leader>rp', ':RustParentModule<CR>', { buffer = true, desc = "Go to parent module" })
    
    vim.notify('Rust profile loaded', vim.log.levels.INFO)
  end,
})

-- ===============================================
-- HTML PROFILE AUTO-CONFIGURATION
-- ===============================================

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'html',
  callback = function()
    -- HTML specific settings
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    
    -- HTML LSP keybindings
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = true, desc = "Go to definition" })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = true, desc = "Show hover info" })
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { buffer = true, desc = "Format code" })
    
    -- HTML-specific commands
    vim.keymap.set('n', '<F5>', function()
      local file = vim.fn.expand('%:p')
      vim.fn.jobstart('xdg-open "' .. file .. '"', { detach = true })
      vim.notify('Opening in browser...', vim.log.levels.INFO)
    end, { buffer = true, desc = "Open in browser" })
    
    -- Emmet expansion (Ctrl+Y, then comma)
    vim.g.user_emmet_leader_key = '<C-Y>'
    
    vim.notify('HTML profile loaded', vim.log.levels.INFO)
  end,
})

-- ===============================================
-- CSS PROFILE AUTO-CONFIGURATION
-- ===============================================

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'css',
  callback = function()
    -- CSS specific settings
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
    
    -- CSS LSP keybindings
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = true, desc = "Go to definition" })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = true, desc = "Show hover info" })
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { buffer = true, desc = "Format code" })
    
    -- Emmet expansion for CSS too
    vim.g.user_emmet_leader_key = '<C-Y>'
    
    vim.notify('CSS profile loaded (with color preview)', vim.log.levels.INFO)
  end,
})
