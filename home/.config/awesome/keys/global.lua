local add_key = require("keys.utils").add_key
local awful = require("awful")
local config = require("main.config")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")
local volume_widget = require("awesome-wm-widgets.volume-widget.volume")
local wibox = require("wibox")

local function create(menu)
    local popup = awful.popup {
        ontop = true,
        visible = false,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 8)
        end,
        offset = { y = 5 },
        border_width = 1,
        widget = wibox.widget {
            {
                font = "sans 18",
                widget = wibox.widget.textclock,
            },
            layout = wibox.layout.fixed.vertical,
        },
    }
    local keybinds = gears.table.join(
        add_key("M-t", "show clock", "awesome", function()
            if popup.visible then
                popup.visible = not popup.visible
            else
                awful.placement.top_right(popup, {
                    margins = { top = 30, right = 30 },
                    parent = awful.screen.focused(),
                })
                popup.visible = true
            end
        end),
        add_key("M-s", "show help", "awesome", hotkeys_popup.show_help),
        add_key("M-Left", "view previous", "tag", awful.tag.viewprev),
        add_key("M-Right", "view next", "tag", awful.tag.viewnext),
        add_key("M-Escape", "go back", "tag", awful.tag.history.restore),
        add_key(
            "M-u",
            "jump to urgent client",
            "client",
            awful.client.urgent.jumpto
        ),
        add_key("M-C-r", "reload awesome", "awesome", awesome.restart),
        add_key("M-S-q", "quit awesome", "awesome", awesome.quit),
        add_key("M-j", "focus next by index", "client", function()
            awful.client.focus.byidx(1)
        end),
        add_key("M-k", "focus previous by index", "client", function()
            awful.client.focus.byidx(-1)
        end),
        add_key("M-w", "show main menu", "awesome", function()
            menu:show()
        end),
        add_key("M-S-j", "swap with next client by index", "client", function()
            awful.client.swap.byidx(1)
        end),
        add_key(
            "M-S-k",
            "swap with previous client by index",
            "client",
            function()
                awful.client.swap.byidx(-1)
            end
        ),
        add_key("M-C-j", "focus the next screen", "screen", function()
            awful.screen.focus_relative(1)
        end),
        add_key("M-C-k", "focus the previous screen", "screen", function()
            awful.screen.focus_relative(-1)
        end),
        add_key("M-Tab", "go back", "client", function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),
        add_key("M-Return", "open a terminal", "launcher", function()
            awful.spawn(config.terminal)
        end),
        add_key("M-h", "increase master width factor", "layout", function()
            awful.tag.incmwfact(0.05)
        end),
        add_key("M-l", "decrease master width factor", "layout", function()
            awful.tag.incmwfact(-0.05)
        end),
        add_key(
            "M-S-h",
            "increase the number of master clients",
            "layout",
            function()
                awful.tag.incnmaster(1, nil, true)
            end
        ),
        add_key(
            "M-S-l",
            "decrease the number of master clients",
            "layout",
            function()
                awful.tag.incnmaster(-1, nil, true)
            end
        ),
        add_key("M-C-h", "increase the number of columns", "layout", function()
            awful.tag.incncol(1, nil, true)
        end),
        add_key("M-C-l", "decrease the number of columns", "layout", function()
            awful.tag.incncol(-1, nil, true)
        end),
        add_key("M-space", "select next", "layout", function()
            awful.layout.inc(1)
        end),
        add_key("M-S-space", "select previous", "layout", function()
            awful.layout.inc(-1)
        end),
        add_key("M-C-n", "restore minimized", "client", function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal(
                    "request::activate",
                    "key.unminimize",
                    { raise = true }
                )
            end
        end),
        add_key("M-r", "run prompt", "launcher", function()
            local input_widget = awful.screen.focused().input_widget
            input_widget.visible = true
            awful.screen.focused().mypromptbox:run {}
        end),
        add_key("M-x", "lua execute prompt", "awesome", function()
            local input_widget = awful.screen.focused().input_widget
            input_widget.visible = true
            awful.prompt.run {
                prompt = "Run Lua code: ",
                textbox = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval",
                done_callback = function()
                    input_widget.visible = false
                end,
            }
        end),
        add_key("M-p", "show the menubar", "launcher", function()
            menubar.show()
        end),
        add_key("M-C-s", "put system to sleep", "awesome", function()
            awful.spawn.with_shell("xautolock -locknow")
        end),
        add_key("XF86AudioRaiseVolume", "raise volume", "sound", function()
            volume_widget:inc(5)
        end),
        add_key("XF86AudioLowerVolume", "lower volume", "sound", function()
            volume_widget:dec(5)
        end),
        add_key("XF86AudioMute", "toggle mute", "sound", function()
            volume_widget:toggle()
        end),
        add_key("XF86AudioPlay", "play", "sound", function()
            awful.spawn.easy_async("playerctl -i firefox play-pause", function() end)
        end),
        add_key("XF86AudioNext", "next track", "sound", function()
            awful.spawn.easy_async("playerctl -i firefox next", function() end)
        end),
        add_key("XF86AudioPrev", "previous track", "sound", function()
            awful.spawn.easy_async("playerctl -i firefox previous", function() end)
        end)
    )

    -- Bind all key numbers to tags.
    for i = 1, config.tagcount do
        keybinds = gears.table.join(
            keybinds,
            -- View tag only.
            add_key("M-#" .. i + 9, "view tag #" .. i, "tag", function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end),

            -- Toggle tag display.
            add_key("M-C-#" .. i + 9, "toggle tag #" .. i, "tag", function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end),

            -- Move client to tag.
            add_key(
                "M-S-#" .. i + 9,
                "move focused client to tag #" .. i,
                "tag",
                function()
                    if client.focus then
                        local tag = client.focus.screen.tags[i]
                        if tag then
                            client.focus:move_to_tag(tag)
                        end
                    end
                end
            ),

            -- Toggle tag on focused client.
            add_key(
                "M-S-C-#" .. i + 9,
                "toggle focused client on tag #" .. i,
                "tag",
                function()
                    if client.focus then
                        local tag = client.focus.screen.tags[i]
                        if tag then
                            client.focus:toggle_tag(tag)
                        end
                    end
                end
            )
        )
    end

    return keybinds
end

return setmetatable({}, { __call = create })
