-- Imports
import XMonad
import System.Exit
import XMonad.Util.Run (safeSpawn)
import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import Data.List
-- layouts
import XMonad.Layout.Spacing 
import XMonad.Layout.Grid
--import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.MultiToggle
-- hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
-- var
import System.Exit

-- Main process
main :: IO()
main = xmonad =<< statusBar myBar myPP toggleStrutsKey (ewmh $ myConfig)

-- Configs
myConfig = defaultConfig { modMask = myModMask,
                          terminal = myTerminal,
                          workspaces = myWorkspaces,
                          layoutHook = myLayoutHook,
                          manageHook = myManageHook,
                          handleEventHook = myEventHook,
                          borderWidth = myBorderWidth,
                          normalBorderColor = myNormalBorderColor,
                          focusedBorderColor = myFocusedBorderColor,
                          keys = myKeys
                          }

-- Modkey
myModMask = mod4Mask
-- Terminal
myTerminal = "urxvtc"

-- Workspaces
myws1 = "\xf120"
myws2 = "\xf269"
myws3 = "\xf121"
myws4 = "\xf07b"
myws5 = "\xf099"
myws6 = "\xf1bc"
myws7 = "\xf11b"

myWorkspaces :: [String]
myWorkspaces = [myws1, myws2, myws3, myws4, myws5, myws6 , myws7 ]

-- Layouts
-- No spacing
myLayoutHook = avoidStruts $ smartBorders (tall ||| GridRatio (4/3) ||| Full )
                   where tall = Tall 1 (3/100) (1/2) 

-- with spacing
{-myLayoutHook = (spacing 10 $ avoidStruts (tall ||| GridRatio (4/3) ||| Full )) ||| smartBorders Full-}
                   {-where tall = Tall 1 (3/100) (1/2) -}

-- fullscreen layout
--myFullscreen = (fullscreenFloat . fullscreenFull) (smartBorders Full)

-- Mangehooks
myManageHook = composeAll [ isFullscreen            --> doFullFloat,
                         className =? "Firefox" --> doShift myws2,
                         className =? "Chromium" --> doShift myws2,
                         className =? "Pcmanfm" --> doShift myws4,
                         -- manage Gimp toolbox windows
                         className =? "Gimp"  --> doShift myws4, -- may be "Gimp" or "Gimp-2.4" instead
                         (className =? "Gimp" <&&> fmap ("tool" `isSuffixOf`) role) --> doFloat,
                         className =? "Filezilla" --> doShift myws4,
                         className =? "Blender" --> doShift myws4,
                         className =? "Inkscape" --> doShift myws4,
                         className =? "libreoffice" --> doShift myws4,
                         className =? "libreoffice-startcenter" --> doShift myws4,
                         className =? "Transmission-gtk" --> doShift myws4,
                         className =? "MPlayer" --> doFloat,
                         className =? "MPlayer" --> doShift myws4,
                         className =? "mpv" --> doFloat,
                         className =? "mpv" --> doShift myws4,
                         className =? "Steam" --> doShift myws7,
                         -- cli apps
                         appName =? "vim" --> doShift myws3,
                         appName =? "ranger" --> doShift myws4,
                         appName =? "mutt" --> doShift myws4,
                         appName =? "irssi" --> doShift myws5,
                         appName =? "rainbowstream" --> doShift myws5,
                         appName =? "ncmpcpp" --> doShift myws6,
                         manageDocks
--                         fullscreenManageHook
                       ]
                       where role = stringProperty "WM_WINDOW_ROLE"

-- Event Hooks
myEventHook = docksEventHook <+> fullscreenEventHook

-- Looks
myBorderWidth = 4
myNormalBorderColor = "#2b303b"
myFocusedBorderColor = "#bf616a"

