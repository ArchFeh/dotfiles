-- Provides:
-- signal::temp
-- 	used percentage (integer)
local awful = require("awful")
local watch = awful.widget.watch
local update_interval = 5

temp_path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon0/temp1_input"
watch([[
	sh -c "cat ]] .. temp_path .. [["
	]], update_interval, function(widget, stdout)
	local temp = stdout
	temp = temp / 1000	
	awesome.emit_signal("signal::temp", temp)
end)

