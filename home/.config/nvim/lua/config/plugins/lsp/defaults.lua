local cmp_lsp = require("cmp_nvim_lsp")

return {
    autostart = true,
    capabilities = cmp_lsp.default_capabilities(),
    flags = {
        debounce_text_changes = 150,
    },
    on_attach = function(_, bufnr)
        -- Enables pop-up box with function signature
        require("lsp_signature").on_attach({
            bind = true,
            handler_opts = {
                border = "rounded",
            },
        }, bufnr)
    end,
}
