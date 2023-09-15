local Hydra = require("hydra")
local Path = require("plenary.path")
local cmd = require("hydra.keymap-util").cmd
local hint = nil

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

local function find_files()
    require("telescope.builtin").find_files {
        cwd = search_root(),
    }
end

local function live_grep()
    require("telescope.builtin").live_grep {
        cwd = search_root(),
    }
end

-- Telescope on C-f
hint = [[
_f_: files         _m_: marks          _o_: old files   
_p_: live grep     _/_: grep in file   _?_: search history
_R_: registers     _q_: quickfix       _b_: buffers

_h_: vim help      _O_: vim options    _c_: commands
_k_: keymaps       _x_: clipboard      _C_: command history

_s_: snippets      _t_: treesitter     _S_: spelling
_M_: manpage       _d_: diagnostics

_r_: resume       _<Enter>_: Telescope      _<Esc>_
]]

Hydra {
    name = "Telescope",
    hint = hint,
    config = {
        color = "teal",
        invoke_on_body = true,
        hint = {
            position = "middle",
            border = "rounded",
        },
    },
    mode = "n",
    body = "<C-f>",
    heads = {
        { "f", find_files },
        { "m", cmd("Telescope marks") },
        { "o", cmd("Telescope oldfiles") },
        { "p", live_grep },
        { "/", cmd("Telescope current_buffer_fuzzy_find") },
        { "?", cmd("Telescope search_history") },
        { "R", cmd("Telescope registers") },
        { "q", cmd("Telescope quickfix") },
        { "b", cmd("Telescope buffers") },
        { "h", cmd("Telescope help_tags") },
        { "O", cmd("Telescope vim_options") },
        { "c", cmd("Telescope commands") },
        { "k", cmd("Telescope keymaps") },
        { "x", cmd("Telescope neoclip") },
        { "C", cmd("Telescope command_history") },
        { "s", cmd("Telescope luasnip") },
        { "t", cmd("Telescope treesitter") },
        { "S", cmd("Telescope spell_suggest") },
        {
            "M",
            cmd(
                "Telescope man_pages  sections={'1','2','3','4','5','6','7','8'}"
            ),
        },
        { "d", cmd("Telescope diagnostics") },
        { "<Enter>", cmd("Telescope"), { exit = true } },
        { "r", cmd("Telescope resume") },
        { "<Esc>", nil, { exit = true, nowait = true } },
    },
}
