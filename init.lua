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
--vim.cmd[[colorscheme tokyonight]]
--these dont work and I dont know why, markdown is broken with no colorscheme selected. i dont want color scheme
--but yet ":set syntax=markdown" when in a .md works
--whatever
-- vim.cmd[[
--   augroup SetMarkdownFileType
--     autocmd!
--     autocmd BufNewFile,BufRead *.md set filetype=markdown
--   augroup END
-- ]]
-- vim.cmd[[autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc]]
--vim.cmd[[autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc]]

--telescope
require('telescope').setup{ defaults = { file_ignore_patterns = {"node_modules", ".build", ".git"} } }
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
require'lspconfig'.tsserver.setup {}
require'lspconfig'.svelte.setup{}

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

--treesitter
require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "haskell", "python", "typescript", "javascript", "svelte" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
