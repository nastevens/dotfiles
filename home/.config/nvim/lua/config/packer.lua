-- Original from https://github.com/CosmicNvim/CosmicNvim

local cmd = vim.cmd

local present, packer = pcall(require, "packer")

if not present then
  local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

  print("Cloning packer..")
  vim.fn.delete(packer_path, "rf")  -- remove the dir before cloning
  vim.fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", "--depth", "1", packer_path})
  cmd("packadd packer.nvim")

  present, packer = pcall(require, "packer")

  if present then
    print("Packer cloned successfully.")
  else
    error("Couldn't clone packer!\nPacker path: " .. packer_path .. "\n" .. packer)
  end
end

packer.init({
  auto_clean = true,
  compile_on_sync = true,
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end,
    prompt_border = "single",
  },
})

return packer
