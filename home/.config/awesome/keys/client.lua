local awful = require("awful")
local gears = require("gears")
local add_key = require("keys.utils").add_key

local function create()
	return gears.table.join(
		add_key("M-f", "toggle fullscreen", "client", function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end),
		add_key("M-S-c", "close", "client", function(c)
			c:kill()
		end),
		add_key("M-C-space", "toggle floating", "client", function(c)
			c.floating = not c.floating
		end),
		add_key("M-a", "move to master", "client", function(c)
			c:swap(awful.client.getmaster())
		end),
		add_key("M-o", "move to screen", "client", function(c)
			c:move_to_screen()
		end),
		add_key("M-m", "(un)maximize", "client", function(c)
			c.maximized = not c.maximized
			c:raise()
		end),
		add_key("M-C-m", "(un)maximize vertically", "client", function(c)
			c.maximized_vertical = not c.maximized_vertical
			c:raise()
		end),
		add_key("M-S-m", "(un)maximize horizontally", "client", function(c)
			c.maximized_horizontal = not c.maximized_horizontal
			c:raise()
		end)
	)
end

return setmetatable({}, { __call = create })
