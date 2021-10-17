vim.g.nvim_tree_add_trailing = 1
vim.g.nvim_tree_disable_window_picker = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_hide_dotfiles = 1
vim.g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }

require("nvim-tree").setup {
  auto_close = true,
  hijack_cursor = true,
  lsp_diagnostics = true,
  update_focused_file = {
    enable = true,
  },
}
