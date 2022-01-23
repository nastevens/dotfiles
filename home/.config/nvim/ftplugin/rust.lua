local cc = require("config.coding-common")
local vimp = require("vimp")

cc.setup {
	overlength_column = 99,
}

vimp.nnoremap({"buffer"}, "<leader>t", require("rust-tools.inlay_hints").toggle_inlay_hints)
