local nvim_tree = require("nvim-tree")

vim.g.nvim_tree_add_trailing = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_group_empty = 1

nvim_tree.setup {
  actions = {
    open_file = {
      window_picker = {
        enable = true
      },
    },
  },
  auto_close = true,
  diagonostics = {
    enable = true,
  },
  filters = {
    dotfiles = true,
  },
  git = {
    ignore = true,
  },
  hijack_cursor = true,
  update_focused_file = {
    enable = true,
    ignore_list = {
      ".git",
      "node_modules",
      ".cache",
    },
  },
}
