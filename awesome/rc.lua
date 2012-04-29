-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
require("vicious")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/home/jorick/.config/awesome/themes/moss/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvtc"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
browser = "google-chrome"
files = "thunar"
music = "urxvt -name ncmpcpp -e ncmpcpp"
mess = "pidgin"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ "terms", "web", "files", "doc", "media" }, s, layouts[2])
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "logout", awesome.quit },
   { "shutdown" , "sudo shutdown" },
   { "reboot" , "sudo reboot" },
   { "sleep" , "sudo pm-suspend" }
}

myinternet = {
	{ "Chrome" , "google-chrome" },
	{ "Firefox" , "firefox" },
	{ "Google Earth", "google-earth"},
	{ "Pidgin", "pidgin"},
	{ "Deluge" , "deluge" },
	{ "Skype" , "skype" }
}

mymedia = {
    { "ncmpcpp", music },
    { "Mplayer", "mplayer" },
    { "VLC" , "vlc" },
    { "Gpicview", "gpicview" },
    { "wxCam" , "wxcam" }
}

mygraphics = {
    { "GIMP" , "gimp-2.6" },
    { "Inkscape" , "inkscape" },
    { "Draw" , "libreoffice-draw %U" },
    { "Feh" , "feh" }
}

myoffice = {
    { "Adobe" , "acraread" },
    { "Base" , "libreoffice-writer" },
    { "Calc" , "libreoffice-calc" },
    { "Impress" , "libreoffice-impress" },
    { "LibreOffice" , "loffice" },
    { "Writer" , "libreoffice-writer" },
    { "epdfview" , "epdfview" },
    { "Zotero" , "zotero" }
}
myscience = {
	{ "Stellarium" , "stellarium" },
	{ "Genius" , "gnome-genius" }
}
mymainmenu = awful.menu({ items = {
				{ "term" , terminal },
				{ "web" , myinternet },
				{ "media" , mymedia, },
				{ "graphic" , mygraphics },
				{ "science", myscience },
				{ "awesome", myawesomemenu }
                                 }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.arch_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
--
-- Vicious
-- --------------------------------------
-- Memory usage
memicon = widget({ type = "imagebox" })
memicon.image = image(beautiful.mem_icon)
memicon.align = "middle"
mem = widget({ type = "textbox", name = "mem" })
mem.text = "RAM "
memwidget = widget({ type = "textbox" })
vicious.register(memwidget, vicious.widgets.mem, " $2Mb", 5)
membar = awful.widget.progressbar()
--membar properties
membar:set_width(50)
membar:set_height(6)
membar:set_vertical(false)
membar:set_background_color("#1b1b1b")
membar:set_border_color(nil)
membar:set_color("#93d44f")
awful.widget.layout.margins[membar.widget] = { top = 5 }
-- Register membar
vicious.register(membar, vicious.widgets.mem, "$1", 5)
-- Cpu usage
cpuicon = widget({ type = "imagebox" })
cpuicon.image = image(beautiful.cpu_icon)
cpuicon.align = "middle"
cpu = widget ({ type = "textbox", name = "cpu" })
cpu.text = "CPU "
cpuwidget = widget({ type = "textbox" })
vicious.register( cpuwidget, vicious.widgets.cpu, " $1%", 1)
cpubar = awful.widget.progressbar()
--cpubar properties
cpubar:set_width(50)
cpubar:set_height(6)
cpubar:set_vertical(false)
cpubar:set_background_color("#1b1b1b")
cpubar:set_border_color(nil)
cpubar:set_color("#93d44f")
awful.widget.layout.margins[cpubar.widget] = { top = 5 }
-- Register cpubar
vicious.register(cpubar, vicious.widgets.cpu, "$1", 1)

-- Battery usage
batticon = widget({ type = "imagebox" })
batticon.image = image(beautiful.batt_icon)
batticon.align = "middle"
batt = widget ({ type = "textbox", name = "batt" })
batt.text = "BAT "
powermenu = awful.menu({items = {
			     { "Ondemand" , function () awful.util.spawn("sudo cpufreq-set -g ondemand -r", false) end },
			     { "Powersave" , function () awful.util.spawn("sudo cpufreq-set -g powersave -r", false) end },
			     { "Performance" , function () awful.util.spawn("sudo cpufreq-set -g performance -r", false) end },
			     { "pm-powersave" , function () awful.util.spawn("sudo pm-powersave", false) end }
			  }
		       })
battwidget = widget({ type = "textbox" })
vicious.register( battwidget, vicious.widgets.bat, " $1 $2% $3", 13, "BAT1" )
battwidget:buttons(awful.util.table.join(
					 awful.button({ }, 1, function () powermenu:toggle() end )
				   ))
battbar = awful.widget.progressbar()
--battbar properties
battbar:set_width(50)
battbar:set_height(6)
battbar:set_vertical(false)
battbar:set_background_color("#1b1b1b")
battbar:set_border_color(nil)
battbar:set_color("#93d44f")
awful.widget.layout.margins[battbar.widget] = { top = 5 }
-- Register battbar
vicious.register(battbar, vicious.widgets.bat, "$2", 13, "BAT1")
-- Uptime
uptimewidget = widget({ type = "textbox" })
vicious.register( uptimewidget, vicious.widgets.uptime, "$2h $3min")
upicon = widget({ type = "imagebox" })
upicon.image = image(beautiful.info_icon)
upicon.align = "middle"
-- System
syswidget = widget({ type = "textbox" })
vicious.register( syswidget, vicious.widgets.os, "System : $1 - $2")
-- Sound volume
volume = widget({type = "textbox", name = "volume" })
volume.text = "Volume "
volumeicon = widget({ type = "imagebox" })
volumeicon.image = image(beautiful.vol_icon)
volumeicon.align = "middle"
volumewidget = widget ({ type = "textbox" })
vicious.register( volumewidget, vicious.widgets.volume, " $1", 4, "Master" )
volumeicon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("amixer -q sset Master toggle", false) end),
    awful.button({ }, 3, function () awful.util.spawn("urxvt -e alsamixer", true) end),
    awful.button({ }, 4, function () awful.util.spawn("amixer -q sset Master 1dB+", false) end),
    awful.button({ }, 5, function () awful.util.spawn("amixer -q sset Master 1dB-", false) end)
))
volumebar = awful.widget.progressbar()
--volumebar properties
volumebar:set_width(50)
volumebar:set_height(6)
volumebar:set_vertical(false)
volumebar:set_background_color("#1b1b1b")
volumebar:set_border_color(nil)
volumebar:set_color("#93d44f")
awful.widget.layout.margins[volumebar.widget] = { top = 5 }
-- Register volumebar
vicious.register(volumebar, vicious.widgets.volume, "$1", 4, "Master")
-- MPD widget
mpd = widget({ type = "textbox", name = "mpd" })
mpd.text = "MPD "
mpdwidget = widget({ type = "textbox" })
vicious.register( mpdwidget, vicious.widgets.mpd,
			function (widget, args)
			   if args["{state}"] == "Stop" then
			      return "not playing"
			   elseif args["{state}"] == "Pause" then 
			      return "Paused : " .. args["{Artist}"] .. " - " .. args["{Title}"]
			   else
			      return "Playing : ".. args["{Artist}"] .. " - " .. args["{Title}"]
			   end
			end, 4)
