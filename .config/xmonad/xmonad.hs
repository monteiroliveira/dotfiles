-- Main Imports
import XMonad

-- Utils
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Ungrab
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce

-- Hooks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

-- Layout
import XMonad.Layout.ShowWName

myModMask :: KeyMask
myModMask = mod4Mask

myTerminal :: String
myTerminal = "alacritty"

myBorderWidth :: Dimension
myBorderWidth = 2

myNormColor :: String
myNormColor = "#282c34"

myFocusColor :: String
myFocusColor = "#46d9ff"

myLayoutHook = tiled ||| Mirror tiled ||| Full
  where
    tiled   = Tall nmaster delta ratio
    nmaster = 1      -- Default number of windows in the master pane
    ratio   = 1/2    -- Default proportion of screen occupied by master pane
    delta   = 3/100  -- Percent of screen to increment by when resizing panes

myXmobarPP :: PP
myXmobarPP = def

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "lxsession"
  spawnOnce "picom"
  spawnOnce "nm-applet"
  spawnOnce "cbatticon"
  spawnOnce "volumeicon"
  spawnOnce "dunst"
  spawnOnce "nitrogen --restore &"
  spawnOnce "trayer --edge bottom --align right --widthtype request --SetDockType true --padding 6 --SetPartialStrut true --expand true --monitor eDP-1 --transparent true --alpha 0 --tint 0x282c34 --height 22"

myWorkspaces = ["1:www", "2:dev", "3:doc", "4:sys", "5:mus", "6:vid", "7:gfx", "8:afk", "9:aux"]

myShowWName :: SWNConfig
myShowWName = def
  { swn_font    = "xft:Ubuntu:bold:size=60"
  , swn_fade    = 1.0
  , swn_bgcolor = "#1c1f24"
  , swn_color   = "#ffffff" }
  
main :: IO ()
main = do xmonad $ ewmhFullscreen $ ewmh $ withEasySB (statusBarProp "xmobar ~/.config/xmobar/xmobarrc" (pure myXmobarPP)) defToggleStrutsKey $ def
            { modMask     = myModMask
            , terminal    = myTerminal
            , layoutHook  = showWName' myShowWName $ myLayoutHook
            , startupHook = myStartupHook
            , workspaces = myWorkspaces
            , borderWidth = myBorderWidth
            , normalBorderColor = myNormColor
            , focusedBorderColor = myFocusColor
            }
            `additionalKeysP`
            [ ("M-S-d", spawn "dmenu_run") ]
