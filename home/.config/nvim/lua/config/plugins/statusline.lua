local gl = require("galaxyline")
local condition = require("galaxyline.condition")
local lsp_provider = require("galaxyline.providers.lsp")
gl.short_line_list = { "NvimTree", "packer", "vista" }

local colors = {
  bg = "#282a36",
  bg_alt = "#38393f",
  fg = "#f8f8f2",
  fg_alt = "#38393f",
  yellow = "#f1fa8c",
  cyan = "#8be9fd",
  green = "#50fa7b",
  orange = "#ffb86c",
  magenta = "#ff79c6",
  blue = "#8be9fd",
  red = "#ff5555",
}

-- Local helper functions
local function mode_color()
  local mode_colors = {
    n = colors.cyan,
    i = colors.green,
    c = colors.orange,
    R = colors.red,
    v = colors.magenta,
    V = colors.magenta,
    [''] = colors.magenta,
  }
  local color = mode_colors[vim.fn.mode()]
  if color == nil then
    color = colors.red
  end
  return color
end

local function mode_alias()
  local mode_aliases = {
    n = "NORMAL",
    i = "INSERT",
    c = "COMMAND",
    R = "REPLACE",
    v = "VISUAL",
    V = "VISUAL",
    [""] = "VISUAL",
  }
  vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color())
  local alias = mode_aliases[vim.fn.mode()]
  if alias == nil then
    alias = vim.fn.mode(1)
  end
  return alias
end

-- Reset sections
gl.section.short_line_left = {}
gl.section.short_line_mid = {}
gl.section.short_line_right = {}
gl.section.left = {}
gl.section.mid = {}
gl.section.right = {}

-- Left side
gl.section.left[1] = {
  FirstElement = {
    provider = function() return "▋ " end,
    highlight = { colors.cyan, colors.bg }
  },
}

gl.section.left[2] = {
  ViMode = {
    provider = function() return mode_alias() .. " " end,
    highlight = { colors.bg, colors.bg },
    separator = " ",
    separator_highlight = { colors.bg, colors.bg_alt },
  },
}

gl.section.left[3] = {
  FileIcon = {
    provider = "FileIcon",
    condition = condition.buffer_not_empty,
    highlight = { require("galaxyline.providers.fileinfo").get_file_icon_color, colors.bg_alt },
  },
}

gl.section.left[4] = {
  FileName = {
    provider = "FileName",
    condition = condition.buffer_not_empty,
    highlight = { colors.fg, colors.bg_alt },
    separator = " ",
    separator_highlight = { colors.bg_alt, colors.bg },
  }
}

gl.section.left[5] = {
  GitIcon = {
    provider = function() return " " end,
    condition = condition.check_git_workspace,
    highlight = { colors.red, colors.bg },
  }
}

gl.section.left[6] = {
  GitBranch = {
    provider = "GitBranch",
    condition = condition.check_git_workspace,
    highlight = { colors.fg, colors.bg },
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
  }
}

gl.section.left[7] = {
  DiffAdd = {
    provider = "DiffAdd",
    condition = condition.hide_in_width,
    icon = "  ",
    highlight = { colors.green, colors.bg },
  }
}

gl.section.left[8] = {
  DiffModified = {
    provider = "DiffModified",
    condition = condition.hide_in_width,
    icon = "  ",
    highlight = { colors.orange, colors.bg },
  }
}

gl.section.left[9] = {
  DiffRemove = {
    provider = "DiffRemove",
    condition = condition.hide_in_width,
    icon = "  ",
    highlight = { colors.red,colors.bg },
  }
}

gl.section.left[10] = {
  LeftEnd = {
    provider = function() return " " end,
    condition = condition.buffer_not_empty,
    highlight = { colors.bg, colors.bg_alt }
  }
}


-- Right side
gl.section.right[1] = {
  ShowLspClient = {
    provider = function()
      local client = lsp_provider.get_lsp_client("")
      if string.len(client) > 0 then
        return client .. "  "
      else
        return ""
      end
    end,
    condition = function()
      local tbl = { ["dashboard"] = true, [""] = true }
      if tbl[vim.bo.filetype] then
        return false
      else
        return true
      end
    end,
    icon = " ",
    highlight = { colors.fg, colors.bg_alt },
  },
}

gl.section.right[2] = {
  DiagnosticError = {
    provider = "DiagnosticError",
    icon = "  ",
    highlight = { colors.red, colors.bg_alt },
  },
}

gl.section.right[3] = {
  DiagnosticWarn = {
    provider = "DiagnosticWarn",
    icon = "  ",
    highlight = { colors.yellow, colors.bg_alt },
  },
}

gl.section.right[4] = {
  DiagnosticHint = {
    provider = "DiagnosticHint",
    icon = "  ",
    highlight = { colors.cyan, colors.bg_alt },
  },
}

gl.section.right[5] = {
  DiagnosticInfo = {
    provider = "DiagnosticInfo",
    icon = "  ",
    highlight = { colors.blue, colors.bg_alt },
  },
}

gl.section.right[6] = {
  WhiteSpace = {
    provider = "WhiteSpace",
    highlight = { colors.orange, colors.bg_alt },
    icon = " ",
  }
}

gl.section.right[7] = {
  FileFormat = {
    provider = function() return " " .. vim.bo.filetype end,
    highlight = { colors.fg, colors.bg },
    separator = " ",
    separator_highlight = { colors.bg, colors.bg_alt },
  }
}

gl.section.right[8] = {
  LineInfo = {
    provider = "LineColumn",
    highlight = { colors.fg, colors.bg },
    separator = " | ",
    separator_highlight = { "NONE", colors.bg },
  },
}

gl.section.right[9] = {
  LinePercent = {
      provider = "LinePercent",
      highlight = { colors.fg, colors.bg },
      separator = " | ",
      separator_highlight = { "NONE", colors.bg },
  },
}

-- Short status line
gl.section.short_line_left[1] = {
  SFileIcon = {
    provider = "FileIcon",
    condition = condition.buffer_not_empty,
    highlight = { colors.fg, colors.bg },
  },
}

gl.section.short_line_left[2] = {
  SFileName = {
    provider = "FileName",
    condition = condition.buffer_not_empty,
    highlight = { colors.fg, colors.bg },
    separator = " ",
    separator_highlight = { colors.bg, colors.bg_alt },
  }
}

gl.section.short_line_right[1] = {
  BufferIcon = {
    provider = "BufferIcon",
    highlight = { colors.yellow, colors.bg_alt },
  }
}

gl.load_galaxyline()
