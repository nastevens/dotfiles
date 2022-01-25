local M = {}
local cmp = require("cmp")

M.init = function()
  cmp.setup {
    -- formatting = {
    --   format = require("lspkind").cmp_format({
    --     with_text = true,
    --     menu = {
    --       buffer = "[Buf]",
    --       nvim_lsp = "[LSP]",
    --       nvim_lua = "[LuaApi]",
    --       path = "[Path]",
    --       luasnip = "[Snip]",
    --     },
    --   })
    -- },
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    sources = {
      { name = "nvim_lsp", group_index = 1, },
      { name = "buffer", group_index = 2, },
      { name = "crates" },
      { name = "luasnip" },
      { name = "nvim_lua" },
      { name = "path" },
    },
    experimental = {
      ghost_text = true,
      native_menu = true,
    }
  }
end

M.autopairs = function()
  local npairs = require("nvim-autopairs")
  npairs.setup({
    disable_filetype = { "TelescopePrompt", "vim" },
  })

  npairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))

  local cmp = require("cmp")
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
end

return M
