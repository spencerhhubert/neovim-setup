-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
      'ibhagwan/fzf-lua',
      requires = { 'nvim-tree/nvim-web-devicons' }
  }

  use({
	  'rose-pine/neovim',
	  as = 'rose-pine',
	  config = function()
		  vim.cmd('colorscheme rose-pine')
	  end
  })

  use({'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'})

  use {
      'nvim-telescope/telescope.nvim', tag = '0.1.1',
      -- or                            , branch = '0.1.x',
      requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
      'mrcjkb/haskell-tools.nvim',
      requires = {
          'nvim-lua/plenary.nvim',
          'nvim-telescope/telescope.nvim', -- optional
      },
      branch = '1.x.x', -- recommended
  }

  use "terrortylor/nvim-comment"

end)