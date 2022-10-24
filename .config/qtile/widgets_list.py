from libqtile import qtile
from libqtile import widget
from libqtile.lazy import lazy
from unicode_symbols import left_arrow, right_arrow
import os
import subprocess

def init_widget_list():
    widget_list = [
        widget.Sep(
            linewidth=0,
            padding=6,
            background=["#9600fa"]
        ),
        widget.TextBox(
            text="",
            fontsize=26,
            padding=0,
            background=["#9600fa"]
        ),
        right_arrow(["#282c34"],["#9600fa"]),
        widget.Sep(
            padding=2,
            linewidth=0
        ),
        widget.GroupBox(
            highlight_method="line",
            highlight_color=["#282c34", "#282c34"],
            this_current_screen_border=["#b48bf0"],
            borderwidth=3,
            inactive=["#ffffff"],
            active=["#b48bf0"],
            background=["#282c34"],
            #fontsize=12,
            disable_drag=True,
        ),
        widget.Sep(
            padding=12,
            linewidth=1
        ),
        widget.Prompt(),
        widget.WindowName(font="mononoki nerd font bold",),
        #widget.TaskList(border=["#282c34"], padding_y=1, spacing=1, icon_size=15),
        #widget.WindowTabs(),
        #left_arrow(["#9600fa"],["#282c34"]),
        widget.Systray(
            padding=6,
            background=["#282c34"],
        ),
        widget.Sep(
            padding=6,
            linewidth=0,
        ),
        #left_arrow(["#282c34"],["#51afef"]),
        left_arrow(["#282c34"],["#3f4654"]),
        widget.Chord(
            #chords_colors={
            #    "launch": ("#ff0000", "#ffffff"),
            #},
            #name_transform=lambda name: name.upper(),
            fmt="Mode: {}",
            background=["#3f4654"],
            padding=6,
        ),
        left_arrow(["#3f4654"],["#282c34"]),
        left_arrow(["#282c34"],["#0069c0"]),
        widget.TextBox(
            text="",
            fontsize=20,
            padding=2,
            background=["#0069c0"]
        ),
        widget.GenPollText(
            func=lambda: subprocess.check_output(os.path.expanduser("~/scripts/get_kernel_version.sh")).decode("utf-8"),
            background=["#0069c0"],
            padding=6
        ),
        left_arrow(["#0069c0"],["#9600fa"]),
        widget.TextBox(
            text="",
            fontsize=20,
            padding=4,
            background=["#9600fa"]
        ),
        widget.ThermalSensor(
            fmt="Temp: {}",
            padding=6,
            background=["#9600fa"]
        ),
        left_arrow(["#9600fa"],["#0069c0"]),
        widget.TextBox(
            text="",
            fontsize=17,
            padding=4,
            background=["#0069c0"]
        ),
        widget.Memory(
            fmt="Mem:{}",
            padding=6,
            background=["#0069c0"],
            mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn('alacritty -e htop')}
        ),
        left_arrow(["#0069c0"],["#9600fa"]),
        widget.Sep(
            padding=2,
            linewidth=0,
            background=["#9600fa"]
        ),
        widget.TextBox(
            text="↻",
            fontsize=16,
            background=["#9600fa"]
        ),
        widget.CheckUpdates(
            display_format="Updates: {updates}",
            no_update_string="Updates: N/A",
            distro="Arch_checkupdates",
            update_interval=60,
            padding=6,
            background=["#9600fa"],
            mouse_callbacks={'Button1': lambda: qtile.cmd_spawn('alacritty -e sudo pacman -Syu')}
        ),
        widget.Sep(
            linewidth=0,
            padding=2,
            background=["#9600fa"]
        ),
        left_arrow(["#9600fa"],["#0069c0"]),
        widget.TextBox(
            text="",
            fontsize=20,
            padding=4,
            background=["#0069c0"],
        ),
        widget.Clock(
            format="%A - %m/%d/%Y - (%I:%M) %p ",
            padding=4,
            background=["#0069c0"],
        ),
        widget.Sep(
            linewidth=0,
            padding=0,
            background=["#0069c0"]
        ),
        left_arrow(["#0069c0"],["#3f4654"]),
        left_arrow(["#3f4654"],["#282c34"]),
        widget.CurrentLayoutIcon(
            #custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
            padding=2,
            scale = 0.7
        ),
        widget.Sep(
            linewidth=0,
            padding=2
        ),
    ]
    return widget_list
