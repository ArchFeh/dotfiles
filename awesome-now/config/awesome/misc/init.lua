-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

-- Widget library
local wibox = require("wibox")

-- Bling
local bling = require("lib.bling")

-- rubato (animations)
local rubato = require("lib.rubato")

-- Dock
local dock = require("misc.dock")


-- Helpers
local helpers = require("helpers")


-- Task Preview
----------------

bling.widget.task_preview.enable {
    -- x = 20,
    -- y = 20,
    height = dpi(150),
    width = dpi(220),
    placement_fn = function(c)
        awful.placement.top_left(c, {
            margins = {
                top = beautiful.useless_gap,
                left = beautiful.wibar_width + beautiful.useless_gap
            }
        })
    end
}

-- Tag Preview
--------------------
bling.widget.tag_preview.enable {
    show_client_content = true,  -- Whether or not to show the client content
    x = 10,                       -- The x-coord of the popup
    y = 10,                       -- The y-coord of the popup
    scale = 0.25,                 -- The scale of the previews compared to the screen
    honor_padding = false,        -- Honor padding when creating widget size
    honor_workarea = false,       -- Honor work area when creating widget size
    placement_fn = function(c)    -- Place the widget using awful.placement (this overrides x & y)
        awful.placement.centered(c)
    end,
    background_widget = wibox.widget {    -- Set a background image (like a wallpaper) for the widget 
        image = beautiful.wallpaper,
        horizontal_fit_policy = "fit",
        vertical_fit_policy   = "fit",
        widget = wibox.widget.imagebox
    }
}


-- Window switcher
--------------------

bling.widget.window_switcher.enable {
    type = "thumbnail",

    hide_window_switcher_key = "Escape",
    minimize_key = "n",
    unminimize_key = "N",
    kill_client_key = "q",
    cycle_key = "Tab",
    previous_key = "Right",
    next_key = "Left",
    vim_previous_key = "l",
    vim_next_key = "h"
}


-- Minimalist Dock
awful.screen.connect_for_each_screen(function(s)
	dock.init({
		screen = s,
		height = dpi(50),
		offset = dpi(5),
		inner_shape = gears.shape.rounded_rect,
	})
end)

-- Stuff
----------

require("misc.bar")
require("misc.titlebar")
require("misc.tooltip")
require("misc.dock")
require("misc.exit-screen")
require("misc.notifications")
require("misc.temp_arc")
require("misc.ram_arc")
require("misc.disk_arc")
require("misc.cpu_arc")

