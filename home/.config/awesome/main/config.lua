local fs = require("gears.filesystem")

local home = os.getenv("HOME")
local dropbox = home .. "/Dropbox"
return {
    dropbox = dropbox,
    editor = os.getenv("EDITOR") or "vim",
    home = home,
    modkey = "Mod4",
    tagcount = 5,
    terminal = "alacritty",
    theme = fs.get_xdg_config_home() .. "/awesome/theme.lua",
    wallpaper = dropbox .. "/images/wallpapers/Space Cat Ultrawide.jpg",
}
