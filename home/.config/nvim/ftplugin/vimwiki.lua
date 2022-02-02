local vimp = require("vimp")
local Path = require("plenary.path")

local function search_root()
  local active_file = vim.fn.expand("%:p")
  for _, wiki in ipairs(vim.g.vimwiki_list) do
    local abswiki = vim.fn.fnamemodify(wiki.path, ":p")
    if Path:new(active_file):make_relative(abswiki) ~= active_file then
      return abswiki
    end
  end
  return vim.fn.getcwd()
end

vimp.nnoremap({"buffer", "override"}, "<c-f>", function()
  require("telescope.builtin").find_files({
    prompt_title = "Searching vimwiki...",
    cwd = search_root(),
  })
end)
vimp.nnoremap({"buffer", "override"}, "<c-p>", function()
  require("telescope.builtin").live_grep({
    prompt_title = "Live grep vimwiki...",
    cwd = search_root(),
  })
end)
