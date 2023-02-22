require("nvim-lsp-installer").on_server_ready(function(server)
    local opts = require("config.plugins.lsp.defaults")

    if server.name == "sumneko_lua" then
        local lua_config = require("config.plugins.lsp.lua")
        opts = vim.tbl_deep_extend("force", opts, lua_config)
    end

    if server.name == "rust_analyzer" then
        local rust_config = require("config.plugins.lsp.rust")
        opts = vim.tbl_deep_extend("force", opts, rust_config)
    end

    server:setup(opts)
end)

require("lsp-status").register_progress()
require("rust-tools").setup {}
vim.cmd(
    [[autocmd CursorHold,CursorHoldI * lua require("nvim-lightbulb").update_lightbulb()]]
)
