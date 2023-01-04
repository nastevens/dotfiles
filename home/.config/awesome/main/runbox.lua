local awful = require("awful")
local wibox = require("wibox")

local function create(s)
    local promptbox = awful.widget.prompt {
        done_callback = function()
            s.input_widget.visible = false
        end,
    }
    local runbox = wibox {
        width = 1000,
        ontop = true,
        screen = awful.mouse.screen,
        expand = true,
        visible = false,
        bg = "#1e252c55",
        max_widget_size = 1000,
        height = 19,
        x = screen[1].geometry.width / 2 - 500,
        y = 10,
    }

    runbox:setup {
        {
            promptbox,
            layout = wibox.container.margin,
            left = 10,
            right = 10,
        },
        layout = wibox.layout.fixed.horizontal,
    }

    return runbox, promptbox
end

return setmetatable({}, {
    __call = function(_, ...)
        return create(...)
    end,
})
