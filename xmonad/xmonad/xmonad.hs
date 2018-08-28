-- default desktop configuration for Fedora

import System.Posix.Env (getEnv)

-- import XMonad
import XMonad hiding (Tall)

import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Spiral
import XMonad.Layout.HintedTile

-- The following would allow creation of sticky windows by splitting a screen into multiple screens.
-- import XMonad.Layout.LayoutScreens


import XMonad.Hooks.ManageDocks
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops

import XMonad.Util.Run
import XMonad.Util.EZConfig

import XMonad.Actions.Submap

import qualified Data.Map as M


myTerminal           = "terminator"

myModMask            = mod4Mask

-- myWorkspaces         = ["Main","Research","Video"] ++ map show [4..9]
-- myWorkspaces         = map show [1..9]
myWorkspaces         = ["Home"] ++ map show [2..8] ++ ["Mine"]

myBorderWidth        = 2
myNormalBorderColor  = "#222222"
myFocusedBorderColor = "#aa0000"

myLayouts   = avoidStruts $
--            tiled 
--            ||| Mirror tiled
            spiral (6/7)
            ||| hintedTile Tall
            ||| hintedTile Wide
            ||| Full
--            ||| threeCol
  where
--    tiled       = Tall nmaster delta ratio
    hintedTile  = HintedTile nmaster delta ratio Center
    threeCol    = ThreeCol nmaster delta ratio
    nmaster     = 1
    ratio       = 1/2
    delta       = 2/100

myManageHook = composeAll
    [
    className =? "float"    --> doFloat
    , manageDocks
    ]



-- myLogHook = fadeInactiveLogHook fadeAmount
--     where
--         fadeAmount = 0.9

-- myLogHook = dynamicLog


--myLogHook = fadeInactiveLogHook 0.9
--    <+> dynamicLogWithPP $ defaultPP
--         { ppOutput = hPutStrLn h }
--            , ppTitle = xmobarColor "green" "" . shorten 50
--            }

 
main = do
    bar_pipe <- spawnPipe "/usr/bin/xmobar ~/.xmonad/xmobar_log"
--  xmproc <- spawnPipe "~/.screenlayout/Docked.sh"
    xmproc <- spawnPipe "/usr/bin/xset -dpms"
    xmproc <- spawnPipe "/usr/bin/xsetroot -cursor_name left_ptr"
    xmproc <- spawnPipe "/usr/bin/xcompmgr"
    xmproc <- spawnPipe "/usr/bin/nitrogen --restore"
    xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmonad/xmobarrc"
    xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmonad/xmobarrc-dynamic"
    xmproc <- spawnPipe "/usr/bin/xfce4-panel"
    xmproc <- spawnPipe "/usr/bin/xscreensaver -no-splash"
    xmproc <- spawnPipe "/usr/bin/xfce4-power-manager"
    xmproc <- spawnPipe "/usr/bin/nm-applet"
--  xmproc <- spawnPipe "/usr/bin/blueman-applet"
    xmproc <- spawnPipe "/usr/bin/blueberry-tray"
    xmproc <- spawnPipe "/usr/bin/pragha -sx"


    xmonad $ ewmh defaultConfig
        { 
        terminal             = myTerminal
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , workspaces         = myWorkspaces
        , modMask            = myModMask
        , layoutHook         = myLayouts
        , manageHook         = myManageHook
--        , manageHook = manageDocks <+> manageHook defaultConfig
--        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , handleEventHook = mconcat
                        [ docksEventHook
                        , handleEventHook defaultConfig ]
        , logHook = fadeInactiveLogHook 0.9 <+> dynamicLogWithPP xmobarPP
                        { 
                        ppOrder                = \(ws:l:_) -> [ws,l]
                        , ppCurrent            = xmobarColor   "yellow"  "" . wrap "[" "]"
                        , ppUrgent             = xmobarColor   "red"     ""
                        , ppVisible            = xmobarColor   "gray"    "" . wrap "(" ")"
--                        , ppHidden             = xmobarColor   "white"    ""
--                        , ppHiddenNoWindows    = xmobarColor   "gray"    ""
                        , ppOutput = hPutStrLn bar_pipe
--                        , ppTitle = xmobarColor "green" "" . shorten 20
                        , ppWsSep              = " "
--                        , ppSep                = ""
                        }
        } 
        `additionalKeys`
        [ ((myModMask,                xK_s   ), spawn "terminator -x ~/bin/c.sh $( awk '!/^#|^$/ {print $1}' ~/bin/clist-expanded.conn | dmenu )")
        , ((myModMask,                xK_z   ), spawn "/usr/bin/xscreensaver-command -lock" )
        , ((myModMask,                xK_v   ), spawn "/usr/bin/vncviewer -PasswordFile ~/.vnc/passwords/${USER}" )
        , ((myModMask,                xK_x   ), spawn "xmonad_start_work.sh ~/bin/workrc" )
        , ((myModMask,                xK_b   ), submap . M.fromList $
            [ ((0, xK_f),     spawn "firefox")
            , ((0, xK_b),     spawn "firefox-beta")
            , ((0, xK_v),     spawn "vivaldi")
            , ((0, xK_c),     spawn "google-chrome")
            ])
        ]




