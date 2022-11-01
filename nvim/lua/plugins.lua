-- Bootstrap packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local profile = require('plugin-profile')

-- Configure packer
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Gruvbox color scheme
  use { 
    'morhetz/gruvbox',
    config = profile.gruvbox.config
  }

  -- Support for repeating custom commands with '.' key
  use 'tpope/vim-repeat'

  -- Much quicker movment across the visible screen
  use { 
    'ggandor/leap.nvim',
    config = profile.leap.config
  }

  use {
    'folke/which-key.nvim',
    config = profile.whichkey.config
  }

  -- Flexible fuzzy search over files and other useful neovim's global tables
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = profile.telescope.config
  }

  use {
    'nvim-neo-tree/neo-tree.nvim',
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = profile.neotree.config
  }

  -- Package manager for LSPs and other external utilities
  use {
    'williamboman/mason.nvim',
    config = profile.mason.config
  }

  -- Intergration of Mason with lspconfig
  use {
    'williamboman/mason-lspconfig.nvim',
    config = profile.mason_lspconfig.config,
    requires = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    after = {
      'mason.nvim',
    }
  }

  -- Plugin responsible for configuring LSPs for nvim
  use {
    'neovim/nvim-lspconfig',
    config = profile.lspconfig.config,
    after = {
      'mason-lspconfig.nvim'
    }
  }


  use {
    'sheerun/vim-polyglot'
  }

  use {
    'evanleck/vim-svelte',
    requires = {
      'sheerun/vim-polyglot'
    },
    after = {
      'vim-polyglot'
    }
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
