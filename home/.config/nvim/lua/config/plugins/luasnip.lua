local types = require("luasnip.util.types")

require("luasnip").config.setup({
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "•", "Conditional" } },
			},
		},
		[types.insertNode] = {
			active = {
				virt_text = { { "•", "Identifier" } },
			},
		},
	},
})

require("luasnip.loaders.from_snipmate").lazy_load()