-- MPD control icons
playicon = widget({ type = "imagebox" })
playicon.image = image(beautiful.play_icon)
playicon.align = "middle"
playicon:buttons(awful.util.table.join(
	awful.button({ }, 1, function () awful.util.spawn("ncmpcpp play") end)
		))
pauseicon = widget({ type = "imagebox" })
pauseicon.image = image(beautiful.pause_icon)
pauseicon.align = "middle"
pauseicon:buttons(awful.util.table.join(
	awful.button({ }, 1, function () awful.util.spawn("ncmpcpp pause") end)
		))
stopicon = widget({ type = "imagebox" })
stopicon.image = image(beautiful.stop_icon)
stopicon.align = "middle"
stopicon:buttons(awful.util.table.join(
	awful.button({ }, 1, function () awful.util.spawn("ncmpcpp stop") end)
		))
nexticon = widget({ type = "imagebox" })
nexticon.image = image(beautiful.next_icon)
nexticon.align = "middle"
nexticon:buttons(awful.util.table.join(
	awful.button({ }, 1, function () awful.util.spawn("ncmpcpp next") end)
		))
previcon = widget({ type = "imagebox" })
previcon.image = image(beautiful.prev_icon)
previcon.align = "middle"
previcon:buttons(awful.util.table.join(
	awful.button({ }, 1, function () awful.util.spawn("ncmpcpp prev") end)
		))

