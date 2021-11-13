vim.g.nvim_tree_add_trailing = 1
vim.g.nvim_tree_disable_window_picker = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_group_empty = 1

require("nvim-tree").setup {
  auto_close = true,
  diagonostics = {
    enable = true,
  },
  filters = {
    dotfiles = true,
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
