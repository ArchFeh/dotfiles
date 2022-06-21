local awful = require("awful")
local watch = awful.widget.watch
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local active_color = beautiful.accent

local ram_arc = wibox.widget({
	{
		markup = "内存",
		align  = "center",
		valign = "center",
		widget = wibox.widget.textbox
	},
	start_angle = 3 * math.pi / 2,
	min_value = 0,
	max_value = 100,
	value = 50,
	thickness = dpi(8),
	rounded_edge = true,
	bg = active_color .. "44",
	paddings = dpi(10),
	colors = { active_color },
	widget = wibox.container.arcchart,
})

watch('bash -c "free | grep -z 内存.*交换.*"', 10, function(_, stdout)
	local total, used = stdout:match(
		"(%d+)%s*(%d+)%s"
	)
	ram_arc:set_value(used / total * 100)
	collectgarbage("collect")
end)

return ram_arc
