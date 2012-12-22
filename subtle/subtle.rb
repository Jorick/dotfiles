#
# Author::  Christoph Kappel <unexist@dorfelite.net>
# Version:: $Id$
# License:: GNU GPLv2
#
# = Subtle default configuration
#
# This file will be installed as default and can also be used as a starter for
# an own custom configuration file. The system wide config usually resides in
# +/etc/xdg/subtle+ and the user config in +HOME/.config/subtle+, both locations
# are dependent on the locations specified by +XDG_CONFIG_DIRS+ and
# +XDG_CONFIG_HOME+.
#

#
# == Options
#
# Following options change behaviour and sizes of the window manager:
#

# Window move/resize steps in pixel per keypress
set :step, 5

# Window screen border snapping
set :snap, 10

# Default starting gravity for windows. Comment out to use gravity of
# currently active client
set :gravity, :center

# Make transient windows urgent
set :urgent, false

# Honor resize size hints globally
set :resize, false

# Enable gravity tiling
set :tiling, false

#set :font, "xft:sans-8" deprecated

# Separator between sublets deprecated
#set :separator, " "

# Set the WM_NAME of subtle (Java quirk)
# set :wmname, "LG3D"

#
# == Screen
#
# Generally subtle comes with two panels per screen, one on the top and one at
# the bottom. Each panel can be configured with different panel items and
# sublets screen wise. The default config uses top panel on the first screen
# only, it's up to the user to enable the bottom panel or disable either one
# or both.

# === Properties
#
# [*stipple*]    This property adds a stipple pattern to both screen panels.
#
#                Example: stipple "~/stipple.xbm"
#                         stipple Subtlext::Icon.new("~/stipple.xbm")
#
# [*top*]        This property adds a top panel to the screen.
#
#                Example: top [ :views, :title ]
#
# [*bottom*]     This property adds a bottom panel to the screen.
#
#                Example: bottom [ :views, :title ]

#
# Following items are available for the panels:
#
# [*:views*]     List of views with buttons
# [*:title*]     Title of the current active window
# [*:tray*]      Systray icons (Can be used only once)
# [*:keychain*]  Display current chain (Can be used only once)
# [*:sublets*]   Catch-all for installed sublets
# [*:sublet*]    Name of a sublet for direct placement
# [*:spacer*]    Variable spacer (free width / count of spacers)
# [*:center*]    Enclose items with :center to center them on the panel
# [*:separator*] Insert separator
#
# Empty panels are hidden.
#
# === Links
#
# http://subforge.org/projects/subtle/wiki/Multihead
# http://subforge.org/projects/subtle/wiki/Panel
#

screen 1 do
  top    [ :views, :center, :volume, :separator, :mpd, :separator, :center, :spacer, :tray, :separator, :wifi, :battery, :clock, :notify ]
  bottom [ ]
end

# Example for a second screen:
screen 2 do
  top    [ :views, :center, :volume, :separator, :mpd, :separator, :center, :spacer, :tray, :separator, :wifi, :battery, :clock, :notify ]
#bottom [ ]
end
#
# == Styles
#
# Styles define various properties of styleable items in a CSS-like syntax.
#
# If no background color is given no color will be set. This will ensure a
# custom background pixmap won't be overwritten.
#
# === Link
#
# http://subforge.org/projects/subtle/wiki/Styles

# Style for all style elements
style :all do
  font        "xft:montecarlo-11"
  background  "#000000"
  border      "#303030", 0
  padding     2, 3
end

# Style for the views
style :views do
  foreground  "#808080"
  icon        "#808080"

  # Style for the active views
  style :focus do
    foreground  "#23abd2"
    icon        "#23abd2"
    border_bottom "#23abd2", 2
  end

  # Style for urgent window titles and views
  style :urgent do
    foreground  "#d76d05"
    icon        "#d76d05"
  end

  # Style for occupied views (views with clients)
  style :occupied do
    foreground  "#d0d0cc"
    icon        "#d0d0cc"
    border_bottom "#d0d0cc", 2
  end
end

# Style for sublets
style :sublets do
  foreground  "#d0d0cc"
  padding     2,3
  icon        "#23abd2"
