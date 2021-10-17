-- Common settings for editing code

local M = {}

-- Control if tabs are the expected indent or not. If yes they are invisible
-- and not expanded. If no, they are expanded and any tab characters are
-- marked.
function M.use_tabs(usetabs)
  local opt = vim.opt_local
  if usetabs then
    opt.listchars = "tab:  ,trail:·,nbsp:~"
    opt.expandtab = false
  else
    opt.listchars = "tab:»»,trail:·,nbsp:~"
    opt.expandtab = true
  end
end

-- Control tab width
function M.tab_width(width)
  local opt = vim.opt_local
  if width then
    opt.shiftwidth = width
    opt.softtabstop = width
    opt.tabstop = width
  end
end

-- Add subtle marker to certain column widths
function M.overlength(column)
  local opt = vim.opt_local
  if column then
    opt.colorcolumn = tostring(column)
  else
    opt.colorcolumn = ""
  end
end

-- " Pretty-format JSON
-- command! PrettyJSON :%!python3 -c "import json, sys; print(json.dumps(json.load(sys.stdin), indent=4, sort_keys=True))"

function M.setup(options)
  options = options or {}
  setmetatable(options, {
    __index = {
      overlength_column = 80,
      tab_width = 4,
      use_tabs = false,
    }
  })
  local opt = vim.opt_local

  M.use_tabs(options.use_tabs)
  M.tab_width(options.tab_width)
  M.overlength(options.overlength_column)

  -- Options for auto-formatting
  opt.formatoptions = "cjqr"
  opt.smartindent = true
  opt.textwidth = 0
end

return M
