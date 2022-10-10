require("neorg").setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          home = "~/Dropbox/neorg",
          work = "~/Dropbox/smartthings/neorg",
        },
        autochdir = true,
        index = "index.norg",
      }
    },
    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp",
      }
    },
    ["core.norg.concealer"] = {
      config = {
        folds = false,
      },
    },
    ["core.gtd.base"] = {
      config = {
        workspace = "home",
        exclude = {},
      }
    },
    ["core.integrations.telescope"] = {},
    ["core.export"] = {},
  },
}
