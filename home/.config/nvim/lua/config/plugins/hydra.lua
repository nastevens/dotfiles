local Hydra = require('hydra')
local cmd = require('hydra.keymap-util').cmd
local gitsigns = require('gitsigns')
local hint = nil

-- Telescope on C-f
hint = [[
_f_: files         _m_: marks          _o_: old files   
_p_: live grep     _/_: grep in file   _?_: search history
_R_: registers     _q_: quickfix       _b_: buffers

_h_: vim help      _O_: vim options    _c_: commands
_k_: keymaps       _x_: clipboard      _C_: command history

_s_: snippets      _t_: treesitter     _S_: spelling
_M_: manpage

_r_: resume       _<Enter>_: Telescope      _<Esc>_
]]

Hydra({
   name = 'Telescope',
   hint = hint,
   config = {
      color = 'teal',
      invoke_on_body = true,
      hint = {
         position = 'middle',
         border = 'rounded',
      },
   },
   mode = 'n',
   body = '<C-f>',
   heads = {
      { 'f', cmd 'Telescope find_files' },
      { 'm', cmd 'Telescope marks' },
      { 'o', cmd 'Telescope oldfiles' },
      { 'p', cmd 'Telescope live_grep' },
      { '/', cmd 'Telescope current_buffer_fuzzy_find' },
      { '?', cmd 'Telescope search_history' },
      { 'R', cmd 'Telescope registers' },
      { 'q', cmd 'Telescope quickfix' },
      { 'b', cmd 'Telescope buffers' },
      { 'h', cmd 'Telescope help_tags' },
      { 'O', cmd 'Telescope vim_options' },
      { 'c', cmd 'Telescope commands' },
      { 'k', cmd 'Telescope keymaps' },
      { "x", cmd 'Telescope neoclip' },
      { 'C', cmd 'Telescope command_history' },
      { "s", cmd "Telescope luasnip" },
      { "t", cmd "Telescope treesitter" },
      { "S", cmd "Telescope spell_suggest" },
      { "M", cmd "Telescope man_pages  sections={'1','2','3','4','5','6','7','8'}" },
      { '<Enter>', cmd 'Telescope', { exit = true } },
      { 'r', cmd 'Telescope resume' },
      { '<Esc>', nil, { exit = true, nowait = true } },
   }
})

-- LSP
-- lsp_definitions, etc
--[[
lsp_references
lsp_definitions
lsp_incoming_calls
lsp_outgoing_calls
lsp_implementations
lsp_type_definitions
lsp_document_symbols
lsp_workspace_symbols
lsp_dynamic_workspace_symbols
diagnostics
--]]


-- Git on C-g

hint = [[
 _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _K_: prev hunk   _u_: undo last stage   _p_: preview hunk   _B_: blame show full 
 ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
 ^
 ^ ^              _<Enter>_: Neogit              _q_: exit
]]

--[[
Telescope git_stash, git_commits, git_status, git_branches
--]]

Hydra({
   name = 'Git',
   hint = hint,
   config = {
      buffer = bufnr,
      color = 'pink',
      invoke_on_body = true,
      hint = {
         border = 'rounded'
      },
      on_enter = function()
         vim.cmd 'mkview'
         vim.cmd 'silent! %foldopen!'
         vim.bo.modifiable = false
         gitsigns.toggle_signs(true)
         gitsigns.toggle_linehl(true)
      end,
      on_exit = function()
         local cursor_pos = vim.api.nvim_win_get_cursor(0)
         vim.cmd 'loadview'
         vim.api.nvim_win_set_cursor(0, cursor_pos)
         vim.cmd 'normal zv'
         gitsigns.toggle_signs(false)
         gitsigns.toggle_linehl(false)
         gitsigns.toggle_deleted(false)
      end,
   },
   mode = {'n','x'},
   body = '<leader>g',
   heads = {
      { 'J',
         function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gitsigns.next_hunk() end)
            return '<Ignore>'
         end,
         { expr = true, desc = 'next hunk' } },
      { 'K',
         function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gitsigns.prev_hunk() end)
            return '<Ignore>'
         end,
         { expr = true, desc = 'prev hunk' } },
      { 's', ':Gitsigns stage_hunk<CR>', { silent = true, desc = 'stage hunk' } },
      { 'u', gitsigns.undo_stage_hunk, { desc = 'undo last stage' } },
      { 'S', gitsigns.stage_buffer, { desc = 'stage buffer' } },
      { 'p', gitsigns.preview_hunk, { desc = 'preview hunk' } },
      { 'd', gitsigns.toggle_deleted, { nowait = true, desc = 'toggle deleted' } },
      { 'b', gitsigns.blame_line, { desc = 'blame' } },
      { 'B', function() gitsigns.blame_line{ full = true } end, { desc = 'blame show full' } },
      { '/', gitsigns.show, { exit = true, desc = 'show base file' } }, -- show the base of the file
      { '<Enter>', cmd 'Neogit', { exit = true, desc = 'Neogit' } },
      { 'q', nil, { exit = true, nowait = true, desc = 'exit' } },
   }
})


