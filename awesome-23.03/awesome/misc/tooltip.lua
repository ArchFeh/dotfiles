-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

-- Widget library
local wibox = require("wibox")

-- rubato
local rubato = require("lib.rubato")

-- Helpers
local helpers = require("helpers")

-- Get screen geometry
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height


-- Tooltip
------------

-- Helpers
local function create_boxed_widget(widget_to_be_boxed, width, height, inner_pad)
    local box_container = wibox.container.background()
    box_container.bg = beautiful.tooltip_box_bg
    box_container.forced_height = height
    box_container.forced_width = width
    box_container.shape = helpers.rrect(beautiful.tooltip_box_border_radius)

    local inner = dpi(0)

    if inner_pad then inner = beautiful.tooltip_box_margin end

    local boxed_widget = wibox.widget {
        -- Add margins
        {
            -- Add background color
            {
                -- The actual widget goes here
                widget_to_be_boxed,
                margins = inner,
                widget = wibox.container.margin
            },
            widget = box_container,
        },
        margins = beautiful.tooltip_gap / 2,
        color = "#FF000000",
        widget = wibox.container.margin
    }

    return boxed_widget
end

---- Calendar

-- Date
local date_day = wibox.widget{
    font = beautiful.font_name .. "8",
    format = helpers.colorize_text("%A", beautiful.xcolor8),
    widget = wibox.widget.textclock
}

local date_month = wibox.widget{
    font = beautiful.font_name .. "bold 10",
    format = "%d %B",
    widget = wibox.widget.textclock
}

local date = wibox.widget{
    date_day,
    nil,
    date_month,
    layout = wibox.layout.align.vertical
}

-- Time
local time_hour = wibox.widget{
    font = beautiful.font_name .. "bold 18",
    format = "%I",
    align = "center",
    widget = wibox.widget.textclock
}

local time_min = wibox.widget{
    font = beautiful.font_name .. "bold 18",
    format = "%M",
    align = "center",
    widget = wibox.widget.textclock
}

local time_eq = wibox.widget{
    font = beautiful.font_name .. "bold 10",
    format = "%p",
    align = "center",
    widget = wibox.widget.textclock
}

-- Weather
local weather_icon = wibox.widget{
    markup = "",
    font = "icomoon 20",
    align = "center",
    widget = wibox.widget.textbox
}

local weather_temp = wibox.widget{
    markup = "25°C",
    font = beautiful.font_name .. "bold 10",
    align = "center",
    valign = "bottom",
    widget = wibox.widget.textbox
}

local weather = wibox.widget{
    weather_icon,
    nil,
    weather_temp,
    layout = wibox.layout.align.vertical
}

awesome.connect_signal("signal::weather", function(temperature, _, icon_widget)
    local weather_temp_symbol
    if weather_units == "metric" then
        weather_temp_symbol = "°C"
    elseif weather_units == "imperial" then
        weather_temp_symbol = "°F"
    end

    weather_icon.markup = icon_widget
    weather_temp.markup = temperature .. weather_temp_symbol
end)


local temp_arc = require("misc.temp_arc")
local disk_arc = require("misc.disk_arc")
local cpu_arc = require("misc.cpu_arc")
local ram_arc = require("misc.ram_arc")
-- Widget
local date_boxed = create_boxed_widget(date, dpi(110), dpi(50), true)
local hour_boxed = create_boxed_widget(time_hour, dpi(70), dpi(50), true)
local min_boxed = create_boxed_widget(time_min, dpi(70), dpi(50), true)
local eq_boxed = create_boxed_widget(time_eq, dpi(50), dpi(30), true)
local weather_boxed = create_boxed_widget(weather, dpi(50), dpi(70), true)
local temp_boxed = create_boxed_widget(temp_arc, dpi(150), dpi(170), true)
local disk_boxed = create_boxed_widget(disk_arc, dpi(150), dpi(170), true)
local ram_boxed = create_boxed_widget(ram_arc, dpi(150), dpi(170), true)
local cpu_boxed = create_boxed_widget(cpu_arc, dpi(150), dpi(170), true)

-- Stats
cal_tooltip = wibox({
    type = "dropdown_menu",
    screen = screen.primary,
    --height = dpi(150),
    --width = dpi(210),
    height = dpi(500),
    width = dpi(350),
    shape = helpers.rrect(beautiful.tooltip_border_radius - 1),
    bg = beautiful.transparent,
    ontop = true,
    visible = false
})

awful.placement.bottom_left(cal_tooltip, {honor_workarea = true, margins = {left = beautiful.useless_gap, bottom = dpi(12)}})

cal_tooltip_show = function()
    cal_tooltip.visible = true
end

cal_tooltip_hide = function()
    cal_tooltip.visible = false
end

cal_tooltip:setup {
    {
        {
            {
                date_boxed,
                {
                    hour_boxed,
                    min_boxed,
                    layout = wibox.layout.fixed.horizontal
                },
                disk_boxed,
                ram_boxed,
                layout = wibox.layout.fixed.vertical
            },
            {
                weather_boxed,
                eq_boxed,
                temp_boxed,
                cpu_boxed,
                layout = wibox.layout.fixed.vertical
            },
            layout = wibox.layout.fixed.horizontal
        },
        margins = beautiful.tooltip_margin,
        widget = wibox.container.margin
    },
    shape = helpers.rrect(beautiful.tooltip_border_radius),
    bg = beautiful.xbackground,
    widget = wibox.container.background
}
