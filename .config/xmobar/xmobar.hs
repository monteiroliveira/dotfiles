Config
  { font = "Iosevka Nerd Font Bold 10",
    additionalFonts =
      [ "JetBrains Mono Nerd Font 15",
        "Font Awesome 11"
      ],
    bgColor = "#181818",
    fgColor = "#FFFFFF",
    position = TopSize L 100 27,
    persistent = True,
    lowerOnStart = True,
    overrideRedirect = True,
    sepChar = "%",
    alignSep = "}{",
    commands =
      [ Run Com "echo" ["<fn=1>\xe61f</fn>"] "haskell" 0,
        Run XPropertyLog "_XMONAD_TRAYPAD",
        Run Com "echo" ["<fn=2>\xf487</fn>"] "package" 0,
        Run Com ".local/bin/pacupds" [] "pacupdates" 600,
        Run Com "echo" ["<fn=2>\xebc6</fn>"] "penguin" 0,
        Run Com "echo" ["<fn=2>\xf4bc</fn>"] "cpu_icon" 0,
        Run Com "echo" ["<fn=2>\xf233</fn>"] "men_icon" 0,
        Run Com ".local/bin/kblayout" [] "keylayout" 2,
        Run Com "echo" ["<fn=2>\xf11c</fn>"] "keyboard" 0,
        Run Cpu ["-t", "Cpu: <total>%", "-H", "50"] 20,
        Run Memory ["-t", "Mem: <used>m"] 20,
        Run Date "%A - %m-%d-%Y - (%H:%M)" "date" 30,
        Run XMonadLog
      ],
    template =
      " %XMonadLog%\
      \}%date%{\
      \  %keyboard%  %keylayout%\
      \  %package%  %pacupdates%\
      \  %cpu_icon%  %cpu%\
      \  %men_icon%  %memory%\
      \ %_XMONAD_TRAYPAD%"
  }
