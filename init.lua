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
	git = false,
	modified = false,
	diagnostics = false,
	bookmarks = false,
      }
    }
  },
  filters = {
    dotfiles = true,
  },
})

--lsp
require'lspconfig'.pyright.setup{}
