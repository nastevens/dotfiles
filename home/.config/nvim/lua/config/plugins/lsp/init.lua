local lsp = require("lspconfig")
-- local cmp_lsp = require("cmp_nvim_lsp")
local lsp_status = require("lsp-status")
local lsp_installer = require("nvim-lsp-installer")



lsp_installer.on_server_ready(function(server)
  local opts = require("config.plugins.lsp.defaults")

  if server.name == "sumneko_lua" then
    opts = vim.tbl_deep_extend("force", opts, require("config.plugins.lsp.lua"))
  end
  server:setup(opts)
  vim.cmd([[ do User LspAttachBuffers ]])
end)


lsp_status.register_progress()

lsp.pylsp.setup {
  capabilities = lsp_status.capabilities,
  on_attach = lsp_status.on_attach,
}
lsp.rust_analyzer.setup {
  capabilities = lsp_status.capabilities,
  on_attach = lsp_status.on_attach,
}

local opts = {
  -- rust-tools options
  tools = {
    autoSetHints = true,
    hover_with_actions = true,
    inlay_hints = {
    },
  },

  -- all the opts to send to nvim-lspconfig
  server = {
    settings = {
      ["rust-analyzer"] = {
        -- enable clippy on save
        checkOnSave = {
          command = "clippy"
        },
      },
    },
  },
}

require("rust-tools").setup(opts)
