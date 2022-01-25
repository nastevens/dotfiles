local opt = vim.opt
opt.completeopt = {"menuone", "noinsert", "noselect"}
opt.fileformat = "unix"
opt.formatoptions:remove("o")
opt.ignorecase = true
opt.number = true
opt.relativenumber = true
opt.scrolloff = 4
opt.shiftround = true
opt.shortmess:append("c")
opt.showmatch = true
opt.sidescrolloff = 4
opt.signcolumn = "yes"
opt.smartcase = true
opt.smarttab = true
opt.spelllang = "en_us"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.undofile = true
opt.wildmode = {"longest", "full"}
opt.wrap = false

require("config.plugins")
require("config.mappings")
require("config.codeoptions").setup()

-- Briefly highlight yanked text
vim.cmd("au TextYankPost * lua vim.highlight.on_yank { on_visual = false }")