end

# Style for separator
style :separator do
  foreground  "#808080"
  separator " "
end

# Style for focus window title
style :title do
  foreground  "#808080"
end

# Style for active/inactive windows
style :clients do
  active      "#23abd2", 2
  inactive    "#1b1b1b", 2
  margin      4
  width       50
end

# Style for subtle
style :subtle do
  margin      2, 2, 2, 2
  panel       "#000000"
 # background  "#3d3d3d"
  stipple     "#757575"
end

#
# == Gravities
#
# Gravities are predefined sizes a window can be set to. There are several ways
# to set a certain gravity, most convenient is to define a gravity via a tag or
# change them during runtime via grab. Subtler and subtlext can also modify
# gravities.
#
# A gravity consists of four values which are a percentage value of the screen
# size. The first two values are x and y starting at the center of the screen
# and he last two values are the width and height.
#
# === Example
#
# Following defines a gravity for a window with 100% width and height:
#
#   gravity :example, [ 0, 0, 100, 100 ]
#
# === Link
#
# http://subforge.org/projects/subtle/wiki/Gravity
#

# Top left
gravity :top_left,       [   0,   0,  50,  50 ]
gravity :top_left66,     [   0,   0,  50,  66 ]
gravity :top_left33,     [   0,   0,  50,  34 ]

# Top
gravity :top,            [   0,   0, 100,  50 ]
gravity :top66,          [   0,   0, 100,  66 ]
gravity :top33,          [   0,   0, 100,  34 ]

# Top right
gravity :top_right,      [  50,   0,  50,  50 ]
gravity :top_right66,    [  50,   0,  50,  66 ]
gravity :top_right33,    [  50,   0,  50,  33 ]

# Left
gravity :left,           [   0,   0,  50, 100 ]
gravity :left66,         [   0,   0,  66, 100 ]
gravity :left33,         [   0,   0,  33, 100 ]

# Center
gravity :center,         [   0,   0, 100, 100 ]
gravity :center66,       [  17,  17,  66,  66 ]
gravity :center33,       [  33,  33,  33,  33 ]

# Right
gravity :right,          [  50,   0,  50, 100 ]
gravity :right66,        [  34,   0,  66, 100 ]
gravity :right33,        [  67,  50,  33, 100 ]

# Bottom left
gravity :bottom_left,    [   0,  50,  50,  50 ]
gravity :bottom_left66,  [   0,  34,  50,  66 ]
gravity :bottom_left33,  [   0,  67,  50,  33 ]

# Bottom
gravity :bottom,         [   0,  50, 100,  50 ]
gravity :bottom66,       [   0,  34, 100,  66 ]
gravity :bottom33,       [   0,  67, 100,  33 ]

# Bottom right
gravity :bottom_right,   [  50,  50,  50,  50 ]
gravity :bottom_right66, [  50,  34,  50,  66 ]
gravity :bottom_right33, [  50,  67,  50,  33 ]

# Gimp
gravity :gimp_image,     [  10,   0,  80, 100 ]
gravity :gimp_toolbox,   [   0,   0,  10, 100 ]
gravity :gimp_dock,      [  90,   0,  10, 100 ]

