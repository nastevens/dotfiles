local vimp = require("vimp")
local util = require("config.util")

-- Exit terminal insert mode with normal escape sequence
vimp.tnoremap("kj", "<C-\\><C-n>")

-- Insert current date/time
vim.cmd("iabbrev <expr> dts strftime('%Y-%m-%d')")
vim.cmd("iabbrev <expr> dtt strftime('%H:%M:%S')")

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
    vim.cmd("silent wa")
    dofile(vim.fn.stdpath("config") .. "/init.lua")
    require("packer").compile()
    vim.notify("Vim config reloaded")
end)

-- Open Telescope file browser in neovim config directory
vimp.nnoremap("<leader>ev", function()
    require("telescope.builtin").find_files {
        search_dirs = { vim.fn.stdpath("config") },
        get_selection_window = function(picker, entry)
            if not util.buffer_empty() then
                vim.cmd('vsplit')
            end
            return 0
        end,
    }
end)

-- Quick-edit plugins.lua
vimp.nnoremap("<leader>ep", function()
    local config = vim.fn.stdpath("config") .. "/lua/config/plugins.lua"
    util.smart_open_file(config)
end)

-- Quick-edit mappings.lua
vimp.nnoremap("<leader>em", function()
    local config = vim.fn.stdpath("config") .. "/lua/config/mappings.lua"
    util.smart_open_file(config)
end)

-- Quick-edit ftplugin for current file type
vimp.nnoremap("<leader>ef", function()
    local filetype = vim.bo.filetype
    local config = vim.fn.stdpath("config")
        .. "/ftplugin/"
        .. filetype
        .. ".lua"
    util.smart_open_file(config)
end)

-- General LSP mappings
vimp.nnoremap("<space>a", vim.lsp.buf.code_action)
vimp.nnoremap("<space>d", vim.lsp.buf.definition)
vimp.nnoremap("<space>f", vim.lsp.buf.format)
vimp.nnoremap("<space>m", vim.lsp.buf.rename)
vimp.nnoremap("<space>r", vim.lsp.buf.references)
vimp.nnoremap("<space>j", vim.diagnostic.goto_prev)
vimp.nnoremap("<space>k", vim.diagnostic.goto_next)
vimp.nnoremap("K", util.show_documentation)

-- Display style/treesitter under cursor
vimp.nnoremap("<c-i>", "<cmd>TSHighlightCapturesUnderCursor<cr>")
