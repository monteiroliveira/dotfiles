import XMonad
import XMonad.Actions.GridSelect
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks (ToggleStruts (..), avoidStruts, docks, manageDocks)
import XMonad.Hooks.ManageHelpers (doFullFloat, isFullscreen)
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.WindowSwallowing
import XMonad.Layout.LayoutModifier
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Prompt
import XMonad.Prompt.Shell (shellPrompt)
import XMonad.Util.EZConfig (additionalKeysP, mkKeymap)
import XMonad.Util.Hacks (javaHack, trayerAboveXmobarEventHook, trayerPaddingXmobarEventHook, windowedFullscreenFixEventHook)
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce

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

myTabTheme =
  def
    { fontName = "xft:Mononoki Nerd Font:size=11:antialias=true:hinting=true",
      activeColor = "#46d9ff",
      inactiveColor = "#202328",
      activeBorderColor = "#46d9ff",
      inactiveBorderColor = "#282c34",
      activeTextColor = "#282c34",
      inactiveTextColor = "#dfdfdf"
    }

tall =
  renamed [Replace "tall"] $
    smartBorders $
      mySpacing 8 $
        Tall 1 (3 / 100) (1 / 2)

bTall =
  renamed [Replace "bTall"] $
    smartBorders $
      Tall 1 (3 / 100) (1 / 2)

floats =
  renamed [Replace "floats"] $
    smartBorders $
      simplestFloat

full =
  renamed [Replace "full"] $
    smartBorders $
      Full

tabs =
  renamed [Replace "tabs"] $
    tabbed shrinkText myTabTheme

myLayoutHook = avoidStruts $ tall ||| bTall ||| floats ||| full ||| tabs

myManageHook :: ManageHook
myManageHook =
  composeAll
    [ className =? "dialog" --> doFloat,
      className =? "toolbar" --> doFloat,
      className =? "confirm" --> doFloat,
      isFullscreen --> doFullFloat
    ]

myXmobarPP :: PP
myXmobarPP =
  def
    { ppCurrent = xmobarColor "#ef50f2" "" . wrap "[" "]",
      ppVisible = xmobarColor "#98be65" "",
      ppHidden = xmobarColor "#82aaff" "" . wrap "*" "",
      -- ppHiddenNoWindows = xmobarColor "#dfdfdf" "",
      ppTitle = xmobarColor "#dfdfdf" "" . shorten 75,
      ppSep = "   "
    }

myStartupHook :: X ()
myStartupHook = do
  spawn "killall trayer"
  spawnOnce "nm-applet"
  spawnOnce "picom"
  spawnOnce "volumeicon"
  spawnOnce "dunst"
  spawnOnce "nitrogen --restore &"
  spawn
    ( "sleep 2 && \
      \ trayer --edge top --align right --padding 6 -l \
      \--widthtype request --SetDockType true --SetPartialStrut true --expand true \
      \--monitor 1 --transparent true --alpha 0 --tint 0x282c34 --height 23"
    )

myWorkspaces = [" I ", " II ", " III ", " IV ", " V ", " VI ", " VII ", " VIII ", " IX "]

myShowWName :: SWNConfig
myShowWName =
  def
    { swn_font = "xft:Ubuntu:bold:size=60:antialias=true:hinting=true",
      swn_fade = 1.0,
      swn_bgcolor = "#1c1f24",
      swn_color = "#ffffff"
    }

myPromptConfig :: XPConfig
myPromptConfig =
  def
    { font = "xft:Mononoki Nerd Font:size=11:antialias=true:hinting=true",
      bgColor = "#292d3e",
      fgColor = "#d0d0d0",
      bgHLight = "#c792ea",
      fgHLight = "#000000",
      alwaysHighlight = True,
      promptBorderWidth = 0,
      height = 24,
      position = Bottom
    }

spawnSelected' :: [(String, String)] -> X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
  where
    conf =
      def
        { gs_cellheight = 40,
          gs_cellwidth = 180,
          gs_cellpadding = 6,
          gs_originFractX = 0.5,
          gs_originFractY = 0.5,
          gs_font = "xft:Mononoki Nerd Font:size=11:antialias=true:hinting=true"
        }

myKeys :: [(String, X ())]
myKeys =
  [ ("M-C-r", spawn "xmonad --recompile"),
    ("M-S-r", spawn "xmonad --restart"),
    ("M-S-<Return>", shellPrompt myPromptConfig),
    ("M-<Return>", spawn myTerminal),
    ("M-S-b", sendMessage ToggleStruts),
    ( "M-S-g",
      spawnSelected'
        [ ("Alacritty", "alacritty"),
          ("Gimp", "gimp"),
          ("Emacs", "emacs"),
          ("Vlc", "vlc"),
          ("Virt Manager", "virt-manager"),
          ("Nvidia", "nvidia-settings")
        ]
    )
  ]

mySwallowEventHook = swallowEventHook (className =? "Alacritty") (return True)

myHandleEventHook =
  handleEventHook def
    <> trayerPaddingXmobarEventHook
    <> trayerAboveXmobarEventHook
    <> windowedFullscreenFixEventHook
    <> mySwallowEventHook

xmobar0 :: StatusBarConfig
xmobar0 = statusBarProp "xmobar -x 0 ~/.config/xmobar/xmobarrc" $ pure myXmobarPP

xmobar1 :: StatusBarConfig
xmobar1 = statusBarProp "xmobar -x 1 ~/.config/xmobar/xmobarrc" $ pure myXmobarPP

xmobar2 :: StatusBarConfig
xmobar2 = statusBarProp "xmobar -x 2 ~/.config/xmobar/xmobarrc" $ pure myXmobarPP

main :: IO ()
main = do
  xmonad $
    withSB (xmobar0 <> xmobar1 <> xmobar2) $
      ewmhFullscreen $
        ewmh . docks $
          javaHack $
            def
              { modMask = myModMask,
                terminal = myTerminal,
                layoutHook = showWName' myShowWName $ myLayoutHook,
                startupHook = myStartupHook,
                manageHook = myManageHook <+> manageDocks,
                workspaces = myWorkspaces,
                borderWidth = myBorderWidth,
                normalBorderColor = myNormColor,
                focusedBorderColor = myFocusColor,
                handleEventHook = myHandleEventHook
              }
              `additionalKeysP` myKeys
