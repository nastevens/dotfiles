vim.g.loaded_shada_plugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_netrwPlugin = 1

local ok, err = pcall(require, 'config')

if not ok then
    error(('Error loading config...\n\n%s'):format(err))
end
