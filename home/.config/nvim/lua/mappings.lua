local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Use 'kj' instead of escape
map("i", "kj", "<Esc>")

-- Add a new line before or after
map("n", "<C-j>", "<cmd>set paste<CR>m`o<Esc>``<cmd>set nopaste<CR>")
map("n", "<C-k>", "<cmd>set paste<CR>m`O<Esc>``<cmd>set nopaste<CR>")

-- Insert one space
map("n", "<Space><Space>", "i <Esc>")

-- Toggle spelling on/off
map("n", "<leader>sp", "<cmd>setlocal invspell<CR>")

-- Edit and source init.lua
map("n", "<leader>ev", "<cmd>vsplit $MYVIMRC<CR>")
map("n", "<leader>sv", "<cmd>source $MYVIMRC<CR>")

-- Edit plugins.lua
function _G.edit_config_file(path)
  local config = vim.fn.stdpath("config") .. "/" .. path
  vim.cmd("vsplit " .. config)
end
map("n", "<leader>ep", "<cmd>call v:lua.edit_config_file('lua/plugins.lua')<CR>")
map("n", "<leader>em", "<cmd>call v:lua.edit_config_file('lua/mappings.lua')<CR>")

-- Edit ftplugin for current file type
function _G.edit_filetype()
  local filetype = vim.bo.filetype
  local config = vim.fn.stdpath("config") .. "/ftplugin/" .. filetype .. ".lua"
  vim.cmd("vsplit " .. config)
end
map("n", "<leader>ef", "<cmd>call v:lua.edit_filetype()<CR>")

-- Open file explorer
map("n", "<leader>n", "<cmd>NvimTreeToggle<CR>")

-- Expand-region mappings
map("v", "v", "<Plug>(expand_region_expand)", { noremap = false })
map("v", "V", "<Plug>(expand_region_shrink)", { noremap = false })

-- Telescope mappings
map("n", "<C-b>", "<cmd>Telescope buffers<CR>")
map("n", "<leader>be", "<cmd>Telescope buffers<CR>")
map("n", "<C-f>", "<cmd>Telescope find_files<CR>")
map("n", "<C-h>", "<cmd>Telescope help_tags<CR>")
map("n", "<C-p>", "<cmd>Telescope live_grep<CR>")
map("n", "<C-q>", "<cmd>Telescope quickfix<CR>")
map("n", "ga", "<cmd>Telescope lsp_code_actions<CR>")
map("n", "gd", "<cmd>Telescope lsp_definitions<CR>")

-- Vimwiki mappings
map("n", "<leader>wp", "<cmd>norm 1\\ww<CR>")
map("n", "<leader>wo", "<cmd>norm 2\\ww<CR>")
map("n", "<leader>wo\\i", "<cmd>norm 2\\wi<CR>")
function _G.scratchpad()
  local path = vim.env.DROPBOX .. "/scratchpad.wiki"
  vim.cmd("edit " .. path)
end
map("n", "<leader>sc", "<cmd>call v:lua.scratchpad()<CR>")

-- Overlength mappings
map("n", "<leader>l", "<cmd>lua require('config.coding-common').overlength(80)<CR>")
map("n", "<leader>ll", "<cmd>lua require('config.coding-common').overlength(120)<CR>")
map("n", "<leader>lll", "<cmd>lua require('config.coding-common').overlength(200)<CR>")
map("n", "<leader>lo", "<cmd>lua require('config.coding-common').overlength(nil)<CR>")

-- LSP mappings
-- map("i", "<Tab>", "pumvisible() ? \"\\<C-n>\" : \"\\<Tab>\"", {expr = true})
-- map("i", "<S-Tab>", "pumvisible() ? \"\\<C-p>\" : \"\\<S-Tab>\"", {expr = true})
-- map('n', '<space>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
-- map('n', '<space>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
-- map('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
-- map('n', '<space>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
-- map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
-- map('n', '<space>m', '<cmd>lua vim.lsp.buf.rename()<CR>')
-- map('n', '<space>r', '<cmd>lua vim.lsp.buf.references()<CR>')
-- map('n', '<space>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
