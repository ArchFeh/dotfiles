--[[
 _____ __ _ __ _____ _____ _____ _______ _____
|     |  | |  |  ___|  ___|     |       |  ___|
|  -  |  | |  |  ___|___  |  |  |  | |  |  ___|
|__|__|_______|_____|_____|_____|__|_|__|_____|

--]]
pcall(require, "luarocks.loader")

-- Standard awesome library
local gfs = require("gears.filesystem")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")
dpi = beautiful.xresources.apply_dpi
beautiful.init(gfs.get_configuration_dir() .. "theme/theme.lua")


-- User vars
--------------

terminal = "alacritty"
editor = "code"
browser = "google-chrome-stable"
launcher = "rofi -no-lazy-grab -show drun -modi drun -theme " .. gfs.get_configuration_dir() .. "main/rofi.rasi"
file_manager = "nautilus"

openweathermap_key = "b63ce3bf11eeadbc2c94acb5ca7de35b"
openweathermap_city_id = "1784642"
weather_units = "metric" -- metric or imperial


-- Load configuration
-----------------------

-- Sub (signals for battery, volume, brightness, etc)
require("sub")

-- Misc (bar, titlebar, notification, etc)
require("misc")

-- Main (layouts, keybinds, rules, etc)
require("main")


-- Autostart
--------------

awful.spawn.with_shell("~/.config/awesome/main/autorun.sh")


-- Garbage Collector
----------------------

collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