#
# == Grabs
#
# Grabs are keyboard and mouse actions within subtle, every grab can be
# assigned either to a key and/or to a mouse button combination. A grab
# consists of a chain and an action.
#
# === Finding keys
#
# The best resource for getting the correct key names is
# */usr/include/X11/keysymdef.h*, but to make life easier here are some hints
# about it:
#
# * Numbers and letters keep their names, so *a* is *a* and *0* is *0*
# * Keypad keys need *KP_* as prefix, so *KP_1* is *1* on the keypad
# * Strip the *XK_* from the key names if looked up in
#   /usr/include/X11/keysymdef.h
# * Keys usually have meaningful english names
# * Modifier keys have special meaning (Alt (A), Control (C), Meta (M),
#   Shift (S), Super (W))
#
# === Chaining
#
# Chains are a combination of keys and modifiers to one or a list of keys
# and can be used in various ways to trigger an action. In subtle, there are
# two ways to define chains for grabs:
#
#   1. *Default*: Add modifiers to a key and use it for a grab
#
#      *Example*: grab "W-Return", "urxvt"
#
#   2. *Chain*: Define a list of grabs that need to be pressed in order
#
#      *Example*: grab "C-y Return", "urxvt"
#
# ==== Mouse buttons
#
# [*B1*] = Button1 (Left mouse button)
# [*B2*] = Button2 (Middle mouse button)
# [*B3*] = Button3 (Right mouse button)
# [*B4*] = Button4 (Mouse wheel up)
# [*B5*] = Button5 (Mouse wheel down)
#
# ==== Modifiers
#
# [*A*] = Alt key
# [*C*] = Control key
# [*M*] = Meta key
# [*S*] = Shift key
# [*W*] = Super (Windows) key
#
# === Action
#
# An action is something that happens when a grab is activated, this can be one
# of the following:
#
# [*symbol*] Run a subtle action
# [*string*] Start a certain program
# [*array*]  Cycle through gravities
# [*lambda*] Run a Ruby proc
#
# === Example
#
# This will create a grab that starts a urxvt when Alt+Enter are pressed:
#
#   grab "A-Return", "urxvt"
#   grab "C-a c",    "urxvt"
#
# === Link
#
# http://subforge.org/projects/subtle/wiki/Grabs
#

# Jump to view1, view2, ...
#grab "W-S-1", :ViewJump1
#grab "W-S-2", :ViewJump2
#grab "W-S-3", :ViewJump3
#grab "W-S-4", :ViewJump4
#grab "W-S-5", :ViewJump5
#grab "W-S-6", :ViewJump6
#grab "w-S-7", :ViewJump7

# Switch current view
grab "W-1", :ViewSwitch1
grab "W-2", :ViewSwitch2
grab "W-3", :ViewSwitch3
grab "W-4", :ViewSwitch4
grab "W-5", :ViewSwitch5
grab "W-6", :ViewSwitch6
grab "W-7", :ViewSwitch7
grab "W-8", :ViewSwitch8
grab "W-9", :ViewSwitch9
grab "W-0", :ViewSwitch0

# Move client to  different view
grab "W-S-1" do |c|
  c.tags = ["terms"]
end

grab "W-S-2" do |c|
  c.tags = ["browser"]
end

grab "W-S-3" do |c|
  c.tags = ["docs"]
end

grab "W-S-4" do |c|
  c.tags = ["IM"]
end

# Select next and prev view */
#grab "KP_Add",      :ViewNext
#grab "KP_Subtract", :ViewPrev

# Move mouse to screen1, screen2, ...
grab "W-A-1", :ScreenJump1
grab "W-A-2", :ScreenJump2
grab "W-A-3", :ScreenJump3
grab "W-A-4", :ScreenJump4

# Force reload of config and sublets
grab "W-C-r", :SubtleReload

# Force restart of subtle
grab "W-C-S-r", :SubtleRestart

# Quit subtle
grab "W-C-q", :SubtleQuit

# Move current window
grab "W-B1", :WindowMove

# Resize current window
grab "W-B3", :WindowResize

# Toggle floating mode of window
grab "W-f", :WindowFloat

# Toggle fullscreen mode of window
grab "W-space", :WindowFull

# Toggle sticky mode of window (will be visible on all views)
grab "W-s", :WindowStick

# Toggle zaphod mode of window (will span across all screens)
grab "W-equal", :WindowZaphod

# Raise window
grab "W-r", :WindowRaise

# Lower window
grab "W-d", :WindowLower

# Select next windows
grab "W-h",  :WindowLeft
grab "W-j",  :WindowDown
grab "W-k",    :WindowUp
grab "W-l", :WindowRight

# Kill current window
grab "W-S-k", :WindowKill

