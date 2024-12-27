--for some reason tree wants this
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd("source ~/.config/nvim/old_vim_rc.vim")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--need to define mapleader before requiring lazy
vim.g.mapleader = " "

require("lazy").setup("plugins")

--telescope
require('telescope').setup { defaults = { file_ignore_patterns = { "node_modules", ".build", ".git" } } }
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>gg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

--tree
vim.keymap.set('n', '<leader>tt', ':NvimTreeOpen<CR>', {})

require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = false,
        git = true,
        modified = false,
        diagnostics = false,
        bookmarks = false,
      }
    }
  },
  filters = {
    dotfiles = false,
    git_ignored = false,
  },
})

local opts = { noremap=true, silent=true }
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

-- Add diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

--solarized
---@type solarized.styles
local styles = {
      comments = { italic = true, bold = false },
      functions = { italic = false },
      variables = { italic = false },
}
require('solarized').setup({
    styles = styles,
})

--lsp
local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      hint = {
        enable = true,
      },
      runtime = {
        version = 'LuaJIT',
      },
      workspace = {
        checkThirdParty = true,
        library = {
          vim.env.VIMRUNTIME,
          '~/.local/share/nvim/lazy/solarized.nvim',
        },
      },
    },
  },
}

-- LSP server configurations
lspconfig.pyright.setup{}
lspconfig.ts_ls.setup({
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" }
})
lspconfig.svelte.setup{}

--copilot
vim.keymap.set('i', '<C-W>', '<Plug>(copilot-accept-word)')
vim.keymap.set('i', '<C-S>', '<Plug>(copilot-accept-line)')
vim.keymap.set('i', '<C-D>', '<Plug>(copilot-suggest)')
vim.keymap.set("i", "<C-;>", "copilot#Next()", { expr = true, silent = true, noremap = true })
vim.keymap.set("i", "<C-'>", "copilot#Previous()", { expr = true, silent = true, noremap = true })
--reset accept suggestion from tab to control y
vim.keymap.set("i", "<C-Y>", "copilot#accept()", { expr = true, silent = true, noremap = true })


--tmux
require("tmux").setup({
  copy_sync = {
    enable = true,
    redirect_to_clipboard = true,
  },
})


-- make nvim inherit colors from terminal
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

--avante
--something they recommended idk
vim.opt.laststatus = 3

vim.opt.background = 'light'   -- Set light background

-- Set GUI font to JetBrains Mono Nerd Font
vim.opt.guifont = "JetBrainsMono Nerd Font:h11"
