-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Theme handling library
local beautiful = require("beautiful")

-- Notifications library
local naughty = require("naughty")

-- Helpers
local helpers = require("helpers")


-- Make key easier to call
----------------------------

mod = "Mod4"
alt = "Mod1"
ctrl = "Control"
shift = "Shift"


-- Global key bindings
------------------------

awful.keyboard.append_global_keybindings({

---- App

    -- Terminals
    awful.key({mod}, "Return", function()
        awful.spawn(terminal)
    end,
    {description = "打开终端", group = "应用"}),

    -- Launcher
    awful.key({mod}, "d", function()
        awful.spawn(launcher)
    end,
    {description = "打开程序启动器", group = "应用"}),

    -- Hotkeys menu
    awful.key({mod}, "/",
        hotkeys_popup.show_help,
    {description = "热键帮助", group = "应用"}),


---- WM

    -- Toggle titlebar
    awful.key({mod}, "t", function()
        awful.titlebar.toggle(client.focus, beautiful.titlebar_pos)
    end,
    {description = "显示标题栏", group = "Awesome"}),

    -- Toggle titlebar (for all visible clients in selected tag)
    awful.key({mod, shift}, "t", function(c)
        local clients = awful.screen.focused().clients
        for _, c in pairs(clients) do
            awful.titlebar.toggle(c, beautiful.titlebar_pos)
        end
    end,
    {description = "显示所有标题栏", group = "Awesome"}),

    -- Toggle bar
    awful.key({mod}, "b", function()
        myscreen = awful.screen.focused()
        myscreen.mywibar.visible = not myscreen.mywibar.visible
    end,
    {description = "显示/隐藏wibar", group = "Awesome"}),

    -- Restart awesome
    awful.key({mod, shift}, "r", 
        awesome.restart,
    {description = "重载awesome", group = "Awesome"}),

    -- Quit awesome
    awful.key({mod, shift}, "q", 
        awesome.quit,
    {description = "退出awesome", group = "Awesome"}),


---- Window

    -- Focus client by direction
    awful.key({mod}, "k", function()
        awful.client.focus.bydirection("up")
    end,
    {description = "向上", group = "窗口"}),

    awful.key({mod}, "h", function()
        awful.client.focus.bydirection("left")
    end,
    {description = "向左", group = "窗口"}),

    awful.key({mod}, "j", function()
        awful.client.focus.bydirection("down")
    end,
    {description = "向下", group = "窗口"}),

    awful.key({mod}, "l", function()
        awful.client.focus.bydirection("right")
    end,
    {description = "向右", group = "窗口"}),

    -- Resize focused client
    awful.key({mod, ctrl}, "k", function(c)
        helpers.resize_client(client.focus, "up")
    end,
    {description = "向上缩", group = "窗口"}),

    awful.key({mod, ctrl}, "h", function(c)
        helpers.resize_client(client.focus, "left")
    end,
    {description = "向左缩", group = "窗口"}),

    awful.key({mod, ctrl}, "j", function(c)
        helpers.resize_client(client.focus, "down")
    end,
    {description = "向下伸", group = "窗口"}),

    awful.key({mod, ctrl}, "l", function(c)
        helpers.resize_client(client.focus, "right")
    end,
    {description = "向右伸", group = "窗口"}),

    -- Un-minimize windows
    awful.key({mod, shift}, "n", function()
        local c = awful.client.restore()
        if c then
            c:activate{raise = true, context = "key.unminimize"}
        end
    end,    
    {description = "恢复最小化窗口", group = "窗口"}),


---- Misc


    -- Volume
    awful.key({}, "XF86AudioMute", function()
        helpers.volume_control(0)
    end,
    {description = "静音", group = "多媒体"}),

    awful.key({}, "XF86AudioLowerVolume", function()
        helpers.volume_control(-2)
    end,
    {description = "降低音量", group = "多媒体"}),

    awful.key({}, "XF86AudioRaiseVolume", function()
        helpers.volume_control(2)
    end,
    {description = "提高音量", group = "多媒体"}),


    -- Screenshot
    awful.key({mod, shift}, "s", function()
        awful.spawn.with_shell("gnome-screenshot -ac")
    end,
    {description = "截图", group = "多媒体"}),

    -- Window switcher
    awful.key({mod}, "Tab", function()
        awesome.emit_signal("bling::window_switcher::turn_on")
    end,
    {description = "任务切换", group = "多媒体"}),

    -- Lockscreen
    awful.key({ mod, ctrl}, "p", function()
        lock_screen_show()
    end, { description = "锁屏", group = "热键" }),

    -- Exit screen
    awful.key({mod}, "x", function()
        awesome.emit_signal("misc::exit_screen:show")
    end, { description = "退出会话", group = "热键" }),

})


