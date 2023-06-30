-- Applies common settings for code files that might differ based on file type
-- or file location

local M = {}

-- Control if tabs are the expected indent or not. If yes they are invisible
-- and not expanded. If no, they are expanded and any tab characters are
-- marked.
function M.use_tabs(usetabs)
    if usetabs then
        vim.opt_local.expandtab = false
        vim.opt_local.list = false
        vim.opt_local.listchars = "tab:  ,trail:·,nbsp:~"
    else
        vim.opt_local.expandtab = true
        vim.opt_local.list = true
        vim.opt_local.listchars = "tab:»»,trail:·,nbsp:~"
    end
end

-- Control tab width
function M.tab_width(width)
    vim.opt_local.shiftwidth = width
    vim.opt_local.softtabstop = width
    vim.opt_local.tabstop = width
end

-- Add subtle marker to certain column widths
function M.overlength(column)
    if column == nil then
        vim.opt_local.colorcolumn = ""
    else
        vim.opt_local.colorcolumn = tostring(column)
    end
end

local function apply_options(options)
    M.use_tabs(options.use_tabs)
    M.tab_width(options.tab_width)
    M.overlength(options.overlength_column)
    vim.opt_local.conceallevel = options.conceal_level
    vim.opt_local.formatoptions = options.format_options
    vim.opt_local.smartindent = options.smart_indent
    vim.opt_local.textwidth = options.text_width
    vim.opt_local.wrap = options.wrap
end

function M.setup()
    vim.cmd([[
        augroup codeoptions
        au!
        au FileType * lua require'config.codeoptions'.apply(vim.fn.expand('<amatch>'))
        augroup END
    ]])
end

local DEFAULTS = {
    conceal_level = 2,
    format_options = "cjnqr",
    overlength_column = 80,
    smart_indent = true,
    tab_width = 4,
    text_width = 0,
    use_tabs = false,
    wrap = false,
}

local function c_custom()
    local linux_source = [[\v%(linux|u\-?boot|optee).{-}\/.*\.%([ch])]]
    local work_source = [[\vprojects\/.*\.%([ch]|cpp)]]
    local path = vim.fn.expand("%:p")
    local options

    if vim.regex(linux_source):match_str(path) then
        options = vim.tbl_deep_extend("force", DEFAULTS, {
            overlength_column = 80,
            tab_width = 8,
            use_tabs = true,
        })
    elseif vim.regex(work_source):match_str(path) then
        options = vim.tbl_deep_extend("force", DEFAULTS, {
            overlength_column = 80,
            tab_width = 2,
            use_tabs = false,
        })
    else
        options = DEFAULTS
    end

    apply_options(options)
end

local OVERRIDES = {
    ["bitbake"] = { overlength_column = 160 },
    ["c"] = c_custom,
    ["cpp"] = c_custom,
    ["cmake"] = { tab_width = 2, overlength_column = nil },
    ["dts"] = { tab_width = 8, use_tabs = true },
    ["gradle"] = { tab_width = 2, overlength_column = 160 },
    ["groovy"] = { tab_width = 2, overlength_column = 160 },
    ["help"] = { use_tabs = true },
    ["html"] = { tab_width = 2, overlength_column = nil },
    ["java"] = { overlength_column = 160 },
    ["markdown"] = {
        conceal_level = 0,
        format_options = "cjnqtr",
        text_width = 80,
    },
    ["proto"] = { tab_width = 2 },
    ["ruby"] = { tab_width = 2 },
    ["rust"] = { overlength_column = 99 },
    ["terraform"] = { tab_width = 2 },
    ["vim"] = { tab_width = 2 },
    ["vimwiki"] = { tab_width = 2, overlength_column = nil },
    ["xml"] = { overlength_column = 200 },
    ["xsl"] = { overlength_column = 200 },
    ["yaml"] = { tab_width = 2 },
}

function M.apply(filetype)
    if #vim.api.nvim_buf_get_name(0) == 0 then
        return
    end

    local options
    local override = OVERRIDES[filetype]
    if type(override) == "function" then
        -- `apply_options` is not called for functions so they can programmatically
        -- change values if needed
        override()
    elseif type(override) == "table" then
        options = vim.tbl_deep_extend("force", DEFAULTS, override)
        apply_options(options)
    else
        options = DEFAULTS
        apply_options(options)
    end
end

return M