# Cycle between given gravities
grab "W-KP_7", [ :top_left,     :top_left66,     :top_left33     ]
grab "W-KP_8", [ :top,          :top66,          :top33          ]
grab "W-KP_9", [ :top_right,    :top_right66,    :top_right33    ]
grab "W-KP_4", [ :left,         :left66,         :left33         ]
grab "W-KP_5", [ :center,       :center66,       :center33       ]
grab "W-KP_6", [ :right,        :right66,        :right33        ]
grab "W-KP_1", [ :bottom_left,  :bottom_left66,  :bottom_left33  ]
grab "W-KP_2", [ :bottom,       :bottom66,       :bottom33       ]
grab "W-KP_3", [ :bottom_right, :bottom_right66, :bottom_right33 ]

# In case no numpad is available e.g. on notebooks
#grab "W-q", [ :top_left,     :top_left66,     :top_left33     ]
#grab "W-w", [ :top,          :top66,          :top33          ]
#grab "W-e", [ :top_right,    :top_right66,    :top_right33    ]
#grab "W-a", [ :left,         :left66,         :left33         ]
#grab "W-s", [ :center,       :center66,       :center33       ]
#grab "W-d", [ :right,        :right66,        :right33        ]
#
# QUERTZ
#grab "W-y", [ :bottom_left,  :bottom_left66,  :bottom_left33  ]
#
# QWERTY
#grab "W-z", [ :bottom_left,  :bottom_left66,  :bottom_left33  ]
#
#grab "W-x", [ :bottom,       :bottom66,       :bottom33       ]
#grab "W-c", [ :bottom_right, :bottom_right66, :bottom_right33 ]

# Exec programs
grab "W-Return", "urxvtc"
grab "W-C-c", "google-chrome"
#grab "W-C-f", "firefox"
grab "W-m", "urxvtc -name ncmpcpp -e ncmpcpp"
grab "W-C-m", "thunderbird"
grab "W-C-f", "thunar"
grab "W-t", "urxvtc -name ranger -e ranger"
grab "W-C-w", "dwb"
grab "W-C-i", "urxvtc -name irssi -e irssi"
grab "W-C-l", "lyx"
# Audio controls

grab "W-Down", "ncmpcpp toggle"
grab "W-Up", "ncmpcpp stop"
grab "W-Left", "ncmpcpp prev"
grab "W-Right", "ncmpcpp next"

grab "XF86AudioRaiseVolume", "amixer -q sset 'Master',0 5%+"
grab "XF86AudioLowerVolume", "amixer -q sset 'Master' 5%-"

# Power control

grab "W-C-S-s", "sudo systemctl reboot"
grab "W-C-S-h", "sudo systemctl halt"
#grab "XF86Sleep", "sudo pm-suspend"
#grab "XF86PowerOff", "sudo halt"

# Run Ruby lambdas
grab "S-F2" do |c|
  puts c.name
end

grab "S-F3" do
  puts Subtlext::VERSION
end
#
# == Launcher for subtle
#

begin
   require "#{ENV["HOME"]}/.config/subtle/launcher/launcher.rb" 
rescue LoadError => error
# Set fonts
   Subtle::Contrib::Launcher.fonts = [
     "xft:montecarlo-11",
     "xft:montecarlo-11" 
   ]
# Set paths
   Subtle::Contrib::Launcher.paths = [ "/usr/bin", "~/bin" , "/sbin" ]
   puts error
end
 
grab "W-C-p" do
   Subtle::Contrib::Launcher.run
end