-- also needs:
--   https://github.com/sindrets/winshift.nvim
--   https://github.com/romgrk/barbar.nvim
-- local Hydra = require('hydra')
-- local splits = require('smart-splits')

-- local cmd = require('hydra.keymap-util').cmd
-- local pcmd = require('hydra.keymap-util').pcmd

-- local buffer_hydra = Hydra({
--    name = 'Barbar',
--    config = {
--       on_key = function()
--          -- Preserve animation
--          vim.wait(200, function() vim.cmd 'redraw' end, 30, false)
--       end
--    },
--    heads = {
--       { 'h', function() vim.cmd('BufferPrevious') end, { on_key = false } },
--       { 'l', function() vim.cmd('BufferNext') end, { desc = 'choose', on_key = false } },

--       { 'H', function() vim.cmd('BufferMovePrevious') end },
--       { 'L', function() vim.cmd('BufferMoveNext') end, { desc = 'move' } },

--       { 'p', function() vim.cmd('BufferPin') end, { desc = 'pin' } },

--       { 'd', function() vim.cmd('BufferClose') end, { desc = 'close' } },
--       { 'c', function() vim.cmd('BufferClose') end, { desc = false } },
--       { 'q', function() vim.cmd('BufferClose') end, { desc = false } },

--       { 'od', function() vim.cmd('BufferOrderByDirectory') end, { desc = 'by directory' } },
--       { 'ol', function() vim.cmd('BufferOrderByLanguage') end,  { desc = 'by language' } },
--       { '<Esc>', nil, { exit = true } }
--    }
-- })

-- local function choose_buffer()
--    if #vim.fn.getbufinfo({ buflisted = true }) > 1 then
--       buffer_hydra:activate()
--    end
-- end

-- vim.keymap.set('n', 'gb', choose_buffer)

-- local window_hint = [[
--  ^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split
--  ^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------
--  ^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   ^   _<C-k>_   ^   _s_: horizontally
--  _h_ ^ ^ _l_  _H_ ^ ^ _L_   _<C-h>_ _<C-l>_   _v_: vertically
--  ^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   ^   _<C-j>_   ^   _q_, _c_: close
--  focus^^^^^^  window^^^^^^  ^_=_: equalize^   _z_: maximize
--  ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   ^^ ^          ^   _o_: remain only
--  _b_: choose buffer
-- ]]

