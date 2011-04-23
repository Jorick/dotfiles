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
beautiful.init("/home/jorick/.config/awesome/themes/wabbit/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
browser = "chromium"
files = "dolphin /home/jorick/"
text_editor = "vim"
music = "ncmpcpp"
messenger = "kmess"

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
   tags[s] = awful.tag({ "alfa", "beta", "gamma", "delta", "Epsilon", "zeta"}, s,
		       { layouts[9], layouts[2], layouts[2],
			  layouts[2], layouts[1], layouts[1]
		       })
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart WM", awesome.restart },
   { "logout", awesome.quit },
   { "shutdown" , "sudo /sbin/halt -p" },
   { "reboot" , "sudo /sbin/reboot" },
   { "sleep" , "sudo pm-suspend" },
   { "hibernate" , "sudo pm-hibernate" }
}
myinternet = {
    { "Chromium", "chromium" },
    { "DWB" , "dwb" },
    { "Firefox" , "firefox" },
    { "IM" , "kmess" },
    { "IRC" , "weechat-curses"},
    { "Torrent" , "ktorrent" },
    { "Wicd" , "wicd-client" },
    { "GoogleEarth" , "googleearth" }
}

mymedia = {
    { "ncmpcpp", "urxvt -e ncmpcpp" },
    { "VLC" , "vlc" },
    { "K3b" , "d3b" },
    { "wxCam" , "wxcam" }
}

mygraphics = {
    { "Blender" , "blender" },
    { "GIMP" , "gimp-2.6" },
    { "Inkscape" , "inkscape" },
    { "Draw" , "lodraw %U" },
    { "Gwenview" , "gwenview %U" }
}

myoffice = {
    { "Base" , "lobase %U" },
    { "Calc" , "localc %U" },
    { "Impress" , "loimpress %U" },
    { "LibreOffice" , "loffice %U" },
    { "Writer" , "lowriter %U" },
    { "Xpdf" , "xpdf" },
    { "Okular" , "okular %U" }
}

mysystem = {
    { "htop" , "urxvt -e htop" },
    { "Partition" , "partitionmanager" },
    { "Catalyst" , "amdcccle" },
    { "Printing" , "hp-toolbox" },
    { "Sys mon" , "ksysguard %U" }
}

myutilities = {
    { "Avast" , "avastgui" },
    { "Gvimm" , "gvim" },
    { "Virtualbox" , "VirtualBox %U" }
}

myplaces = {
    { "Home" , "dolphin /home/jorick/" },
    { "Documents" , "dolphin /home/jorick/Documents/" },
    { "Downloads" , "dolphin /home/jorick/Downloads/" },
    { "Music" , "dolphin /home/jorick/Music/" },
    { "Pictures" , "dolphin /home/jorick/Pictures/" },
    { "Programs" , "dolphin /home/jorick/Programs/" },
    { "Videos" , "dolphin /home/jorick/Videos/" }
}

myscience = {    { "Galaxy" , "galaxy" }
 }

mygames = {
   { "Angry Birds" , "wine /home/jorick/Games/AngryBirds_2011/Angry_Birds/AngryBirds.exe" },
   { "Mars" , "mars-shooter" },
   { "Frozen bubble" , "/usr/bin/vendor_perl/frozen-bubble" },
   { "TCE:CQB" , "/usr/bin/true-combat-cwb" },
   { "PlaneShift" , "/home/jorick/Games/PlaneShift/pslaunch" },
   { "Spring" , "springlobby" },
   { "Brutalchess" , "brutalchess" },
   { "World of Goo" , "/home/jorick/Programs/World.Of.Goo.v1.40.Linux-WoG/WorldOfGoo.sh" },
   { "Tux Racer" , "etracer" },
   { "Scorched3D" , "scorched3d" },
   { "FreeOrion" , "freeorion" },
   { "Qonk" , "qonk" }
}
mymainmenu = awful.menu({ items = { 
	     		  	    { "Terminal", terminal },
				    { "Emacs" ,"emacs" },
				    { "Places" , myplaces },
				    { "Internet" , myinternet },
				    { "Media" , mymedia },
				    { "Graphics" , mygraphics },
				    { "Games" , mygames },
                                    { "Science" , myscience },
				    { "Office" , myoffice },
				    { "Utilities" , myutilities },
				    { "Systools" , mysystem },
				    { "Awesome", myawesomemenu }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox

-- Vicious
-- --------------------------------------
-- Memory usage
memwidget = widget({ type = "textbox" })
vicious.register(memwidget, vicious.widgets.mem, "RAM : $1% = $2Mb", 5)
-- Cpu usage
cpuwidget = widget({ type = "textbox" })
vicious.register( cpuwidget, vicious.widgets.cpu, "CPU : total: $1% core1: $2% core2: $3% core3: $4% core4 $5%")
-- Battery usage
powermenu = awful.menu({items = {
			     { "Ondemand" , function () awful.util.spawn("sudo cpufreq-set -g ondemand -r", false) end },
			     { "Powersave" , function () awful.util.spawn("sudo cpufreq-set -g powersave -r", false) end },
			     { "Performance" , function () awful.util.spawn("sudo cpufreq-set -g performance -r", false) end },
			     { "pm-powersave" , function () awful.util.spawn("sudo pm-powersave", false) end }
			  }
		       })
battwidget = widget({ type = "textbox" })
vicious.register( battwidget, vicious.widgets.bat, "Battery : state: $1 load: $2%", 13, "BAT1" )
battwidget:buttons(awful.util.table.join(
					 awful.button({ }, 1, function () powermenu:toggle() end )
				   ))
-- Uptime
uptimewidget = widget({ type = "textbox" })
vicious.register( uptimewidget, vicious.widgets.uptime, "Uptime : $2h$3min")
-- System
syswidget = widget({ type = "textbox" })
vicious.register( syswidget, vicious.widgets.os, "System : $1 - $2")
-- Sound volume
volumewidget = widget ({ type = "textbox" })
vicious.register( volumewidget, vicious.widgets.volume, "Volume : $2 $1%", 4, "Master" )
volumewidget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("amixer -q sset Master toggle", false) end),
    awful.button({ }, 3, function () awful.util.spawn("urxvt -e alsamixer", true) end),
    awful.button({ }, 4, function () awful.util.spawn("amixer -q sset Master 1dB+", false) end),
    awful.button({ }, 5, function () awful.util.spawn("amixer -q sset Master 1dB-", false) end)
))
-- MPD widget
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
-- Wifi widget
wifiwidget = widget({ type = "textbox" })
vicious.register( wifiwidget, vicious.widgets.wifi, "wifi : ${ssid} rate: ${rate}MB/s link: ${link}/70", 5, "wlan0")
-- -------------------------------------
-- Spacer widget
myspacer = widget({ type = "textbox" })
myspacer.text = " | "
-- Space widget
space = widget({type = "textbox" })
space.width = 10 
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

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
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
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
    topbar[s] = awful.wibox({ position = "top", screen = s, fg = beautiful.fg_normal, bg = beautiful.bg_normal })
    -- Second wibox
     bottombar[s] = awful.wibox({
				  position = "bottom", screen = s, fg = beautiful.fg_normal, bg = beautiful.bg_normal
			       })
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
        s == 1 and mysystray or nil,
        mytextclock,
	myspacer,
	wifiwidget,
	space,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
    bottombar[s].widgets = {
       {
	  mylauncher,
	  space,
	  syswidget,
	  myspacer,
	  uptimewidget,
	  layout = awful.widget.layout.horizontal.leftright
       },
       space,
       battwidget,
       myspacer,
       cpuwidget,
       myspacer,
       memwidget,
       myspacer,
       volumewidget,
       myspacer,
       mpdwidget,
       layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}
