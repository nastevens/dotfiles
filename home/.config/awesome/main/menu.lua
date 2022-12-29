local awful = require("awful")
local beautiful = require("beautiful")
local config = require("main.config")
local hotkeys_popup = require("awful.hotkeys_popup")
local debian = require("debian.menu")

local function create()
    local awesome_menu = {
        "awesome",
        {
            {
                "hotkeys",
                function()
                    hotkeys_popup.show_help(nil, awful.screen.focused())
                end,
            },
            {
                "manual",
                config.terminal .. " -e man awesome",
            },
            {
                "edit config",
                config.terminal
                    .. " -e "
                    .. config.editor
                    .. " "
                    .. awesome.conffile,
            },
            {
                "restart",
                awesome.restart,
            },
            {
                "quit",
                function()
                    awesome.quit()
                end,
            },
        },
        beautiful.awesome_icon,
    }

    local terminal_menu = { "open terminal", config.terminal }

    local has_fdo, freedesktop = pcall(require, "freedesktop")
    if has_fdo then
        return freedesktop.menu.build {
            before = {
                awesome_menu,
                terminal_menu,
            },
        }
    else
        return awful.menu {
            items = {
                awesome_menu,
                terminal_menu,
                { "Debian", debian.menu.Debian_menu.Debian },
            },
        }
    end
end

return setmetatable({}, { __call = create })
