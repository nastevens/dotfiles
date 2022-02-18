local M = {}
local cmp = require("cmp")
local luasnip = require("luasnip")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

M.init = function()
  cmp.setup {
    formatting = {
      format = require("lspkind").cmp_format({
        with_text = true,
        menu = {
          buffer = "[Buf]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[LuaApi]",
          path = "[Path]",
          luasnip = "[Snip]",
        },
      })
    },
    mapping = {
      ['<C-n>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expandable() then
          luasnip.expand_or_jump()
        elseif luasnip.choice_active() then
          luasnip.change_choice(1)
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, {"i", "s"}),
      ['<C-p>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.choice_active() then
          luasnip.change_choice(-1)
        else
          fallback()
        end
      end, {"i", "s"}),
      ['<C-j>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(1) then
          luasnip.jump(1)
        else
          fallback()
        end
      end, {"i", "s"}),
      ['<C-k>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {"i", "s"}),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<Tab>'] = cmp.mapping.confirm({
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
    view = {
      entries = "native",
    },
    experimental = {
      ghost_text = true,
    }
  }
end

M.autopairs = function()
  local npairs = require("nvim-autopairs")
  npairs.setup({
    disable_filetype = { "TelescopePrompt", "vim" },
    ignored_next_char = "[%w%.]",
  })

  npairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))

  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done({ map_char = { tex = "" } })
  )
end

return M
