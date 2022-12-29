local awful = require("awful")
local lain = require("lain")
local dovetail = require("dovetail")

local function create()
    return {
        lain.layout.centerwork,
        dovetail.layout.right,
        dovetail.layout.left,
        awful.layout.suit.floating,
        awful.layout.suit.tile,
        awful.layout.suit.tile.left,
        awful.layout.suit.tile.bottom,
        awful.layout.suit.tile.top,
        awful.layout.suit.max,
    }
end

return setmetatable({}, { __call = create })
