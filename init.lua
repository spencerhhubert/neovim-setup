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

--colors
vim.cmd[[colorscheme tokyonight]]

--telescope
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

--lsp
require'lspconfig'.pyright.setup{}

--copilot
vim.keymap.set('i', '<C-W>', '<Plug>(copilot-accept-word)')
vim.keymap.set('i', '<C-S>', '<Plug>(copilot-accept-line)')
vim.keymap.set('i', '<C-D>', '<Plug>(copilot-suggest)')
vim.keymap.set("i", "<C-;>", "copilot#Next()", {expr=true, silent=true, noremap=true})
vim.keymap.set("i", "<C-'>", "copilot#Previous()", {expr=true, silent=true, noremap=true})

--tmux
require("tmux").setup({
  copy_sync = {
    enable = true,
    redirect_to_clipboard = true,
  },
})
