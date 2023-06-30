local function buffer_empty()
    local buffer_lines =
        vim.api.nvim_buf_get_lines(0, 0, vim.fn.line("$"), true)
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

local function show_documentation()
    local filetype = vim.bo.filetype
    if vim.tbl_contains({ "vim", "help" }, filetype) then
        vim.cmd("help " .. vim.fn.expand("<cword>"))
    elseif vim.tbl_contains({ "man" }, filetype) then
        vim.cmd("Man " .. vim.fn.expand("<cword>"))
    elseif
        vim.fn.expand("%:t") == "Cargo.toml"
        and require("crates").popup_available()
    then
        require("crates").show_popup()
    else
        vim.lsp.buf.hover()
    end
end

local vimp = require("vimp")

-- Add a new line before or after
vimp.nnoremap(
    { "repeatable", "silent" },
    "<c-j>",
    "<cmd>set paste<cr>m`o<esc>``<cmd>set nopaste<cr>"
)
vimp.nnoremap(
    { "repeatable", "silent" },
    "<c-k>",
    "<cmd>set paste<cr>m`O<esc>``<cmd>set nopaste<cr>"
)

-- Insert one space
vimp.nnoremap("<space><space>", "i <esc>")

-- Toggle spelling on/off
vimp.nnoremap("<leader>sp", "<cmd>setlocal invspell<cr>")

-- Perform a full reload of vim configuration and plugins
vimp.nnoremap("<leader>sv", function()
    vimp.unmap_all()
    require("packer").reset()
    require("config.util").unload_lua_namespace("config")
    -- require("colorbuddy.color")._clear_colors()
    -- require("colorbuddy.group")._clear_groups()
    vim.cmd("silent wa")
    dofile(vim.fn.stdpath("config") .. "/init.lua")
    require("packer").compile()
    vim.notify("Vim config reloaded")
end)

-- Open Telescope file browser in neovim config directory
vimp.nnoremap("<leader>ev", function()
    require("telescope.builtin").find_files {
        search_dirs = { vim.fn.stdpath("config") },
    }
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
    local config = vim.fn.stdpath("config")
        .. "/ftplugin/"
        .. filetype
        .. ".lua"
    smart_open_file(config)
end)

-- Toggle file explorer
vimp.nnoremap("<leader>n", "<cmd>NvimTreeToggle<cr>")

-- Toggle code overview
vimp.nnoremap("<leader>v", "<cmd>Vista!!<cr>")

-- Vimwiki mappings
vimp.nmap({ "override" }, "<leader>wp", "<cmd>norm 1<leader>ww<cr>")
vimp.nmap({ "override" }, "<leader>wo", "<cmd>norm 2<leader>ww<cr>")
vimp.nnoremap("<leader>sc", function()
    local path = vim.env.DROPBOX .. "/scratchpad.wiki"
    smart_open_file(path)
end)

-- Overlength mappings
vimp.nnoremap("<leader>l1", function()
    require("config.codeoptions").overlength(80)
end)
vimp.nnoremap("<leader>l2", function()
    require("config.codeoptions").overlength(120)
end)
vimp.nnoremap("<leader>l3", function()
    require("config.codeoptions").overlength(200)
end)
vimp.nnoremap("<leader>lo", function()
    require("config.codeoptions").overlength(nil)
end)

-- LSP mappings
vimp.nnoremap("<space>a", vim.lsp.buf.code_action)
vimp.nnoremap("<space>d", vim.lsp.buf.definition)
vimp.nnoremap("<space>f", vim.lsp.buf.format)
vimp.nnoremap("<space>m", vim.lsp.buf.rename)
vimp.nnoremap("<space>r", vim.lsp.buf.references)
vimp.nnoremap("<space>j", vim.diagnostic.goto_prev)
vimp.nnoremap("<space>k", vim.diagnostic.goto_next)
vimp.nnoremap("K", show_documentation)

-- Display style/treesitter under cursor
vimp.nnoremap("<c-i>", "<cmd>TSHighlightCapturesUnderCursor<cr>")

-- Exit terminal insert mode with normal escape sequence
vimp.tnoremap("kj", "<C-\\><C-n>")
