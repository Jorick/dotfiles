---------------------------
-- Edited awesome theme --
---------------------------

theme = {}

theme.font          = "MonteCarlo medium 11"

theme.bg_normal     = "#2c2c2c"
theme.bg_focus      = "#478932"
theme.bg_urgent     = "#d6d9ba"
theme.bg_minimize   = "#74af55"

theme.fg_normal     = "#f7be57"
theme.fg_focus      = "#d6d9ba"
theme.fg_urgent     = "#2c2c2c"
theme.fg_minimize   = "#2c2c2c"

theme.border_width  = "0"
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
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
theme.taglist_squares_sel   = "~/.config/awesome/themes/wabbit/taglist/squarefw.png"
theme.taglist_squares_unsel = "~/.config/awesome/themes/wabbit/taglist/squarew.png"

theme.tasklist_floating_icon = "~/.config/awesome/themes/wabbit/tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "~/.config/awesome/themes/wabbit/submenu.png"
theme.menu_height = "15"
theme.menu_width  = "100"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "~/.config/awesome/themes/wabbit/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "~/.config/awesome/themes/wabbit/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "~/.config/awesome/themes/wabbit/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "~/.config/awesome/themes/wabbit/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "~/.config/awesome/themes/wabbit/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "~/.config/awesome/themes/wabbit/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "~/.config/awesome/themes/wabbit/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "~/.config/awesome/themes/wabbit/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "~/.config/awesome/themes/wabbit/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "~/.config/awesome/themes/wabbit/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "~/.config/awesome/themes/wabbit/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "~/.config/awesome/themes/wabbit/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "~/.config/awesome/themes/wabbit/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "~/.config/awesome/themes/wabbit/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "~/.config/awesome/themes/wabbit/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "~/.config/awesome/themes/wabbit/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "~/.config/awesome/themes/wabbit/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "~/.config/awesome/themes/wabbit/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
theme.wallpaper_cmd = { "awsetbg /home/jorick/.config/awesome/themes/wabbit/wabbit.jpg" }

-- You can use your own layout icons like this:
theme.layout_fairh = "~/.config/awesome/themes/wabbit/layouts/fairhw.png"
theme.layout_fairv = "~/.config/awesome/themes/wabbit/layouts/fairvw.png"
theme.layout_floating  = "~/.config/awesome/themes/wabbit/layouts/floatingw.png"
theme.layout_magnifier = "~/.config/awesome/themes/wabbit/layouts/magnifierw.png"
theme.layout_max = "~/.config/awesome/themes/wabbit/layouts/maxw.png"
theme.layout_fullscreen = "~/.config/awesome/themes/wabbit/layouts/fullscreenw.png"
theme.layout_tilebottom = "~/.config/awesome/themes/wabbit/layouts/tilebottomw.png"
theme.layout_tileleft   = "~/.config/awesome/themes/wabbit/layouts/tileleftw.png"
theme.layout_tile = "~/.config/awesome/themes/wabbit/layouts/tilew.png"
theme.layout_tiletop = "~/.config/awesome/themes/wabbit/layouts/tiletopw.png"
theme.layout_spiral  = "~/.config/awesome/themes/wabbit/layouts/spiralw.png"
theme.layout_dwindle = "~/.config/awesome/themes/wabbit/layouts/dwindlew.png"

theme.awesome_icon = "/home/jorick/.config/awesome/themes/wabbit/logo20_orange.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
