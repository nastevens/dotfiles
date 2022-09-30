local nvim_tree = require("nvim-tree")

nvim_tree.setup {
  actions = {
    open_file = {
      window_picker = {
        enable = true
      },
    },
  },
  diagnostics = {
    enable = true,
  },
  filters = {
    dotfiles = true,
  },
  git = {
    ignore = true,
  },
  hijack_cursor = true,
  renderer = {
    add_trailing = true,
    group_empty = true,
    highlight_git = true,
  },
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    ignore_list = {
      ".git",
      "node_modules",
      ".cache",
    },
  },
}
