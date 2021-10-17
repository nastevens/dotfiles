-- Bootstrap packer if not installed
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
  vim.cmd("packadd packer.nvim")
end

-- Automatically recompile when plugins are changed
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Package startup and install
require("packer").startup(function(use)

  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  -- Colorscheme
  use {
    '~/dev/grayspace.nvim',
    requires = { "tjdevries/colorbuddy.nvim" }
  }
  use "ajh17/Spacegray.vim"
  use "norcalli/nvim-colorizer.lua"
  use "RRethy/nvim-base16"

  -- Add/change/delete surrounding characters
  use "tpope/vim-surround"

  -- Pairs of keybindings to jump files, buffers, etc
  use "tpope/vim-unimpaired"

  -- Sneak-like functionality, plus improved f/F/t/T
  use "ggandor/lightspeed.nvim"

  -- Auto-add closing pairs for quotes, brackets, etc
  use "steelsojka/pears.nvim"

  -- Auto-add end blocks for languages like ruby, vimscript, etc
  use "tpope/vim-endwise"

  -- Lua version of tpope/vim-commentary, comments and uncomments lines
  use "b3nj5m1n/kommentary"

  -- Add Bdelete and Bwipe which don't mess up windows when closing buffers
  use "famiu/bufdelete.nvim"

  -- Allow growing/shrinking selections
  use "terryma/vim-expand-region"

  -- Tabularize the things
  use "godlygeek/tabular"

  -- File explorer
  use {
    "kyazdani42/nvim-tree.lua",
    requires = { "kyazdani42/nvim-web-devicons" },
  }

  -- Quick pick lists
  use {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" }
  }

  -- Mark git changes in the gutter
  use {
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  }

  -- Treesitter support
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  -- LSP support
  use {
    "neovim/nvim-lspconfig",
    "nvim-lua/lsp-status.nvim",
    "kosayoda/nvim-lightbulb",
  }

  -- Completion
  use {
    "hrsh7th/nvim-cmp",
    requires = { "onsails/lspkind-nvim" },
  }
  use {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/cmp-path",
  }

  -- Git
  use "tpope/vim-fugitive"

  -- Snippets
  use {
    "hrsh7th/vim-vsnip",
    "rafamadriz/friendly-snippets"
  }

  -- Statusline
  use {
    "glepnir/galaxyline.nvim",
    branch = "main",
    requires = { "kyazdani42/nvim-web-devicons" },
  }

  -- Rust
  use {
    "Saecki/crates.nvim",
    branch = "main",
    requires = { "nvim-lua/plenary.nvim" }
  }
  use "simrat39/rust-tools.nvim"

  -- Standalone syntax files
  use {
    "hashivim/vim-terraform",
    "kergoth/vim-bitbake",
    "nastevens/vim-cargo-make",
    "nastevens/vim-duckscript",
    "ngg/vim-gn",
    "sheerun/vim-polyglot",
    "sirtaj/vim-openscad",
    "tmux-plugins/vim-tmux",
  }

  -- Vimwiki
  use "vimwiki/vimwiki"
  use "nastevens/stvimhelper"


end)

require("config.plugins")