-- Client key bindings
------------------------

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        -- Move or swap by direction
        awful.key({mod, shift}, "k", function(c)
            helpers.move_client(c, "up")
        end),

        awful.key({mod, shift}, "h", function(c)
            helpers.move_client(c, "left")
        end),

        awful.key({mod, shift}, "j", function(c)
            helpers.move_client(c, "down")
        end),

        awful.key({mod, shift}, "l", function(c)
            helpers.move_client(c, "right")
        end),

        -- Relative move client
        awful.key({mod, shift, ctrl}, "j", function (c)
            c:relative_move(0,  dpi(20), 0, 0)
        end),

        awful.key({mod, shift, ctrl}, "k", function (c)
            c:relative_move(0, dpi(-20), 0, 0)
        end),

        awful.key({mod, shift, ctrl}, "h", function (c)
            c:relative_move(dpi(-20), 0, 0, 0)
        end),

        awful.key({mod, shift, ctrl}, "l", function (c)
            c:relative_move(dpi( 20), 0, 0, 0)
        end),

        -- Toggle floating
        awful.key({mod, ctrl}, " ",
            awful.client.floating.toggle
        ),

        awful.key({}, "XF86LaunchA",
            awful.client.floating.toggle
        ),

        -- Toggle fullscreen
        awful.key({mod}, "f", function()
            client.focus.fullscreen = not client.focus.fullscreen 
            client.focus:raise()
        end),

        -- Toggle maximize
        awful.key({mod}, "m", function()
            client.focus.maximized = not client.focus.maximized
        end,
        {description = "窗口最大化", group = "窗口"}),

        -- Minimize windows
        awful.key({mod}, "n", function()
            client.focus.minimized = true
        end,
        {description = "窗口最小化", group = "窗口"}),

        -- Keep on top
        awful.key({mod}, "p", function (c)
            c.ontop = not c.ontop
        end,
        {description = "置顶", group = "窗口"}),

        -- Sticky
        awful.key({mod, shift}, "p", function (c)
            c.sticky = not c.sticky
        end),

        -- Close window
        awful.key({mod}, "w", function()
            client.focus:kill()
        end,
        {description = "关闭窗口", group = "窗口"}),

        -- Center window
        awful.key({mod}, "c", function()
            awful.placement.centered(c, {honor_workarea = true, honor_padding = true})
        end,
        {description = "居中窗口", group = "窗口"}),
    })
end)


-- Move through workspaces
----------------------------

awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers = { mod },
        keygroup = "numrow",
        description = "进入工作区",
        group = "标签",
        on_press = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers = { mod, ctrl },
        keygroup = "numrow",
        description = "置顶工作区",
        group = "标签",
        on_press = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers = { mod, shift },
        keygroup = "numrow",
        description = "转移工作区",
        group = "标签",
        on_press = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    }
})


-- Mouse bindings on desktop
------------------------------

awful.mouse.append_global_mousebindings({

    -- Left click
    awful.button({}, 1, function()
        naughty.destroy_all_notifications()
        if mymainmenu then
            mymainmenu:hide()
        end
    end),

    -- Right click
    awful.button({}, 3, function()
        mymainmenu:toggle()
    end),

    -- Side key
    awful.button({}, 8, awful.tag.viewprev),
    awful.button({}, 9, awful.tag.viewnext)

})


-- Mouse buttons on the client
--------------------------------

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({}, 1, function (c)
            c:activate { context = "mouse_click" }
        end),
        awful.button({mod}, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
        awful.button({mod}, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)

