from libqtile import qtile
from libqtile import widget
from libqtile.lazy import lazy

import os
import subprocess

from unicode_symbols import left_arrow, right_arrow
from themes.doom_one import color

def init_widget_list():
    widget_list = [
        widget.Sep(
            linewidth=0,
            padding=6,
            background=color['magenta']
        ),
        widget.TextBox(
            text="",
            fontsize=26,
            padding=0,
            background=color['magenta']
        ),
        right_arrow(color['bg'], color['magenta']),
        widget.Sep(
            padding=2,
            linewidth=0
        ),
        widget.GroupBox(
            highlight_method="line",
            highlight_color=color['bg'],
            this_current_screen_border=color['light_magenta'],
            borderwidth=3,
            inactive=color['white'],
            active=color['light_magenta'],
            background=color['bg'],
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
            background=color['bg'],
        ),
        widget.Sep(
            padding=6,
            linewidth=0,
        ),
        #left_arrow(["#282c34"],["#51afef"]),
        left_arrow(color['bg'],color['gray']),
        widget.Chord(
            #chords_colors={
            #    "launch": ("#ff0000", "#ffffff"),
            #},
            #name_transform=lambda name: name.upper(),
            fmt="Mode: {}",
            background=color['gray'],
            padding=6,
        ),
        left_arrow(color['gray'], color['bg']),
        left_arrow(color['bg'], color['blue']),
        widget.TextBox(
            text="",
            fontsize=20,
            padding=2,
            background=color['blue']
        ),
        widget.GenPollText(
            func=lambda: subprocess.check_output(os.path.expanduser("~/scripts/get_kernel_version.sh")).decode("utf-8"),
            background=color['blue'],
            padding=6
        ),
        left_arrow(color['blue'], color['magenta']),
        widget.TextBox(
            text="",
            fontsize=20,
            padding=4,
            background=color['magenta']
        ),
        widget.ThermalSensor(
            fmt="Temp: {}",
            padding=6,
            background=color['magenta']
        ),
        left_arrow(color['magenta'], color['blue']),
        widget.TextBox(
            text="",
            fontsize=17,
            padding=4,
            background=color['blue']
        ),
        widget.Memory(
            fmt="Mem:{}",
            padding=6,
            background=color['blue'],
            mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn('alacritty -e htop')}
        ),
        left_arrow(color['blue'], color['magenta']),
        widget.Sep(
            padding=2,
            linewidth=0,
            background=color['magenta']
        ),
        widget.TextBox(
            text="↻",
            fontsize=16,
            background=color['magenta']
        ),
        widget.CheckUpdates(
            display_format="Updates: {updates}",
            no_update_string="Updates: N/A",
            distro="Arch_checkupdates",
            update_interval=60,
            padding=6,
            background=color['magenta'],
            mouse_callbacks={'Button1': lambda: qtile.cmd_spawn('alacritty -e sudo pacman -Syu')}
        ),
        widget.Sep(
            linewidth=0,
            padding=2,
            background=color['magenta']
        ),
        left_arrow(color['magenta'], color['blue']),
        widget.TextBox(
            text="",
            fontsize=20,
            padding=4,
            background=color['blue'],
        ),
        widget.Clock(
            format="%A - %m/%d/%Y - (%I:%M) %p ",
            padding=4,
            background=color['blue'],
        ),
        widget.Sep(
            linewidth=0,
            padding=0,
            background=color['blue']
        ),
        left_arrow(color['blue'], color['gray']),
        left_arrow(color['gray'], color['bg']),
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