-- Hydra({
--    name = 'Windows',
--    hint = window_hint,
--    config = {
--       invoke_on_body = true,
--       hint = {
--          border = 'rounded',
--          offset = -1
--       }
--    },
--    mode = 'n',
--    body = '<C-w>',
--    heads = {
--       { 'h', '<C-w>h' },
--       { 'j', '<C-w>j' },
--       { 'k', pcmd('wincmd k', 'E11', 'close') },
--       { 'l', '<C-w>l' },

--       { 'H', cmd 'WinShift left' },
--       { 'J', cmd 'WinShift down' },
--       { 'K', cmd 'WinShift up' },
--       { 'L', cmd 'WinShift right' },

--       { '<C-h>', function() splits.resize_left(2)  end },
--       { '<C-j>', function() splits.resize_down(2)  end },
--       { '<C-k>', function() splits.resize_up(2)    end },
--       { '<C-l>', function() splits.resize_right(2) end },
--       { '=', '<C-w>=', { desc = 'equalize'} },

--       { 's',     pcmd('split', 'E36') },
--       { '<C-s>', pcmd('split', 'E36'), { desc = false } },
--       { 'v',     pcmd('vsplit', 'E36') },
--       { '<C-v>', pcmd('vsplit', 'E36'), { desc = false } },

--       { 'w',     '<C-w>w', { exit = true, desc = false } },
--       { '<C-w>', '<C-w>w', { exit = true, desc = false } },

--       { 'z',     cmd 'WindowsMaximaze', { exit = true, desc = 'maximize' } },
--       { '<C-z>', cmd 'WindowsMaximaze', { exit = true, desc = false } },

--       { 'o',     '<C-w>o', { exit = true, desc = 'remain only' } },
--       { '<C-o>', '<C-w>o', { exit = true, desc = false } },

--       { 'b', choose_buffer, { exit = true, desc = 'choose buffer' } },

--       { 'c',     pcmd('close', 'E444') },
--       { 'q',     pcmd('close', 'E444'), { desc = 'close window' } },
--       { '<C-c>', pcmd('close', 'E444'), { desc = false } },
--       { '<C-q>', pcmd('close', 'E444'), { desc = false } },

--       { '<Esc>', nil,  { exit = true, desc = false }}
--    }
-- })



-- local Hydra = require("hydra")

hint = [[
  ^ ^        Options
  ^
  _v_ %{ve} virtual edit
  _i_ %{list} invisible characters  
  _s_ %{spell} spell
  _w_ %{wrap} wrap
  _c_ %{cul} cursor line
  _n_ %{nu} number
  _r_ %{rnu} relative number
  ^
       ^^^^                _<Esc>_
]]

Hydra({
   name = 'Options',
   hint = hint,
   config = {
      color = 'amaranth',
      invoke_on_body = true,
      hint = {
         border = 'rounded',
         position = 'middle'
      }
   },
   mode = {'n','x'},
   body = '<leader>o',
   heads = {
      { 'n', function()
         if vim.o.number == true then
            vim.o.number = false
         else
            vim.o.number = true
         end
      end, { desc = 'number' } },
      { 'r', function()
         if vim.o.relativenumber == true then
            vim.o.relativenumber = false
         else
            vim.o.number = true
            vim.o.relativenumber = true
         end
      end, { desc = 'relativenumber' } },
      { 'v', function()
         if vim.o.virtualedit == 'all' then
            vim.o.virtualedit = 'block'
         else
            vim.o.virtualedit = 'all'
         end
      end, { desc = 'virtualedit' } },
      { 'i', function()
         if vim.o.list == true then
            vim.o.list = false
         else
            vim.o.list = true
         end
      end, { desc = 'show invisible' } },
      { 's', function()
         if vim.o.spell == true then
            vim.o.spell = false
         else
            vim.o.spell = true
         end
      end, { desc = 'spell' } },
      { 'w', function()
         if vim.o.wrap ~= true then
            vim.o.wrap = true
            -- Dealing with word wrap:
            -- If cursor is inside very long line in the file than wraps
            -- around several rows on the screen, then 'j' key moves you to
            -- the next line in the file, but not to the next row on the
            -- screen under your previous position as in other editors. These
            -- bindings fixes this.
            vim.keymap.set('n', 'k', function() return vim.v.count > 0 and 'k' or 'gk' end,
                                     { expr = true, desc = 'k or gk' })
            vim.keymap.set('n', 'j', function() return vim.v.count > 0 and 'j' or 'gj' end,
                                     { expr = true, desc = 'j or gj' })
         else
            vim.o.wrap = false
            vim.keymap.del('n', 'k')
            vim.keymap.del('n', 'j')
         end
      end, { desc = 'wrap' } },
      { 'c', function()
         if vim.o.cursorline == true then
            vim.o.cursorline = false
         else
            vim.o.cursorline = true
         end
      end, { desc = 'cursor line' } },
      { '<Esc>', nil, { exit = true } }
   }
})
