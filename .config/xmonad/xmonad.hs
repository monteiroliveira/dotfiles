import qualified Data.Map as M
import Data.Tree
import System.IO
import XMonad
import XMonad.Actions.Navigation2D
import XMonad.Actions.TiledWindowDragging
import XMonad.Actions.TreeSelect
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks (ToggleStruts (..), avoidStruts, docks, manageDocks)
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.WindowSwallowing
import XMonad.Layout.Accordion
import XMonad.Layout.DraggingVisualizer
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
import XMonad.Util.EZConfig (additionalKeysP, additionalMouseBindings, mkKeymap)
import XMonad.Util.Hacks (fixSteamFlicker, javaHack, trayerAboveXmobarEventHook, trayerPaddingXmobarEventHook, windowedFullscreenFixEventHook)
import XMonad.Util.Loggers
import XMonad.Util.Run
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

myTreeSelectNavigation =
  M.fromList
    [ ((controlMask, xK_g), cancel),
      ((controlMask, xK_p), movePrev),
      ((controlMask, xK_n), moveNext),
      ((controlMask, xK_b), moveParent),
      ((controlMask, xK_f), moveChild),
      ((controlMask, xK_o), moveHistBack),
      ((controlMask, xK_i), moveHistForward)
    ]

myTreeSelectConfig =
  TSConfig
    { ts_hidechildren = True,
      ts_background = 0xdd181818,
      ts_font = "xft:Mononoki Nerd Font:size=12:antialias=true:hinting=true",
      ts_node = (0xffd0d0d0, 0xff282828),
      ts_nodealt = (0xffd0d0d0, 0xff181818),
      ts_highlight = (0xffffffff, 0xff755999),
      ts_extra = 0xffd0d0d0,
      ts_node_width = 200,
      ts_node_height = 30,
      ts_originX = 0,
      ts_originY = 0,
      ts_indent = 80,
      ts_navigate = myTreeSelectNavigation <+> defaultNavigation
    }

myTreeSelectForest :: Forest (TSNode (X ()))
myTreeSelectForest =
  [ Node
      (TSNode "System Options >>" "Default System Options" (return ()))
      [ Node (TSNode "Shutdown" "PowerOff the system" (spawn "poweroff")) [],
        Node (TSNode "Reboot" "Reboot the system" (spawn "reboot")) [],
        Node (TSNode "Screen Lock" "Lock the computer screen" (spawn "slock")) [],
        Node (TSNode "Logoff" "Terminate user session" (spawn "loginctl terminate-user $(whoami)")) []
      ]
  ]

tall =
  renamed [Replace "tall"] $
    draggingVisualizer $
      smartBorders $
        windowNavigation $
          mySpacing 8 $
            ResizableTall 1 (3 / 100) (1 / 2) []

bTall =
  renamed [Replace "bTall"] $
    draggingVisualizer $
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
        tall ||| bTall ||| floats ||| full ||| tabs ||| Accordion

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
    { ppCurrent = xmobarColor "#3888BA" "" . wrap "{" "}",
      ppVisible = xmobarColor "#BA8438" "",
      ppHidden = xmobarColor "#9E95C7" "" . wrap "*" "",
      ppTitle = xmobarColor "#FFFFFF" "" . shorten 75,
      ppSep = " : "
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
  setWMName "LG3D"

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

myKeyBindings :: [(String, X ())]
myKeyBindings =
  [ ("M-C-r", spawn "xmonad --recompile"),
    ("M-S-r", spawn "xmonad --restart"),
    ("M-<Return>", spawn myTerminal),
    ("M1-S-c b", sendMessage ToggleStruts),
    ("M1-S-c f", sendMessage ToggleLayout),
    ("M-S-<Return>", shellPrompt myPromptConfig),
    ("M1-S-<Return>", spawn "rofi -show drun -show-icons"),
    ("M-S-t", treeSelect)
  ]
  where
    treeSelect = treeselectAction myTreeSelectConfig myTreeSelectForest

myMouseBindings :: [((ButtonMask, Button), Window -> X ())]
myMouseBindings =
  [((myModMask .|. shiftMask, button1), dragWindow)]

mySwallowEventHook = swallowEventHook (className =? "Alacritty") (return True)

my2DNavigations =
  navigation2DP
    def
    ("w", "a", "s", "d")
    [ ("M-", windowGo),
      ("M-S-", windowSwap),
      ("M-C-", windowToScreen)
    ]
    False

myHandleEventHook =
  handleEventHook def
    <> trayerPaddingXmobarEventHook
    <> trayerAboveXmobarEventHook
    <> windowedFullscreenFixEventHook
    <> fixSteamFlicker
    <> mySwallowEventHook

main :: IO ()
main = do
  xmonad $
    withSB (xmobar0 <> xmobar1 <> xmobar2) $
      my2DNavigations $
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
                `additionalMouseBindings` myMouseBindings
                `additionalKeysP` myKeyBindings
  where
    xmobar0 = statusBarProp "xmobar -x 0 ~/.config/xmobar/xmobar.hs" $ pure myXmobarPP
    xmobar1 = statusBarProp "xmobar -x 1 ~/.config/xmobar/xmobar.hs" $ pure myXmobarPP
    xmobar2 = statusBarProp "xmobar -x 2 ~/.config/xmobar/xmobar.hs" $ pure myXmobarPP
