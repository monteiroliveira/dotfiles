import XMonad
import XMonad.Actions.GridSelect
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks (ToggleStruts (..), avoidStruts, docks, manageDocks)
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.WindowSwallowing
import XMonad.Layout.LayoutModifier
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Renamed
import XMonad.Layout.ResizableTile
import XMonad.Layout.ShowWName
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Layout.ToggleLayouts (ToggleLayout (..), toggleLayouts)
import XMonad.Layout.WindowArranger (windowArrange)
import XMonad.Layout.WindowNavigation
import XMonad.Prompt
import XMonad.Prompt.Shell (shellPrompt)
import XMonad.Util.EZConfig (additionalKeysP, mkNamedKeymap)
import XMonad.Util.Hacks (javaHack, trayerAboveXmobarEventHook, trayerPaddingXmobarEventHook, windowedFullscreenFixEventHook)
import XMonad.Util.Loggers
import XMonad.Util.NamedActions
import XMonad.Util.SpawnOnce

myModMask :: KeyMask
myModMask = mod4Mask

myTerminal :: String
myTerminal = "alacritty"

myBorderWidth :: Dimension
myBorderWidth = 3

myNormColor :: String
myNormColor = "#282C34"

myFocusColor :: String
myFocusColor = "#3888BA"

mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

myTabTheme =
  def
    { fontName = "xft:Mononoki Nerd Font:size=11:antialias=true:hinting=true",
      activeColor = "#3888BA",
      inactiveColor = "#202328",
      activeBorderColor = "#3888BA",
      inactiveBorderColor = "#282c34",
      activeTextColor = "#282c34",
      inactiveTextColor = "#FFFFFF"
    }

tall =
  renamed [Replace "tall"] $
    smartBorders $
      windowNavigation $
        mySpacing 8 $
          ResizableTall 1 (3 / 100) (1 / 2) []

bTall =
  renamed [Replace "bTall"] $
    smartBorders $
      windowNavigation $
        ResizableTall 1 (3 / 100) (1 / 2) []

floats =
  renamed [Replace "floats"] $
    smartBorders $
      windowNavigation $
        simplestFloat

full =
  renamed [Replace "full"] $
    smartBorders $
      windowNavigation $
        Full

tabs =
  renamed [Replace "tabs"] $
    windowNavigation $
      tabbed shrinkText myTabTheme

myLayoutHook =
  avoidStruts $
    windowArrange $
      toggleLayouts floats $
        tall ||| bTall ||| floats ||| full ||| tabs

myWorkspaces :: [String]
myWorkspaces = [" I ", " II ", " III ", " IV ", " V ", " VI ", " VII ", " VIII ", " IX "]

myManageHook :: ManageHook
myManageHook =
  composeAll
    [ className =? "dialog" --> doFloat,
      className =? "toolbar" --> doFloat,
      className =? "confirm" --> doFloat,
      className =? "file_progress" --> doFloat,
      className =? "dialog" --> doFloat,
      className =? "download" --> doFloat,
      className =? "error" --> doFloat,
      className =? "notification" --> doFloat,
      className =? "discord" --> doShift (myWorkspaces !! 8),
      className =? "Signal" --> doShift (myWorkspaces !! 8),
      className =? "firefox" --> doShift (myWorkspaces !! 0),
      isFullscreen --> doFullFloat
    ]

myXmobarPP :: PP
myXmobarPP =
  def
    { ppCurrent = xmobarColor "#3888BA" "" . wrap "{ " " }",
      ppVisible = xmobarColor "#BA8438" "",
      ppHidden = xmobarColor "#9E95C7" "" . wrap "*" "",
      -- ppHiddenNoWindows = xmobarColor "#dfdfdf" "",
      ppTitle = xmobarColor "#FFFFFF" "" . shorten 75,
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
      \--monitor 1 --transparent true --alpha 0 --tint 0x181818 --height 27"
    )

myShowWName :: SWNConfig
myShowWName =
  def
    { swn_font = "xft:Ubuntu:bold:size=60:antialias=true:hinting=true",
      swn_fade = 1.0,
      swn_bgcolor = "#181818",
      swn_color = "#ffffff"
    }

myPromptConfig :: XPConfig
myPromptConfig =
  def
    { font = "xft:Mononoki Nerd Font:size=11:antialias=true:hinting=true",
      bgColor = "#181818",
      fgColor = "#d0d0d0",
      bgHLight = "#9E95C7",
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
          gs_font = "xft:Mononoki Nerd Font:size=12:antialias=true:hinting=true"
        }

gsDefaults :: [(String, String)]
gsDefaults =
  [ ("Alacritty", "alacritty"),
    ("Gimp", "gimp"),
    ("Emacs", "emacs"),
    ("Vlc", "vlc"),
    ("Virt Manager", "virt-manager"),
    ("Nvidia", "nvidia-settings"),
    ("Thunar", "thunar"),
    ("Discord", "discord"),
    ("Signal", "signal-desktop")
  ]

myKeys :: XConfig l -> [((KeyMask, KeySym), NamedAction)]
myKeys c =
  let subKeys str ks = (subtitle str :) $ mkNamedKeymap c ks
   in subKeys
        "Xmonad Essentials"
        [ ("M-C-r", addName "Recompile Xmonad" $ spawn "xmonad --recompile"),
          ("M-S-r", addName "Restart Xmonad" $ spawn "xmonad --restart"),
          ("M-S-<Return>", addName "Spawn Prompt" $ shellPrompt myPromptConfig),
          ("M-<Return>", addName "Spawn Terminal" $ spawn myTerminal),
          ("M1-S-<Return>", addName "Spawn Rofi" $ spawn "rofi -show drun -show-icons"),
          ("M-c b", sendMessage' ToggleStruts),
          ("M-c f", sendMessage' ToggleLayout)
        ]
        ^++^ subKeys
          "Grid Select"
          [ ("M-S-g", addName "Default GridSelect" $ spawnSelected' gsDefaults)
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
    addDescrKeys ((mod4Mask, xK_F1), xMessage) myKeys $
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
