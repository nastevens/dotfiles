local packer = require("config.packer")

return packer.module.startup(function(use)
  -- Package manager
  use "wbthomason/packer.nvim"

  -- Prettier notifications
  use({
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
  })

  -- Dispatch setting filetype through Lua instead of filetype.vim
  use {
    "nathom/filetype.nvim",
    config = function()
      require("filetype").setup({
        overrides = {
          literal = {
            Jenkinsfile = "groovy",
          },
        }
      })
    end,
  }

  -- Colorscheme
  use {
    "~/dev/grayspace.nvim",
    config = function()
      vim.cmd("colorscheme grayspace")
    end,
    requires = "tjdevries/colorbuddy.nvim",
  }

  -- Add/change/delete surrounding characters.
  use "tpope/vim-surround"

  -- Pairs of keybindings to jump files, buffers, etc.
  use "tpope/vim-unimpaired"

  -- Help plugins support repeating operations.
  use "tpope/vim-repeat"

  -- Comments and uncomments lines
  use "tpope/vim-commentary"

  -- Create keybindings using Lua functions
  use "svermeulen/vimpeccable"

  -- Sneak-like functionality, plus improved f/F/t/T.
  use "ggandor/lightspeed.nvim"

  -- Highlight todo's with different colors and gutter icons
  use {
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup({
        highlight = {
          keyword = "bg",
        }
      })
    end,
    event = "BufWinEnter",
    requires = "nvim-lua/plenary.nvim",
  }

  -- Colorize hex codes
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

  -- Tabularize the things
  use "godlygeek/tabular"

  -- File explorer
  use {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("config.plugins.nvim-tree")
    end,
    requires = {
      "kyazdani42/nvim-web-devicons"
    },
  }

  -- Code reference explorer
  use {
    "liuchengxu/vista.vim",
    config = function()
      require("config.plugins.vista")
    end,
  }

  -- Quick pick lists
  use {
    {
      "nvim-telescope/telescope.nvim",
      config = function()
        require("config.plugins.telescope")
      end,
      event = "BufWinEnter",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
      },
    },
    "nvim-telescope/telescope-ui-select.nvim",
  }

  -- Treesitter support
  use {
    {
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require("config.plugins.treesitter")
      end,
      run = ":TSUpdate",
    },
    { "windwp/nvim-ts-autotag", after = "nvim-treesitter", },
    { "nvim-treesitter/playground", after = "nvim-treesitter", },
    { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" },
  }

  -- Language server support
  use {
    {
      "neovim/nvim-lspconfig",
      config = function()
        require("config.plugins.lsp")
      end,
    },
    {
      -- TODO: Example config https://github.com/shaeinst/roshnivim/blob/main/lua/plugins/null-ls_nvim.lua
      "jose-elias-alvarez/null-ls.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "neovim/nvim-lspconfig",
      },
    },
    "nvim-lua/lsp-status.nvim",
    "ray-x/lsp_signature.nvim",
    "williamboman/nvim-lsp-installer",
    "kosayoda/nvim-lightbulb",
  }

  -- Completion
  use {
    {
      "hrsh7th/nvim-cmp",
      config = function()
        require("config.plugins.cmp").init()
      end,
      requires = "onsails/lspkind-nvim",
    },
    {
      "windwp/nvim-autopairs",
      config = function()
        require("config.plugins.cmp").autopairs()
      end,
    },
    { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
    { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
    { "hrsh7th/cmp-path", after = "nvim-cmp" },
    { "saadparwaiz1/cmp_luasnip", after = { "nvim-cmp", "LuaSnip" } },
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
    cmd = { "Git", "Gwrite" },
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
    "NTBBloodbath/galaxyline.nvim",
    after = "nvim-web-devicons",
    branch = "main",
    config = function()
      require("config.plugins.statusline")
    end,
    requires = {
      "kyazdani42/nvim-web-devicons"
    },
  }


  -- Quickfix/diagnostics browser
  use {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
    requires = "kyazdani42/nvim-web-devicons",
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
    -- "sheerun/vim-polyglot",
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

  -- Some sums
  use "vim-scripts/visSum.vim"

  -- Write and execute Lua in a scratch buffer
  use "rafcamlet/nvim-luapad"

  if packer.bootstrap then
    packer.module.sync()
  end
end)