#
# == Tags
#
# Tags are generally used in subtle for placement of windows. This placement is
# strict, that means that - aside from other tiling window managers - windows
# must have a matching tag to be on a certain view. This also includes that
# windows that are started on a certain view will not automatically be placed
# there.
#
# There are to ways to define a tag:
#
# === Simple
#
# The simple way just needs a name and a regular expression to just handle the
# placement:
#
# Example:
#
#  tag "terms", "terms"
#
# === Extended
#
# Additionally tags can do a lot more then just control the placement - they
# also have properties than can define and control some aspects of a window
# like the default gravity or the default screen per view.
#
# Example:
#
#  tag "terms" do
#    match   "xterm|[u]?rxvt"
#    gravity :center
#  end
#
# === Default
#
# Whenever a window has no tag it will get the default tag and be placed on the
# default view. The default view can either be set by the user with adding the
# default tag to a view by choice or otherwise the first defined view will be
# chosen automatically.
#
# === Properties
#
# [*borderless*] This property enables the borderless mode for tagged clients.
#
#                Example: borderless true
#                Links:    http://subforge.org/projects/subtle/wiki/Tagging#Borderless
#                          http://subforge.org/projects/subtle/wiki/Clients#Borderless
#
# [*fixed*]      This property enables the fixed mode for tagged clients.
#
#                Example: fixed true
#                Links:   http://subforge.org/projects/subtle/wiki/Tagging#Fixed
#                         http://subforge.org/projects/subtle/wiki/Clients#Fixed
#
# [*float*]      This property enables the float mode for tagged clients.
#
#                Example: float true
#                Links:   http://subforge.org/projects/subtle/wiki/Tagging#Float
#                         http://subforge.org/projects/subtle/wiki/Clients#Float
#
# [*full*]       This property enables the fullscreen mode for tagged clients.
#
#                Example: full true
#                Links:   http://subforge.org/projects/subtle/wiki/Tagging#Fullscreen
#                         http://subforge.org/projects/subtle/wiki/Clients#Fullscreen
#
# [*geometry*]   This property sets a certain geometry as well as floating mode
#                to the tagged client, but only on views that have this tag too.
#                It expects an array with x, y, width and height values whereas
#                width and height must be >0.
#
#                Example: geometry [100, 100, 50, 50]
#                Link:    http://subforge.org/projects/subtle/wiki/Tagging#Geometry
#
# [*gravity*]    This property sets a certain to gravity to the tagged client,
#                but only on views that have this tag too.
#
#                Example: gravity :center
#                Link:    http://subforge.org/projects/subtle/wiki/Tagging#Gravity
#
# [*match*]      This property adds matching patterns to a tag, a tag can have
#                more than one. Matching works either via plaintext, regex
#                (see man regex(7)) or window id. Per default tags will only
#                match the WM_NAME and the WM_CLASS portion of a client, this
#                can be changed with following possible values:
#
#                [*:name*]      Match the WM_NAME
#                [*:instance*]  Match the first (instance) part from WM_CLASS
#                [*:class*]     Match the second (class) part from WM_CLASS
#                [*:role*]      Match the window role
#                [*:type*]      Match the window type
#
#                Examples: match instance: "urxvt"
#                          match [:role, :class] => "test"
#                          match "[xa]+term"
#                Link:     http://subforge.org/projects/subtle/wiki/Tagging#Match
#
# [*position*]   Similar to the geometry property, this property just sets the
#                x/y coordinates of the tagged client, but only on views that
#                have this tag, too. It expects an array with x and y values.
#
#                Example: position [ 10, 10 ]
#                Link:    http://subforge.org/projects/subtle/wiki/Tagging#Position
#
# [*resize*]     This property enables the float mode for tagged clients.
#
#                Example: resize true
#                Links:   http://subforge.org/projects/subtle/wiki/Tagging#Resize
#                         http://subforge.org/projects/subtle/wiki/Clients#Resize
#
# [*stick*]      This property enables the float mode for tagged clients.
#
#                Example: stick true
#                Links:   http://subforge.org/projects/subtle/wiki/Tagging#Stick
#                         http://subforge.org/projects/subtle/wiki/Clients#Stick
#
# [*type*]       This property sets the tagged client to be treated as a specific
#                window type though as the window sets the type itself. Following
#                types are possible:
#
#                [*:desktop*]  Treat as desktop window (_NET_WM_WINDOW_TYPE_DESKTOP)
#                              Link: http://subforge.org/projects/subtle/wiki/Clients#Desktop
#                [*:dock*]     Treat as dock window (_NET_WM_WINDOW_TYPE_DOCK)
#                              Link: http://subforge.org/projects/subtle/wiki/Clients#Dock
#                [*:toolbar*]  Treat as toolbar windows (_NET_WM_WINDOW_TYPE_TOOLBAR)
#                              Link: http://subforge.org/projects/subtle/wiki/Clients#Toolbar
#                [*:splash*]   Treat as splash window (_NET_WM_WINDOW_TYPE_SPLASH)
#                              Link: http://subforge.org/projects/subtle/wiki/Clients#Splash
#                [*:dialog*]   Treat as dialog window (_NET_WM_WINDOW_TYPE_DIALOG)
#                              Link: http://subforge.org/projects/subtle/wiki/Clients#Dialog
#
#                Example: type :desktop
#                Link:    http://subforge.org/projects/subtle/wiki/Tagging#Type
#
# [*urgent*]     This property enables the urgent mode for tagged clients.
#
#                Example: stick true
#                Links:   http://subforge.org/projects/subtle/wiki/Tagging#Stick
#                         http://subforge.org/projects/subtle/wiki/Clients#Urgent
#
# [*zaphod*]     This property enables the zaphod mode for tagged clients.
#
#                Example: zaphod true
#                Links:   http://subforge.org/projects/subtle/wiki/Tagging#Zaphod
#                         http://subforge.org/projects/subtle/wiki/Clients#Zaphod
#
#
# === Link
#
# http://subforge.org/projects/subtle/wiki/Tagging
#

