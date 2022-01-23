local treesitter = require("nvim-treesitter.configs")

treesitter.setup {
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
  },
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = {
    enable = false,
  },
  refactor = {
    highlight_definitions = { enable = false },
    highlight_current_scope = { enable = false },
  },
}
