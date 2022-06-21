-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")


-- Menu
-------------

awful.screen.connect_for_each_screen(function(s)

    -- Submenu
    awesomemenu = {
        {"热键", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end},
        {"编辑配置", editor .. " " .. awesome.conffile},
        {"重载", awesome.restart},
    }

    -- Mainmenu
    mymainmenu = awful.menu({
        items = {
            {"终端", function() awful.spawn.with_shell(terminal) end},
            {"浏览器", function() awful.spawn.with_shell(browser) end},
            {"文件管理器", function() awful.spawn.with_shell(file_manager) end},
            {"Code", function() awful.spawn.with_shell("code") end},
            {"Awesome", awesomemenu},
            {"退出", function() awesome.quit() end}
        }
    })

end)

