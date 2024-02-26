local packer = nil

local function bootstrap()
    local packer_path = vim.fn.stdpath("data")
        .. "/site/pack/packer/start/packer.nvim"
    vim.notify("Cloning packer..")
    vim.fn.delete(packer_path, "rf") -- remove the dir before cloning
    vim.fn.system {
        "git",
        "clone",
        "https://github.com/wbthomason/packer.nvim",
        "--depth",
        "1",
        packer_path,
    }
    vim.cmd("packadd packer.nvim")
end

local function init()
    if packer == nil then
        local installed, _ = pcall(require, "packer")
        if not installed then
            bootstrap()
        end
        packer = require("packer")
    end

    packer.init {
        compile_on_sync = true,
        display = {
            open_fn = function()
                local result, win, buf = require("packer.util").float {
                    border = {
                        { "╭", "FloatBorder" },
                        { "─", "FloatBorder" },
                        { "╮", "FloatBorder" },
                        { "│", "FloatBorder" },
                        { "╯", "FloatBorder" },
                        { "─", "FloatBorder" },
                        { "╰", "FloatBorder" },
                        { "│", "FloatBorder" },
                    },
                }
                vim.api.nvim_win_set_option(
                    win,
                    "winhighlight",
                    "NormalFloat:Normal"
                )
                return result, win, buf
            end,
        },
    }

    local use = packer.use
    packer.reset()

    -- Package manager
    use("wbthomason/packer.nvim")

    -- Prettier notifications
    use {
        "rcarriga/nvim-notify",
        config = function()
            vim.notify = require("notify")
        end,
    }

    -- Required for my "grayspace" colorscheme
    use {
        "tjdevries/colorbuddy.nvim",
        config = function()
            -- Set colorscheme after we're sure colorbuddy has been loaded
            vim.cmd("colorscheme grayspace")
        end,
    }

    -- Add/change/delete surrounding characters.
    use("tpope/vim-surround")

    -- Language server support
    use {
        {
            "williamboman/mason.nvim",
            config = require("config.plugins.lsp").mason_setup,
        },
        {
            "williamboman/mason-lspconfig.nvim",
            config = require("config.plugins.lsp").mason_lspconfig_setup,
            after = "mason.nvim",
        },
        {
            "neovim/nvim-lspconfig",
            config = require("config.plugins.lsp").lspconfig_setup,
            after = "mason-lspconfig.nvim",
        },
        {
            "nvim-lua/lsp-status.nvim",
            config = require("config.plugins.lsp").lsp_status_setup,
        },
        {
            "ray-x/lsp_signature.nvim",
        },
        {
            "kosayoda/nvim-lightbulb",
            config = require("config.plugins.lsp").lightbulb_setup,
        },
        {
            "nvimtools/none-ls.nvim",
            requires = "nvim-lua/plenary.nvim",
            config = function()
                local null_ls = require("null-ls")
                null_ls.setup {
                    sources = {
                        null_ls.builtins.formatting.stylua,
                    }
                }
            end,
        },
        {
            "simrat39/rust-tools.nvim",
        },
    }

    -- Pairs of keybindings to jump files, buffers, etc.
    use("tpope/vim-unimpaired")

    -- Help plugins support repeating operations.
    use("tpope/vim-repeat")

    -- Comments and uncomments lines
    use("tpope/vim-commentary")

    -- Create keybindings using Lua functions
    use("svermeulen/vimpeccable")

    -- Sneak-like functionality
    use {
        "ggandor/leap.nvim",
        config = function()
            require("leap").set_default_keymaps()
        end,
    }

    -- Highlight todo's with different colors and gutter icons
    use {
        "folke/todo-comments.nvim",
        config = function()
            require("todo-comments").setup {
                highlight = {
                    keyword = "bg",
                },
            }
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
    use("famiu/bufdelete.nvim")

    -- Tabularize the things
    use("godlygeek/tabular")

    -- File explorer
    use {
        "kyazdani42/nvim-tree.lua",
        config = function()
            require("config.plugins.nvim-tree")
        end,
        requires = {
            "kyazdani42/nvim-web-devicons",
        },
    }

    -- Quick pick lists and tools
    use {
        {
            "nvim-telescope/telescope.nvim",
            config = function()
                require("config.plugins.telescope")
            end,
            requires = {
                "nvim-lua/plenary.nvim",
                "nvim-lua/popup.nvim",
            },
        },
        "nvim-telescope/telescope-ui-select.nvim",
        "benfowler/telescope-luasnip.nvim",
        "xiyaowong/telescope-emoji.nvim",
        {
            "AckslD/nvim-neoclip.lua",
            config = function()
                require("neoclip").setup()
            end,
        },
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
        { "windwp/nvim-ts-autotag", after = "nvim-treesitter" },
        { "nvim-treesitter/playground", after = "nvim-treesitter" },
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
        requires = {
            "nvim-lua/plenary.nvim",
        },
    }

    -- Statusline
    use {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup {
                options = {
                    disabled_filetypes = { "NvimTree", "packer" },
                    theme = "onedark",
                },
                sections = {
                    lualine_y = { "progress", "location" },
                    lualine_z = { "require('lsp-status').status()" },
                },
            }
        end,
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
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
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("crates").setup {
                null_ls = {
                    enabled = true,
                },
            }
        end,
    }

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
    use("nastevens/stvimhelper")

    -- Prevents cursor from trailing behind when typing 'k' as part of escape
    use {
        "max397574/better-escape.nvim",
        config = function()
            require("better_escape").setup {
                mapping = { "kj" },
                timeout = vim.o.timeoutlen,
                clear_empty_lines = false,
                keys = "<Esc>",
            }
        end,
    }

    -- UI for chained keybindings
    use {
        "nvimtools/hydra.nvim",
        config = function()
            require("config.plugins.hydra")
        end,
    }

    -- Some sums
    use("vim-scripts/visSum.vim")

    -- Write and execute Lua in a scratch buffer
    use("rafcamlet/nvim-luapad")

    use {
        "anuvyklack/windows.nvim",
        requires = {
            "anuvyklack/middleclass",
            "anuvyklack/animation.nvim",
        },
        config = function()
            vim.o.winwidth = 10
            vim.o.winminwidth = 10
            vim.o.equalalways = false
            require("windows").setup()
        end,
    }

    if packer.bootstrap then
        packer.module.sync()
    end
end

init()