-- Wifi widget
wifiicon = widget({ type = "imagebox" })
wifiicon.image = image(beautiful.wifi_icon)
wifiicon.align = "middle"
wifi = widget({ type = "textbox", name = "wifi" })
wifi.text = "Wifi"
wifiwidget = widget({ type = "textbox" })
vicious.register( wifiwidget, vicious.widgets.wifi, "${ssid} ", 5, "wlan0")
wifibar = awful.widget.progressbar()
--wifibar properties
wifibar:set_width(50)
wifibar:set_height(6)
wifibar:set_vertical(false)
wifibar:set_background_color("#1b1b1b")
wifibar:set_border_color(nil)
wifibar:set_color("#93d44f")
awful.widget.layout.margins[wifibar.widget] = { top = 5 }
-- Register wifibar
vicious.register(wifibar, vicious.widgets.wifi, "${linp}", 5, "wlan0")
-------------------------------
-- Create a textclock widget
clockicon = widget({ type = "imagebox" })
clockicon.image = image(beautiful.clock_icon)
clockicon.align = "middle"
mytextclock = awful.widget.textclock({ align = "right" })
-- Spacer widget
myspacer = widget({ type = "textbox" })
myspacer.text = " | "
-- Space widget
space = widget({type = "textbox" })
space.width = 10
-- left bracket
leftb = widget({ type = "textbox" })
leftb.text = " [ "
-- right bracket
rightb = widget({ type = "textbox" })
rightb.text = " ] "
-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
topbar = {}
bottombar = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    topbar[s] = awful.wibox({ position = "top", screen = s })
    bottombar[s] = awful.wibox({ position = "bottom", screen = s })
    -- Add widgets to the wibox - order matters
    topbar[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
	    space,
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
	mylayoutbox[s],
	space,
        s == 1 and mysystray or nil,
        mytextclock,clockicon,
	space,
	rightb,wifibar.widget,leftb,
	wifiwidget,
	wifiicon,
	space,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
    bottombar[s].widgets = {
	    {
		    space,
		    volumeicon,leftb,volumebar.widget,rightb,volumewidget,
		    space,
		    previcon,stopicon,pauseicon,playicon,nexticon,mpdwidget,
		    space,
		    layout = awful.widget.layout.horizontal.leftright
	    },
	    space,
	    battwidget,rightb,battbar.widget,leftb,batticon,
	    space,
	    cpuwidget,rightb,cpubar.widget,leftb,cpuicon,
	    space,
	    memwidget,rightb,membar.widget,leftb,memicon,
	    space,
	    uptimewidget,upicon,
	    layout = awful.widget.layout.horizontal.rightleft
    } 
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
--    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
--    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),
    awful.key({ modkey, "Control" }, "c", function () awful.util.spawn(browser) end),
    awful.key({ modkey, "Control" }, "m", function () awful.util.spawn(music) end),
    awful.key({ modkey, "Control" }, "v", function () awful.util.spawn(text_editor) end),
    awful.key({ modkey, "Control" }, "p", function () awful.util.spawn(messenger) end),
    awful.key({ modkey, "Control" }, "f", function () awful.util.spawn(files) end),
    awful.key({ modkey, "Control" }, "t", function () awful.util.spawn("thunderbird") end),
    -- Volume control
    awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer -q sset Master 1dB+", false) end),
    awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn("amixer -q sset Master 1dB-", false) end),
    --Music control
    awful.key({ modkey, }, "Down", function () awful.util.spawn( "ncmpcpp toggle", false ) end),
    awful.key({ modkey, }, "Up", function () awful.util.spawn( "ncmpcpp stop", false ) end ),
    awful.key({ modkey, }, "Left", function () awful.util.spawn( "ncmpcpp prev", false ) end ),
    awful.key({ modkey, }, "Right", function () awful.util.spawn( "ncmpcpp next", false ) end ),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
		     size_hints_honor = false,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
     { rule = { instance = "FlightGear" },
   	properties = { tag = tags[1][5] } },
   { rule = { class = "Google-chrome" };
   	properties = { tag = tags[1][2] } },
   { rule = { class = "Blender"},
   	properties = { tag = tags[1][5] } },
   { rule = { class = "Inkscape"},
   	properties = { tag = tags[1][5] } },
   { rule = { class = "URxvt" },
   	 properties = { tag = tags[1][1] } },
   { rule = { class = "Pidgin" },
   	properties = { tag = tags [1][5], floating = true } },
   { rule = { class = "Transmission" },
   	properties = { tag = tags[1][5], floating = true } },
   { rule = { class = "Epdfview" },
      properties = { tag = tags[1][4] } },
   { rule = { class = "feh" },
      properties = { tag = tags[1][4], floating = true } },
   { rule = { class = "gpicview" },
   	properties = { tag = tags[1][4], floating = true } },
   { rule = { class = "Thunar" },
      porperties = { tag = tags[1][3] } },
   { rule = { instance = "ranger" },
      porperties = { tag = tags[1][1], floating = true } },
   { rule = { instance = "ncmpcpp" },
      porperties = { tag = tags[1][1], floating = true } },
   { rule = { class = "Thunderbird" },
   	properties = { tag = tags[1][3] } },
   { rule = { class = "LibreOffice" },
   	properties = { tag = tags[1][4] } },

}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