# Simple tags
tag "terms" do
   match :instance => "urxvt"
end

tag "browser" do
  match :class => "chromium|google-chrome|firefox|navigator|dwb"
  match :instance => "chromium"
  gravity :center
end


tag "files" do
   match :class => "thunar"
   gravity :top_left
end

tag "mail" do
  match :class => "thunderbird"
end

tag "pics" do
  match "ristretto|feh|gpicview"
  gravity :right
end

tag "docs" do
  match :class => "lyx|lo-[calc|writer|impress]?|epdfview|gvim"
  gravity :center
end

tag "default" do
  gravity :center66
end

tag "video" do
  match :class => "MPlayer|vlc"
  gravity :float
  resize true
end

tag "music" do
  match "ario|deadbeef"
  match :instance => "ncmpcpp", :class => "urxvt"
  gravity :center66
end

tag "IM" do
  match "pidgin|skype"
  gravity :top_right
end

tag "irc" do
  match :instance => "weechat-curses|irssi", :class => "URxvt"
  gravity :left
end

tag "graphic" do
  match :class => "inkscape|Blender"
  match :instance => "Blender|qcad|varicad-view"
  gravity :center
end

tag "dock" do
  match :instance => "avant-window-navigator"
  type :dock
  stick true
end

# Placement
tag "editor" do
  match  "[g]?vim"
  resize true
end

tag "fixed" do
  geometry [ 10, 10, 100, 100 ]
  stick    true
end

tag "resize" do
  match  "sakura|gvim"
  resize true
end

tag "gravity" do
  gravity :center
end

# Modes
#tag "stick" do
#  match "mplayer"
#  float true
#  stick true
#END


tag "float" do
  match "display"
  float true
end

# Gimp
tag "gimp_image" do
  match   :role => "gimp-image-window"
  gravity :gimp_image
end

tag "gimp_toolbox" do
  match   :role => "gimp-toolbox$"
  gravity :gimp_toolbox
end

tag "gimp_dock" do
  match   :role => "gimp-dock"
  gravity :gimp_dock
end
tag "gimp_catch" do
  exclude :role => "gimp-image-window|gimp-toolbox|gimp-dock"
  match "gimp"
  gravity :float
end

#
# == Views
#
# Views are the virtual desktops in subtle, they show all windows that share a
# tag with them. Windows that have no tag will be visible on the default view
# which is the view with the default tag or the first defined view when this
# tag isn't set.
#
# Like tags views can be defined in two ways:
#
# === Simple
#
# The simple way is exactly the same as for tags:
#
# Example:
#
#   view "terms", "terms"
#
# === Extended
#
# The extended way for views is also similar to the tags, but with fewer
# properties.
#
# Example:
#
#  view "terms" do
#    match "terms"
#    icon  "/usr/share/icons/icon.xbm"
#  end
#
# === Properties
#
# [*match*]      This property adds a matching pattern to a view. Matching
#                works either via plaintext or regex (see man regex(7)) and
#                applies to names of tags.
#
#                Example: match "terms"
#
# [*dynamic*]    This property hides unoccupied views, views that display no
#                windows.
#
#                Example: dynamic true
#
# [*icon*]       This property adds an icon in front of the view name. The
#                icon can either be path to an icon or an instance of
#                Subtlext::Icon.
#
#                Example: icon "/usr/share/icons/icon.xbm"
#                         icon Subtlext::Icon.new("/usr/share/icons/icon.xbm")
#
# [*icon_only*]  This property hides the view name from the view buttons, just
#                the icon will be visible.
#
#                Example: icon_only true
#
#
# === Link
#
# http://subforge.org/projects/subtle/wiki/Tagging
#

