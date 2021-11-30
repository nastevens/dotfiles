local ok, err = pcall(require, 'config')

if not ok then
  error(('Error loading config...\n\n%s'):format(err))
end
