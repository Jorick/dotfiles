-------------------------
-- Edited awesome theme --
---------------------------

theme = {}

theme.font          = "montecarlo 11"

theme.bg_normal     = "#1b1b1b"
theme.bg_focus      = "#1b1b1b"
theme.bg_urgent     = "#1b1b1b"
theme.bg_minimize   = "#1b1b1b"

theme.fg_normal     = "#d0d0cc"
theme.fg_focus      = "#23abd2"
theme.fg_urgent     = "#ff0000"
theme.fg_minimize   = "#c8e7a8"

theme.border_width  = "1"
theme.border_normal = "#1b1b1b"
theme.border_focus  = "#23abd2"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = "~/.config/awesome/themes/moss/taglist/squarefw.png"
theme.taglist_squares_unsel = "~/.config/awesome/themes/moss/taglist/squarew.png"

theme.tasklist_floating_icon = "~/.config/awesome/themes/moss/tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "~/.config/awesome/themes/moss/submenu.png"
theme.menu_height = "15"
theme.menu_width  = "100"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "~/.config/awesome/themes/moss/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "~/.config/awesome/themes/moss/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "~/.config/awesome/themes/moss/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "~/.config/awesome/themes/moss/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "~/.config/awesome/themes/moss/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "~/.config/awesome/themes/moss/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "~/.config/awesome/themes/moss/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "~/.config/awesome/themes/moss/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "~/.config/awesome/themes/moss/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "~/.config/awesome/themes/moss/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "~/.config/awesome/themes/moss/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "~/.config/awesome/themes/moss/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "~/.config/awesome/themes/moss/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "~/.config/awesome/themes/moss/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "~/.config/awesome/themes/moss/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "~/.config/awesome/themes/moss/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "~/.config/awesome/themes/moss/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "~/.config/awesome/themes/moss/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
theme.wallpaper_cmd = { "awsetbg /home/jorick/.config/awesome/themes/moss/wallpaper.jpg" }

-- You can use your own layout icons like this:
theme.layout_fairh = "~/.config/awesome/themes/moss/layouts/fairhw.png"
theme.layout_fairv = "~/.config/awesome/themes/moss/layouts/fairvw.png"
theme.layout_floating  = "~/.config/awesome/themes/moss/layouts/floatingw.png"
theme.layout_magnifier = "~/.config/awesome/themes/moss/layouts/magnifierw.png"
theme.layout_max = "~/.config/awesome/themes/moss/layouts/maxw.png"
theme.layout_fullscreen = "~/.config/awesome/themes/moss/layouts/fullscreenw.png"
theme.layout_tilebottom = "~/.config/awesome/themes/moss/layouts/tilebottomw.png"
theme.layout_tileleft   = "~/.config/awesome/themes/moss/layouts/tileleftw.png"
theme.layout_tile = "~/.config/awesome/themes/moss/layouts/tilew.png"
theme.layout_tiletop = "~/.config/awesome/themes/moss/layouts/tiletopw.png"
theme.layout_spiral  = "~/.config/awesome/themes/moss/layouts/spiralw.png"
theme.layout_dwindle = "~/.config/awesome/themes/moss/layouts/dwindlew.png"

theme.awesome_icon = "/home/jorick/.config/awesome/themes/moss/logo20.png"

-- various icons_blue
theme.arch_icon = "/home/jorick/.config/awesome/themes/moss/icons_blue/arch_10x10.png"
theme.batt_icon = "~/.config/awesome/themes/moss/icons_blue/bat_full_01.png"
theme.clock_icon = "~/.config/awesome/themes/moss/icons_blue/clock.png"
theme.cpu_icon = "~/.config/awesome/themes/moss/icons_blue/cpu.png"
theme.mem_icon = "~/.config/awesome/themes/moss/icons_blue/mem.png"
theme.vol_icon = "~/.config/awesome/themes/moss/icons_blue/spkr_01.png"
theme.wifi_icon = "~/.config/awesome/themes/moss/icons_blue/wifi_02.png"
theme.info_icon = "~/.config/awesome/themes/moss/icons_blue/info_03.png"

-- mpd control icons_blue
theme.pause_icon = "~/.config/awesome/themes/moss/icons_blue/pause.png"
theme.play_icon = "~/.config/awesome/themes/moss/icons_blue/play.png"
theme.stop_icon = "~/.config/awesome/themes/moss/icons_blue/stop.png"
theme.next_icon = "~/.config/awesome/themes/moss/icons_blue/next.png"
theme.prev_icon = "~/.config/awesome/themes/moss/icons_blue/prev.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