view "terms" do
 match "terms"
end

view "web" do
  match "browser"
end

view "mail" do
  match "mail"
end

view "files" do
 match "files|pics|default"
end

view "docs" do
  match "docs|pics"
end

view "media" do
  match "video|music|gimp_.*|graphic"
end


#
# == Sublets
#
# Sublets are Ruby scripts that provide data for the panel and can be managed
# with the sur script that comes with subtle.
#
# === Example
#
#  sur install clock
#  sur uninstall clock
#  sur list
#
# === Configuration
#
# All sublets have a set of configuration values that can be changed directly
# from the config of subtle.
#
# There are three default properties, that can be be changed for every sublet:
#
# [*interval*]    Update interval of the sublet
# [*foreground*]  Default foreground color
# [*background*]  Default background color
#
# sur can also give a brief overview about properties:
#
# === Example
#
#   sur config clock
#
# The syntax of the sublet configuration is similar to other configuration
# options in subtle:
#
# === Example
#
#  sublet :clock do
#    interval      30
#    foreground    "#eeeeee"
#    background    "#000000"
#    format_string "%H:%M:%S"
#  end
#
#  === Link
#
# http://subforge.org/projects/subtle/wiki/Sublets
#
sublet :clock do
  interval 30
  format_string "%a %d %B  %H:%M"
end

sublet :title do
  interval 2
end

sublet :views do
  interval 3
end

sublet :wifi do
  interval 3
end

sublet :cpu do
  interval 1
end

sublet :memory do
  interval 3
end

sublet :volume do
  interval 3
end

sublet :mpd do
  format_string "%artist% - %title%"
  show_colors true
  artist_color "#d0d0cc"
  title_color "#d0d0cc"
  track_color "#ffae00"
  id_color  "#c8e7a8"
  album_color "#ffae00"
  track_color "#c8e7a8"
  pause_color "#c8e7a8"
  stop_color "#ffae00"
end

#sublet :weather do
#  interval 3600
#  locale  "en"
#  units   "c"
#  location  "Gent"
#  temp_suffic "°C"
#  sep "|"
#  current_label "Now"
#  day_color "#d0d0cc"
#  temp_color "#d0d0cc"
#  sep_color "#ffae00"
#end
#
# == Hooks
#
# And finally hooks are a way to bind Ruby scripts to a certain event.
#
# Following hooks exist so far:
#
# [*:client_create*]    Called whenever a window is created
# [*:client_configure*] Called whenever a window is configured
# [*:client_focus*]     Called whenever a window gets focus
# [*:client_kill*]      Called whenever a window is killed
#
# [*:tag_create*]       Called whenever a tag is created
# [*:tag_kill*]         Called whenever a tag is killed
#
# [*:view_create*]      Called whenever a view is created
# [*:view_configure*]   Called whenever a view is configured
# [*:view_jump*]        Called whenever the view is switched
# [*:view_kill*]        Called whenever a view is killed
#
# [*:tile*]             Called on whenever tiling would be needed
# [*:reload*]           Called on reload
# [*:start*]            Called on start
# [*:exit*]             Called on exit
#
# === Example
#
# This hook will print the name of the window that gets the focus:
#
#   on :client_focus do |c|
#     puts c.name
#   end
#
# === Link
#
# http://subforge.org/projects/subtle/wiki/Hooks
#

# vim:ts=2:bs=2:sw=2:et:fdm=marker