-- Xmonbar
myBar = "xmobar"
myPP = xmobarPP { ppCurrent = xmobarColor "#bf616a" ""
                     , ppHidden = xmobarColor "#c0c5ce" ""
                     , ppHiddenNoWindows = xmobarColor "#4f5b66" ""
                     , ppUrgent = xmobarColor "#a3be8c" ""
                     , ppLayout = xmobarColor "#4f5b66" ""
                     , ppTitle =  xmobarColor "#c0c5ce" "" . shorten 80
                     , ppSep = xmobarColor "#4f5b66" "" "  "
                     }

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- Keyboard shortcuts
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- launching apps
    [ ((modMask .|. controlMask, xK_Return), safeSpawn (XMonad.terminal conf) []) 
    , ((modMask,                 xK_p     ), safeSpawn "rofi" ["-show", "run"]) 
    , ((modMask,                 xK_o     ), safeSpawn "rofi" ["-show", "window"]) 
    , ((modMask .|. controlMask, xK_c     ), safeSpawn "firefox" [])
    , ((modMask .|. controlMask, xK_b     ), safeSpawn "chromium" [])
    , ((modMask .|. controlMask, xK_p     ), safeSpawn "pcmanfm" [])
    -- launching cli apps
    , ((modMask .|. controlMask, xK_n     ), safeSpawn "urxvtc" ["-name", "ncmpcpp", "-e", "ncmpcpp"])
    , ((modMask .|. controlMask, xK_f     ), safeSpawn "urxvtc" ["-name", "ranger", "-e", "ranger"])
    , ((modMask .|. controlMask, xK_i     ), safeSpawn "urxvtc" ["-name", "irssi", "-e", "irssi"])
    , ((modMask .|. controlMask, xK_r     ), safeSpawn "urxvtc" ["-name", "rainbowstream", "-e", "rainbowstream"])
    , ((modMask .|. controlMask, xK_v     ), safeSpawn "urxvtc" ["-name", "vim", "-e", "nvim"])
    , ((modMask .|. controlMask, xK_m     ), safeSpawn "urxvtc" ["-name", "mutt", "-e", "mutt"])
    -- Kill windows
    , ((modMask .|. controlMask, xK_w     ), kill)
    -- lock screen
    , ((modMask .|. controlMask, xK_Delete), safeSpawn "i3lock-fancy" ["-p"])
    -- screenshot
    , ((0, xK_Print                       ), safeSpawn "scrot" [])
    -- multimedia
    , ((0, xF86XK_AudioRaiseVolume      ), safeSpawn "pamixer" ["-i", "5"])
    , ((0, xF86XK_AudioLowerVolume      ), safeSpawn "pamixer" ["-d", "5"])
    , ((modMask,                 xK_Down), safeSpawn "mpc" ["toggle"])
    , ((modMask,                 xK_Up),   safeSpawn "mpc" ["stop"])
    , ((modMask,                 xK_Left), safeSpawn "mpc" ["prev"])
    , ((modMask,                 xK_Right), safeSpawn "mpc" ["next"])
    -- layouts
    , ((modMask,               xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- floating layer stuff
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink)

    -- refresh
    , ((modMask,               xK_n     ), refresh)

    -- focus
    , ((modMask,               xK_Tab   ), windows W.focusDown)
    , ((modMask,               xK_j     ), windows W.focusDown)
    , ((modMask,               xK_k     ), windows W.focusUp)
    , ((modMask,               xK_m     ), windows W.focusMaster)

    -- swapping
    , ((modMask,               xK_Return), windows W.shiftMaster)
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- increase or decrease number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))
    , ((modMask              , xK_semicolon), sendMessage (IncMasterN (-1)))

    -- resizing
    , ((modMask,               xK_h     ), sendMessage Shrink)
    , ((modMask,               xK_l     ), sendMessage Expand)
    -- quit, or restart
    , ((modMask .|. shiftMask, xK_Escape  ), io (exitWith ExitSuccess))
    , ((modMask              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (workspaces conf)[ xK_ampersand
                                         , xK_eacute
                                         , xK_quotedbl
                                         , xK_apostrophe
                                         , xK_parenleft
                                         , xK_section -- 6 0xa7
                                         , xK_egrave
                                         , xK_exclam  -- 8 0x21
                                         , xK_ccedilla
                                         , xK_agrave
                                         , xK_parenright
                                         ] ,
          (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

