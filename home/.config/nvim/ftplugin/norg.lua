-- Automatically changes GTD workspace to current neorg workspace
local dirman = require("neorg.modules.core.norg.dirman.module")
local gtd = require("neorg.modules.core.gtd.base.module")

local function physical_workspace()
  return dirman.public.get_current_workspace()[1]
end

local function change_gtd_workspace()
  gtd.config.public["workspace"] = physical_workspace()
end

local function reload_gtd()
  return neorg.modules.load_module("core.gtd.base")
end

change_gtd_workspace()
reload_gtd()
