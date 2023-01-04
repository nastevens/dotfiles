local awful = require("awful")
local config = require("main.config")
local gears = require("gears")
local wibox = require("wibox")

local function create(s)
    local taglist_buttons = gears.table.join(
        -- Left click to show only that tag
        awful.button({}, 1, function(t)
            t:view_only()
        end),

        -- Left click + mod moves current client to the specified tag
        awful.button({ config.modkey }, 1, function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end),

        -- Right click toggles the specified tag
        awful.button({}, 3, awful.tag.viewtoggle),

        -- Right click + mod toggles tag for current client
        awful.button({ config.modkey }, 3, function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end),

        -- Scroll wheel over taglist moves forward/backward
        awful.button({}, 4, function(t)
            awful.tag.viewnext(t.screen)
        end),
        awful.button({}, 5, function(t)
            awful.tag.viewprev(t.screen)
        end)
    )
    return awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        layout = wibox.layout.fixed.vertical,
    }
end

return setmetatable({}, {
    __call = function(_, ...)
        return create(...)
    end,
})