----------------------------------------------------------
----------------------------------------------------------

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey, "Control"          }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey, "Control"          }, "Right",  awful.tag.viewnext       ),
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
            if client.focus then                client.focus:raise()
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
    awful.key({ modkey, "Control" }, "c", function () awful.util.spawn(browser) end),
    awful.key({ modkey, "Control" }, "a", function () awful.util.spawn(music) end),
    awful.key({ modkey, "Control" }, "v", function () awful.util.spawn(text_editor) end),
    awful.key({ modkey, "Control" }, "m", function () awful.util.spawn(messenger) end),
    awful.key({ modkey, "Control" }, "t", function () awful.util.spawn(files) end),
    awful.key({ modkey, "Control" }, "f", function () awful.util.spawn("firefox-beta-bin") end),
    awful.key({ modkey, "Control" }, "d", function () awful.util.spawn("dwb") end),
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
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
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
      properties = {-- border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
	             size_hints_honor = false
                    }
   },
    { rule = { class = "Vlc" },
       properties = { floating = true, tag = tags[1][5] } },
    { rule = { class = "Gimp" },
       properties = { floating = true, tag = tags[1][6] } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
   { rule = { class = "FlightGear" },
   	properties = { tag = tags[1][5] } },
   { rule = { class = "Chromium" };
   	properties = { tag = tags[1][2] } },
   { rule = { class = "Wicd" },
   	properties = { tag =  tags[1][5] } }, 
   { rule = { class = "Blender"},
   	properties = { floating = true, tag = tags[1][6] } },
   { rule = { class = "Inkscape"},
   	properties = { tag = tags[1][6] } },
   -- { rule = { class = "URxvt" },
   -- properties = { tag = tags[1][1] } },
   { rule = { class = "Kmess" },
      properties = { tag = tags[1][5], floating = true } },
   { rule = { class = "ktorrent" },
   	properties = { tag = tags[1][5], floating = true } },
   { rule = { class = "Xpdf" },
      properties = { tag = tags[1][3] } },
   { rule = { class = "Feh" },
      properties = { tag = tags[1][3], floating = true } },
   { rule = { class = "Dolphin"},
      porperties = { tag = tags[1][4], floating = true } },
}
-- }}}

-- {{{ Autorun
-- Autorun programs at startup
-- autorun, run only once
function run_once(prg)
	if not prg then
		do return nil end
	end
	awful.util.spawn_with_shell("pgrep -f -u $USER -x " .. prg .. " || (" .. prg .. ")")
end

--Autorun Apps
--run_once("wicd-client")
--run_once("mpd .mpd/mpd.conf")
--run_once("mpdscribble --daemon-user jorick --conf .mpdscribble/mpdscribble.conf --log .mpdscribble/log.log --cache .mpdscribble/cache")

-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
--    awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if ( awful.layout.get(c.screen) ~= awful.layout.suit.magnifier and awful.layout.get(c.screen) ~= awful.layout.suit.floating)
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

 client.add_signal("focus", function(c)  if awful.layout.get(c.screen) == awful.layout.suit.floating then
	 					c.border_color = beautiful.border_focus 
	 				 	c.border_width = beautiful.border_width
					end
					 if awful.layout.get(c.screen) ~= awful.layout.suit.floating then
						 c.opacity = 1
					 end
				end)
 client.add_signal("unfocus", function(c) 	c.border_color = beautiful.border_normal
	 				  	c.border_width = beautiful.border_width_unfocus
					  if awful.layout.get(c.screen) ~= awful.layout.suit.floating then
						  c.opacity = 0.7
					  end
 				end)
-- }}}

