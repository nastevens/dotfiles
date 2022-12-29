-- Allow loading external packages
package.path = (
    "/home/nick/.local/share/awesome/lua/?/init.lua;"
    .. "/home/nick/.local/share/awesome/lua/?.lua;"
    .. package.path
)

local awful = require("awful")
local _ = require("awful.autofocus")
local beautiful = require("beautiful")
local gears = require("gears")
local menubar = require("menubar")
local naughty = require("naughty")
local volume_widget = require("awesome-wm-widgets.volume-widget.volume")
local wibox = require("wibox")

local user_config = require("main.config")

-- Themes define colours, icons, font and wallpapers.
beautiful.init(user_config.theme)
beautiful.get().wallpaper = user_config.wallpaper

local function put_on_clipboard(s)
    awful.spawn.easy_async_with_shell(
        "echo -n " .. s .. " | xclip -selection clipboard",
        function() end
    )
end

-- Find any two-factor codes in notifications coming from Firefox
local function copy_tfa_codes(args)
    if not args.appname or not args.appname:find("Firefox") then
        return args
    end

    for code in args.text:gmatch("%d+") do
        if #code >= 4 and #code <= 10 then
            args.run = function()
                put_on_clipboard(code)
                naughty.notify { text = "Code copied!" } 
            end
            return args
        end
    end

    return args
end

naughty.config.notify_callback = copy_tfa_codes
naughty.config.defaults.timeout = 10

-- My submodules
local main = require("main")
local keys = require("keys")

-- Table of layouts to use
awful.layout.layouts = main.layouts()

menubar.utils.terminal = user_config.terminal

local tasklist_buttons = main.tasklist()

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

local menu = main.menu()
local mylauncher = awful.widget.launcher {
    image = beautiful.awesome_icon,
    menu = menu,
}

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt {
        done_callback = function()
            s.input_widget.visible = false
        end,
    }

    s.input_widget = wibox {
        -- get screen size and widget size to calculate centre position
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
    s.input_widget:setup {
        {
            s.mypromptbox,
            layout = wibox.container.margin,
            left = 10,
            right = 10,
        },
        layout = wibox.layout.fixed.horizontal,
    }

    -- Create an imagebox widget which will contain an icon indicating which
    -- layout we're using. We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function()
            awful.layout.inc(1)
        end),
        awful.button({}, 3, function()
            awful.layout.inc(-1)
        end),
        awful.button({}, 4, function()
            awful.layout.inc(1)
        end),
        awful.button({}, 5, function()
            awful.layout.inc(-1)
        end)
    ))

    -- Create a taglist widget
    -- There's something weird with the timing if I try to make this
    -- a callable table - I get screen errors
    s.mytaglist = main.taglist(s)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        layout = {
            layout = wibox.layout.fixed.vertical,
        },
    }

    local mysystray = wibox.widget.systray()
    mysystray.set_horizontal(false)

    -- Create the wibox
    s.mywibox = awful.wibar { position = "left", screen = s, width = 18 }

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.vertical,
        { -- Left widgets
            layout = wibox.layout.fixed.vertical,
            wibox.container {
                mylauncher,
                widget = wibox.container.margin,
                bottom = 10,
            },
            wibox.container {
                s.mytaglist,
                widget = wibox.container.margin,
                bottom = 10,
            },
        },

        -- Middle widget(s)
        s.mytasklist,

        -- Right widgets
        {
            wibox.container {
                volume_widget {
                    widget_type = "arc",
                },
                widget = wibox.container.margin,
                bottom = 10,
            },
            wibox.container {
                mysystray,
                widget = wibox.container.margin,
                bottom = 10,
            },
            s.mylayoutbox,
            layout = wibox.layout.fixed.vertical,
        },
    }
end)

-- Global keys and buttons
root.buttons(
    gears.table.join(
        awful.button({}, 3, function()
            menu:toggle()
        end),
        awful.button({}, 4, awful.tag.viewnext),
        awful.button({}, 5, awful.tag.viewprev)
    )
)

local globalkeys = keys.global(menu)
root.keys(globalkeys)

-- Client keys and buttons
local clientkeys = keys.client()

local clientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
    awful.button({ user_config.modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ user_config.modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.resize(c)
    end)
)

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap
                + awful.placement.no_offscreen,
        },
    },

    -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA", -- Firefox addon DownThemAll.
                "copyq", -- Includes session name in class.
                "pinentry",
            },

            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin", -- kalarm.
                "Sxiv",
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "xtightvncviewer",
            },

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester", -- xev.
            },

            role = {
                "AlarmWindow", -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
            },
        },
        properties = { floating = true },
    },

    -- Add titlebars to normal clients and dialogs
    {
        rule_any = {
            type = {
                "normal",
                "dialog",
            },
        },
        properties = { titlebars_enabled = true },
    },
}

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then
        awful.client.setslave(c)
    end

    if
        awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position
    then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({}, 1, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.move(c)
        end),
        awful.button({}, 3, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c):setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout = wibox.layout.fixed.horizontal,
        },
        { -- Middle
            { -- Title
                align = "center",
                widget = awful.titlebar.widget.titlewidget(c),
            },
            buttons = buttons,
            layout = wibox.layout.flex.horizontal,
        },
        { -- Right
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal(),
        },
        layout = wibox.layout.align.horizontal,
    }
end)

client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)

awful.spawn.with_shell(os.getenv("HOME") .. "/.config/awesome/autostart.sh")
