local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function buffer_empty()
  local buffer_lines = vim.api.nvim_buf_get_lines(0, 0, vim.fn.line("$"), true)
  if buffer_lines[1] == "" and #buffer_lines == 1 then
    return true
  else
    return false
  end
end

local function smart_open_file(path)
  if buffer_empty() then
    vim.cmd("edit " .. path)
  else
    vim.cmd("vsplit " .. path)
  end
end

local vimp = require("vimp")

-- Add a new line before or after
vimp.nnoremap({"repeatable", "silent"}, "<c-j>", "<cmd>set paste<cr>m`o<esc>``<cmd>set nopaste<cr>")
vimp.nnoremap({"repeatable", "silent"}, "<C-k>", "<cmd>set paste<cr>m`O<esc>``<cmd>set nopaste<cr>")

-- Insert one space
vimp.nnoremap("<space><space>", "i <esc>")

-- Toggle spelling on/off
vimp.nnoremap("<leader>sp", "<cmd>setlocal invspell<cr>")

-- Perform a full reload of vim configuration and plugins
vimp.nnoremap("<leader>sv", function()
  vimp.unmap_all()
  require("packer").reset()
  require("config.util").unload_lua_namespace("config")
  vim.cmd("silent wa")
  dofile(vim.fn.stdpath("config") .. "/init.lua")
  require("packer").compile()
  require("notify")("Vim config reloaded")
end)

-- Open Telescope file browser in neovim config directory
vimp.nnoremap("<leader>ev", function()
  if not buffer_empty() then
    vim.cmd("vsplit")
  end
  require("telescope.builtin").find_files({
    search_dirs = { vim.fn.stdpath("config") },
  })
end)

-- Quick-edit plugins.lua
vimp.nnoremap("<leader>ep", function()
  local config = vim.fn.stdpath("config") .. "/lua/config/plugins.lua"
  smart_open_file(config)
end)

-- Quick-edit mappings.lua
vimp.nnoremap("<leader>em", function()
  local config = vim.fn.stdpath("config") .. "/lua/config/mappings.lua"
  smart_open_file(config)
end)

-- Quick-edit ftplugin for current file type
vimp.nnoremap("<leader>ef", function()
  local filetype = vim.bo.filetype
  local config = vim.fn.stdpath("config") .. "/ftplugin/" .. filetype .. ".lua"
  smart_open_file(config)
end)

-- Open file explorer
vimp.nnoremap("<leader>n", "<cmd>NvimTreeToggle<cr>")

-- Telescope mappings
vimp.nnoremap("<C-b>", "<cmd>Telescope buffers<cr>")
vimp.nnoremap("<C-f>", "<cmd>Telescope find_files<cr>")
vimp.nnoremap("<C-h>", "<cmd>Telescope help_tags<cr>")
vimp.nnoremap("<C-p>", "<cmd>Telescope live_grep<cr>")
vimp.nnoremap("<C-q>", "<cmd>Telescope quickfix<cr>")

-- Vimwiki mappings
vimp.nmap({"override"}, "<leader>wp", "<cmd>norm 1<leader>ww<cr>")
vimp.nmap({"override"}, "<leader>wo", "<cmd>norm 2<leader>ww<cr>")
vimp.nnoremap("<leader>sc", function()
  local path = vim.env.DROPBOX .. "/scratchpad.wiki"
  smart_open_file(path)
end)

-- Overlength mappings
vimp.nnoremap("<leader>l1", function() require("config.coding-common").overlength(80) end)
vimp.nnoremap("<leader>l2", function() require("config.coding-common").overlength(120) end)
vimp.nnoremap("<leader>l3", function() require("config.coding-common").overlength(200) end)
vimp.nnoremap("<leader>lo", function() require("config.coding-common").overlength(nil) end)

-- LSP mappings
-- vimp.nnoremap("ga", "<cmd>Telescope lsp_code_actions<CR>")
-- vimp.nnoremap("gd", "<cmd>Telescope lsp_definitions<CR>")
-- map("i", "<Tab>", "pumvisible() ? \"\\<C-n>\" : \"\\<Tab>\"", {expr = true})
-- map("i", "<S-Tab>", "pumvisible() ? \"\\<C-p>\" : \"\\<S-Tab>\"", {expr = true})
-- map('n', '<space>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
-- map('n', '<space>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
-- map('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
-- map('n', '<space>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
-- map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
vimp.nnoremap('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
-- map('n', '<space>m', '<cmd>lua vim.lsp.buf.rename()<CR>')
-- map('n', '<space>r', '<cmd>lua vim.lsp.buf.references()<CR>')
-- map('n', '<space>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
