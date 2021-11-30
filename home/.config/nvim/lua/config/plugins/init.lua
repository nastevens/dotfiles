local packer = require("config.packer")

return packer.startup(function(use)
  use({
    -- Package manager
    "wbthomason/packer.nvim",
    -- Faster loading than built-in filetype.vim
    -- TODO: May be able to reduce files calling just coding-common
    "nathom/filetype.nvim",
    -- Common useful functions
    "nvim-lua/plenary.nvim",
  })

  -- Prettier notifications
  -- TODO: :Telescope notify lists notifications - add to an easy key binding?
  use({
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
  })

  -- Colorscheme
  -- TODO: Not complete, but getting closer to where I want it
  use {
    "~/dev/grayspace.nvim",
    requires = { "tjdevries/colorbuddy.nvim" }
  }

  -- Add/change/delete surrounding characters.
  use "tpope/vim-surround"

  -- Pairs of keybindings to jump files, buffers, etc.
  use "tpope/vim-unimpaired"

  -- Help plugins support repeating operations.
  use "tpope/vim-repeat"

  -- Sneak-like functionality, plus improved f/F/t/T.
  use "ggandor/lightspeed.nvim"

  -- Comments and uncomments lines
  use "tpope/vim-commentary"

  -- Todo highlights
  use {
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup({})
    end,
    event = "BufWinEnter",
    requires = "nvim-lua/plenary.nvim",
  }

  -- Colorized hex codes
  use {
    "norcalli/nvim-colorizer.lua",
    cmd = { "ColorizerToggle" },
    config = function()
      require("colorizer").setup()
    end,
    opt = true,
  }

  -- Add Bdelete and Bwipe which don't mess up windows when closing buffers
  use "famiu/bufdelete.nvim"

  -- Allow growing/shrinking selections
  use "terryma/vim-expand-region"

  -- Tabularize the things
  use "godlygeek/tabular"

  -- File explorer
  use {
    "kyazdani42/nvim-tree.lua",
    cmd = {
      "NvimTreeClipboard",
      "NvimTreeClose",
      "NvimTreeFindFile",
      "NvimTreeOpen",
      "NvimTreeRefresh",
      "NvimTreeToggle",
    },
    config = function()
      require("config.plugins.nvim-tree")
    end,
    opt = true,
    requires = {
      "kyazdani42/nvim-web-devicons"
    },
  }

  -- Quick pick lists
  use {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("config.plugins.telescope")
    end,
    event = "BufWinEnter",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
    },
  }

  -- Treesitter support
  use {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("config.plugins.treesitter")
    end,
    requires = {
      "windwp/nvim-ts-autotag",
      -- TODO: This might be able to enable comment/uncomment within Rust doc comments
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    run = ":TSUpdate",
  }

  -- LSP support
  -- TODO: Tons of stuff to improve in here, starting with key bindings
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require("config.plugins.lsp")
    end,
    requires = {
      {
        "ray-x/lsp_signature.nvim",
        config = function()
          -- must happen after servers are set up
          require("lsp_signature").setup({
            bind = true, -- This is mandatory, otherwise border config won't get registered.
            handler_opts = {
              border = "rounded",
            },
          })
        end,
        after = "nvim-lspconfig",
      },
      { "nvim-lua/lsp-status.nvim" },
      { 'williamboman/nvim-lsp-installer' },
    },
  }

  -- TODO: Integrate with toml-tools, selene, other formatters
  use {
    "jose-elias-alvarez/null-ls.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
  }

  -- Completion
  use {
    "hrsh7th/nvim-cmp",
    config = function()
      require("config.plugins.cmp").init()
    end,
    experimental = {
      ghost_text = true,
    },
    requires = {
      { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
      { "saadparwaiz1/cmp_luasnip", after = "cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer", after = "cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lua", after = "cmp-buffer" },
      { "hrsh7th/cmp-path", after = "cmp-nvim-lua" },
      {
        "windwp/nvim-autopairs",
        after = "cmp-path",
        config = function()
          require("config.plugins.cmp").autopairs()
        end,
      },
      -- TODO: currently disabled because of load-order issues
      {
        "onsails/lspkind-nvim",
        after = "nvim-autopairs",
        event = "InsertEnter",
      },
    },
  }

  -- Snippets
  use {
    "L3MON4D3/LuaSnip",
    config = function()
      require("config.plugins.luasnip")
    end,
    requires = {
      "rafamadriz/friendly-snippets",
    },
  }

  -- Git
  use {
    "tpope/vim-fugitive",
    opt = true,
    cmd = "Git",
  }

  -- Mark git changes in the gutter
  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
    event = "BufRead",
    opt = true,
    requires = {
      "nvim-lua/plenary.nvim"
    },
  }

  -- Statusline
  use {
    "glepnir/galaxyline.nvim",
    after = "nvim-web-devicons",
    branch = "main",
    config = function()
      require("config.plugins.statusline")
    end,
    requires = {
      "kyazdani42/nvim-web-devicons"
    },
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
  use {
    "vimwiki/vimwiki",
    config = function()
      require("config.plugins.vimwiki")
    end,
  }
  use "nastevens/stvimhelper"

  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end
  }

  -- Prevents cursor from trailing behind when typing 'k' as part of escape
  use {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup {
        mapping = {"kj"},
        timeout = vim.o.timeoutlen,
        clear_empty_lines = false,
        keys = "<Esc>",
      }
    end,
  }

  -- -- session/project management
  -- use({
  --   'glepnir/dashboard-nvim',
  --   config = function()
  --     require('cosmic.core.dashboard')
  --   end,
  --   disable = vim.tbl_contains(user_plugins.disable, 'dashboard'),
  -- })

  -- use({
  --   'rmagatti/auto-session',
  --   event = 'VimEnter',
  --   config = function()
  --     require('cosmic.core.session')
  --   end,
  --   disable = vim.tbl_contains(user_plugins.disable, 'auto-session'),
  -- })
end)
