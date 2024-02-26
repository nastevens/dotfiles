local M = {}

M.unload_lua_namespace = function(prefix)
    local prefix_with_dot = prefix .. "."
    for key, _ in pairs(package.loaded) do
        if key == prefix or key:sub(1, #prefix_with_dot) == prefix_with_dot then
            package.loaded[key] = nil
        end
    end
end

M.buffer_empty = function()
    local buffer_lines =
        vim.api.nvim_buf_get_lines(0, 0, vim.fn.line("$"), true)
    if buffer_lines[1] == "" and #buffer_lines == 1 then
        return true
    else
        return false
    end
end

M.smart_open_file = function(path)
    if M.buffer_empty() then
        vim.cmd("edit " .. path)
    else
        vim.cmd("vsplit " .. path)
    end
end

M.show_documentation = function()
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

return M
