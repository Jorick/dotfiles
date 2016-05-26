--------------------------
-- Edited awesome theme --
---------------------------

theme = {}

theme.font          = "drift 11"

theme.bg_normal     = "#484e3a"
theme.bg_focus      = "#67744a"
theme.bg_urgent     = "#ff5a00"
theme.bg_minimize   = "#67744a"

theme.fg_normal     = "#d0d0cc"
theme.fg_focus      = "#d0d0cc"
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
theme.taglist_squares_sel   = "~/.config/awesome/themes/tree/taglist/squarefw.png"
theme.taglist_squares_unsel = "~/.config/awesome/themes/tree/taglist/squarew.png"

theme.tasklist_floating_icon = "~/.config/awesome/themes/tree/tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "~/.config/awesome/themes/tree/submenu.png"
theme.menu_height = "15"
theme.menu_width  = "100"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "~/.config/awesome/themes/tree/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "~/.config/awesome/themes/tree/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "~/.config/awesome/themes/tree/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "~/.config/awesome/themes/tree/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "~/.config/awesome/themes/tree/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "~/.config/awesome/themes/tree/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "~/.config/awesome/themes/tree/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "~/.config/awesome/themes/tree/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "~/.config/awesome/themes/tree/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "~/.config/awesome/themes/tree/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "~/.config/awesome/themes/tree/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "~/.config/awesome/themes/tree/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "~/.config/awesome/themes/tree/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "~/.config/awesome/themes/tree/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "~/.config/awesome/themes/tree/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "~/.config/awesome/themes/tree/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "~/.config/awesome/themes/tree/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "~/.config/awesome/themes/tree/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
theme.wallpaper_cmd = { "awsetbg /home/jorick/.config/awesome/themes/tree/wallpaper.jpg" }

-- You can use your own layout icons like this:
theme.layout_fairh = "~/.config/awesome/themes/tree/layouts/fairhw.png"
theme.layout_fairv = "~/.config/awesome/themes/tree/layouts/fairvw.png"
theme.layout_floating  = "~/.config/awesome/themes/tree/layouts/floatingw.png"
theme.layout_magnifier = "~/.config/awesome/themes/tree/layouts/magnifierw.png"
theme.layout_max = "~/.config/awesome/themes/tree/layouts/maxw.png"
theme.layout_fullscreen = "~/.config/awesome/themes/tree/layouts/fullscreenw.png"
theme.layout_tilebottom = "~/.config/awesome/themes/tree/layouts/tilebottomw.png"
theme.layout_tileleft   = "~/.config/awesome/themes/tree/layouts/tileleftw.png"
theme.layout_tile = "~/.config/awesome/themes/tree/layouts/tilew.png"
theme.layout_tiletop = "~/.config/awesome/themes/tree/layouts/tiletopw.png"
theme.layout_spiral  = "~/.config/awesome/themes/tree/layouts/spiralw.png"
theme.layout_dwindle = "~/.config/awesome/themes/tree/layouts/dwindlew.png"

theme.awesome_icon = "/home/jorick/.config/awesome/themes/tree/wallpaper.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
