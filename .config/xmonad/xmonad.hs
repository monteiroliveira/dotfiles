-- Main Imports
import XMonad

-- Utils
import XMonad.Util.EZConfig (additionalKeysP, mkKeymap)
import XMonad.Util.Ungrab
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce

-- Hooks
import XMonad.Hooks.ManageDocks (avoidStruts, docks, manageDocks, ToggleStruts(..))
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

-- Layout
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.Spacing
import XMonad.Layout.LayoutModifier
import XMonad.Layout.NoBorders (smartBorders)

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

mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

tall = renamed [Replace "tall"]
       $ smartBorders
       $ mySpacing 8
       $ Tall 1 (3/100) (1/2)
bTall = renamed [Replace "bTall"]
        $ smartBorders
        $ Tall 1 (3/100) (1/2)
full = renamed [Replace "full"]
       $ smartBorders
       $ Full

myLayoutHook = avoidStruts $ tall ||| bTall ||| full

myXmobarPP :: PP
myXmobarPP = def
  { ppCurrent          = xmobarColor "#98be65" "" . wrap "[" "]"
  , ppVisible          = xmobarColor "#98be65" ""
  , ppHidden           = xmobarColor "#82aaff" "" . wrap "*" ""
  , ppHiddenNoWindows  = xmobarColor "#ef50f2" ""
  , ppSep              = " : "
  , ppTitle            = xmobarColor "#dfdfdf" "" }

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "lxsession"
  spawnOnce "picom"
  spawnOnce "nm-applet"
  spawnOnce "cbatticon"
  spawnOnce "volumeicon"
  spawnOnce "dunst"
  spawnOnce "nitrogen --restore &"
  spawnOnce "trayer --edge bottom --align right --widthtype request --SetDockType true --padding 7 --SetPartialStrut true --expand true --monitor eDP-1 --transparent true --alpha 0 --tint 0x282c34 --height 22"

myWorkspaces = [" I ", " II ", " III ", " IV ", " V ", " VI ", " VII ", " VIII ", " IX "]

myShowWName :: SWNConfig
myShowWName = def
  { swn_font    = "xft:Ubuntu:bold:size=60"
  , swn_fade    = 1.0
  , swn_bgcolor = "#1c1f24"
  , swn_color   = "#ffffff" }

myKeys :: [(String, X ())]
myKeys =
  [ ("M-d r", spawn "dm-run")
  , ("M-d l", spawn "dm-logout")
  ]

xmobar0 :: StatusBarConfig
xmobar0 = statusBarProp "xmobar ~/.config/xmobar/xmobarrc" $ pure myXmobarPP
  
main :: IO ()
main = do xmonad $ withSB xmobar0 $ ewmhFullscreen $ ewmh . docks $ def
            { modMask            = myModMask
            , terminal           = myTerminal
            , layoutHook         = showWName' myShowWName $ myLayoutHook
            , startupHook        = myStartupHook
            , workspaces         = myWorkspaces
            , borderWidth        = myBorderWidth
            , normalBorderColor  = myNormColor
            , focusedBorderColor = myFocusColor
            } `additionalKeysP` myKeys
