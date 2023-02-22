local M = {}

function M.mason_setup()
    require("mason").setup()
end

function M.mason_lspconfig_setup()
    require("mason-lspconfig").setup()
end

local function lspconfig_rust_setup()
    -- TODO: do I want this?
    -- require("rust-tools").setup {}
    require("lspconfig")["rust_analyzer"].setup {
        settings = {
            ["rust-analyzer"] = {
                cargo = {
                    loadOutDirsFromCheck = true,
                },
                procMacro = {
                    enable = true,
                },
            }
        }
    }
end

function M.lspconfig_setup()
    require("mason-lspconfig").setup_handlers {
        -- default handler
        function(server_name)
            require("lspconfig")[server_name].setup {}
            require("lsp_signature").setup {
                bind = true,
                handler_opts = {
                    border = "rounded",
                }
            }
        end,
        ["rust_analyzer"] = lspconfig_rust_setup,
    }
end

function M.lsp_status_setup()
    -- TODO: this registers the listener but doesn't do anything with the info
    require("lsp-status").register_progress()
end

function M.lightbulb_setup()
    vim.cmd(
        [[autocmd CursorHold,CursorHoldI * lua require("nvim-lightbulb").update_lightbulb()]]
    )
end

-- TODO: Example config https://github.com/shaeinst/roshnivim/blob/main/lua/plugins/null-ls_nvim.lua
function M.null_ls_setup()
end

return M
