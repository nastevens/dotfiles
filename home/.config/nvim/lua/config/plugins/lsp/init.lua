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

require("rust-tools").setup({
  server = {
    rustfmt = {
      enableRangeFormatting = true,
    },
  },
})
