local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
    autotag = {
        enable = true,
    },
    context_commentstring = {
        enable = true,
    },
    ensure_installed = "all",
    highlight = {
        enable = true,
        use_languagetree = false,
    },
    indent = {
        enable = false,
    },
    refactor = {
        highlight_definitions = { enable = false },
        highlight_current_scope = { enable = false },
    },
})
