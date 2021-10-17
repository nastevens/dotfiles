local LINUX_SOURCE = [[\v%(linux|u\-?boot|optee).{-}\/.*\.%([ch])]]
local WORK_SOURCE = [[\vprojects\/.*\.%([ch]|cpp)]]
local cc = require("config.coding-common")
local path = vim.fn.expand("%:p")

if vim.regex(LINUX_SOURCE):match_str(path) then
	cc.setup {
		overlength_column = 80,
		tab_width = 8,
		use_tabs = true,
	}
elseif vim.regex(WORK_SOURCE):match_str(path) then
	cc.setup {
		overlength_column = 80,
		tab_width = 2,
		use_tabs = false,
	}
else
	cc.setup()
end

-- command! -nargs=1 Silent
-- \ | execute ':silent !'.<q-args>
-- \ | execute ':redraw!'

-- nnoremap <buffer> K :Silent man -s 2,3,4,5,6,7,8,9,1 <C-R>=expand("<cword>")<CR><CR>
