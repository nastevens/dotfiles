local packer = require("config.packer")

return packer.module.startup(function(use)
  -- Package manager
  use "wbthomason/packer.nvim"

  -- Common useful functions
  use "nvim-lua/plenary.nvim"

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
      require("filetype")
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
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("config.plugins.treesitter")
    end,
    requires = {
      {
        "windwp/nvim-ts-autotag",
        after = "nvim-treesitter",
      },
      {
        "nvim-treesitter/playground",
        after = "nvim-treesitter",
      },
      {
        -- TODO: This might be able to enable comment/uncomment within Rust doc comments
        "JoosepAlviste/nvim-ts-context-commentstring"
      },
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
      { "williamboman/nvim-lsp-installer" },
    },
  }

  -- TODO: Integrate with toml-tools, selene, other formatters
  -- Example config: https://github.com/shaeinst/roshnivim/blob/main/lua/plugins/null-ls_nvim.lua
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

  use "rafcamlet/nvim-luapad"

  if packer.bootstrap then
    packer.module.sync()
  end
end)
