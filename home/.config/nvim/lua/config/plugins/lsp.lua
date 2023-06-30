local M = {}

function M.mason_setup()
    require("mason").setup()
end

function M.mason_lspconfig_setup()
    require("mason-lspconfig").setup()
end

function M.lsp_apply(server_name, lsp_config)
    local lsps = require("lsp-status")
    lsp_config = lsp_config or {}
    local config = vim.tbl_extend("keep", lsp_config, {
        capabilities = lsps.capabilities,
        on_attach = lsps.on_attach,
    })
    require("lspconfig")[server_name].setup(config)
    require("lsp_signature").setup {
        bind = true,
        handler_opts = {
            border = "rounded",
        },
    }
end

function M.lspconfig_setup()
    require("mason-lspconfig").setup_handlers {
        -- default handler
        function(server_name)
            require("config.plugins.lsp").lsp_apply(server_name)
        end,
        ["rust_analyzer"] = function()
            require("config.plugins.lsp").lsp_apply("rust_analyzer", {
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            loadOutDirsFromCheck = true,
                        },
                        procMacro = {
                            enable = true,
                        },
                    },
                },
            })
            require("rust-tools").setup {
                tools = {
                    inlay_hints = {
                        parameter_hints_prefix = " ",
                        other_hints_prefix = " ",
                    },
                },
            }
            require("vimp").nnoremap("<space>c", "<cmd>RustOpenCargo<cr>")
            require("vimp").nnoremap("<space>x", "<cmd>RustRunnables<cr>")
            require("vimp").nnoremap("<C-M-j>", "<cmd>RustMoveItemDown<cr>")
            require("vimp").nnoremap("<C-M-k>", "<cmd>RustMoveItemUp<cr>")
        end,
    }
end

function M.lsp_status_setup()
    local lsps = require("lsp-status")
    lsps.register_progress()
    lsps.config {
        current_function = false,
        status_symbol = "[LSP]",
    }
end

function M.lightbulb_setup()
    vim.cmd(
        [[autocmd CursorHold,CursorHoldI * lua require("nvim-lightbulb").update_lightbulb()]]
    )
end

-- TODO: Example config https://github.com/shaeinst/roshnivim/blob/main/lua/plugins/null-ls_nvim.lua
function M.null_ls_setup()
    require("null-ls").setup()
end

return M
