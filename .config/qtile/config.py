# __  __ __ __             
#|  |/  |__|__|.----.-----.
#|     <|  |  ||   _|  _  | Guilherme Monteiro : https://github.com/Oriikoreh
#|__|\__|__|__||__| |_____| My qtile config archive.

# Imports
from typing import List  # noqa: F401

from libqtile import qtile
from libqtile import bar, layout, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen, KeyChord
from libqtile.lazy import lazy
from widgets_list import init_widget_list

import os
import re
import socket
import subprocess

# Variables.
mod = "mod4" # Sets mod key to SUPER/WINDOWS
terminal = "alacritty" # My terminal of choice
browser = "brave" # My browser of choice

# Keybinds.
keys = [
    # The essentials keybinds
    Key([mod], "Return", lazy.spawn(terminal),
        desc="Launch terminal"),#

    Key([mod], "F1", lazy.spawn(browser),
        desc="Open browser"),#

    Key([mod], "p", lazy.spawn("rofi -show drun -show-icons"),
        desc="Launch rofi"),#

    Key([mod], "d", lazy.spawn("dmenu_run -i -p 'Run:' -sb '#9600fa' -h 22"),
        desc="Launch dmenu"),#

    Key([mod, "shift"], "z", lazy.spawn("slock"),
        desc="lock screen"),#

    Key([],"XF86MonBrightnessUp", lazy.spawn("light -A 1")),
    Key([],"XF86MonBrightnessDown", lazy.spawn("light -U 1")),

    # Doom Emacs
    KeyChord([mod], "e", [
                 Key([], "e", lazy.spawn("emacsclient -c -a 'emacs'"), lazy.ungrab_chord(),
                     desc="Launch emacs"),#
                 Key([], "b", lazy.spawn("emacsclient -c -a 'emacs' --eval '(ibuffer)'"), lazy.ungrab_chord(),
                     desc="Launch ibuffer in emacs"),#
             ],name="Emacs"),

    # Dmenu Scripts
    KeyChord([mod], "i", [
                 Key([], "1", lazy.spawn("./.local/bin/dmscripts/dm-configedit"), lazy.ungrab_chord(),
                     desc="Choose a config file to edit"),#
                 Key([], "2", lazy.spawn("./.local/bin/dmscripts/dm-brightness"), lazy.ungrab_chord(),
                     desc="Change brightness with dmenu"),#
                 Key([], "3", lazy.spawn("./.local/bin/dmscripts/dm-archwikisearch"), lazy.ungrab_chord(),
                     desc="Open a local arch wiki documentation"),#
                 Key([], "8", lazy.spawn("./.local/bin/dmscripts/dm-screenshot"), lazy.ungrab_chord(),
                     desc="Take screenshot with dmenu"),#
                 Key([], "9", lazy.spawn("./.local/bin/dmscripts/dm-logout"), lazy.ungrab_chord(),
                     desc="Logout menu"),#
             ],name="DM Scripts"),

    # Focus control
    # Switch between windows
    Key([mod], "h", lazy.layout.left(),
        desc="Move focus to left"),#

    Key([mod], "l", lazy.layout.right(),
        desc="Move focus to right"),#

    Key([mod], "j", lazy.layout.down(),
        desc="Move focus down"),#

    Key([mod], "k", lazy.layout.up(),
        desc="Move focus up"),#

    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),#

    # Window control
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),#

    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),#

    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), lazy.layout.section_down(),
        desc="Move window down"),#

    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), lazy.layout.section_up(),
        desc="Move window up"),#


    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),#

    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),#

    Key([mod, "control"], "j", lazy.layout.grow_down(),
        desc="Grow window down"),#

    Key([mod, "control"], "k", lazy.layout.grow_up(),
        desc="Grow window up"),#

    Key([mod], "n", lazy.layout.normalize(),
        desc="Reset all window sizes"),#

    Key([mod], "h", lazy.layout.shrink(), lazy.layout.decrease_nmaster(),
        desc="Shrink window (MonadTall), decrease number in master pane (Tile)"),#

    Key([mod], "l", lazy.layout.grow(), lazy.layout.increase_nmaster(),
        desc="Expand window (MonadTall), increase number in master pane (Tile)"),#


    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),#
    
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(),
        desc="Toggle between layouts"),#

    Key([mod, "shift"], "c", lazy.window.kill(),
        desc="Kill focused window"),#

    # Qtile control
    Key([mod, "control"], "r", lazy.reload_config(),
        desc="Reload the config"),#

    Key([mod, "control"], "k", lazy.spawn("./scripts/qtile_keys.sh"),
        desc="Show qtile keybinds"),#

    Key([mod, "control"], "q", lazy.shutdown(),
        desc="Shutdown Qtile"),#

    Key([mod], "r", lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),#
]

#Groups define.
groups = [
    Group('1', label="一", layout="monadtall"),
    Group('2', label="二", matches=[Match(wm_class='firefox')], layout="monadtall"),
    Group('3', label="三", layout="monadtall"),
    Group('4', label="四", layout="monadtall"),
    Group('5', label="五", layout="monadtall"),
    Group('6', label="六", layout="monadtall"),
    Group('7', label="七", layout="monadtall"),
    Group('8', label="八", layout="monadtall"),
    Group('9', label="九", layout="monadtall")
]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key([mod], i.name, lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
             # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
             # Or, use below if you prefer not to switch to that group.
             # mod1 + shift + letter of group = move focused window to group
             Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
                 desc="move focused window to group {}".format(i.name)),
        ]
    )

# Layouts.    
layouts = [
    layout.Columns(border_focus=["#51afef"], border_width=2),
    layout.Max(),
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    layout.MonadTall(border_focus=["#51afef"], border_width=2, margin=15),
    layout.Floating(border_focus=["#51afef"], border_width=2, margin=15),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

# Widget defaults parameters.
widget_defaults = dict(
    font="SauceCodePro Nerd Font Mono bold",
    fontsize=11,
    padding=2,
    background=["#282c34"],
)
extension_defaults = widget_defaults.copy()

def init_widgets_in_screen():
    widget_list = init_widget_list()
    return widget_list

# Qtile bar and widget configuration.
screens = [
    Screen(top=bar.Bar(widgets=init_widgets_in_screen(), opacity=1.0, size=22)),
]
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="qalculate-gtk"),
        Match(wm_class="blueman-manager"),
        Match(wm_class="yad"),
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# Autostart script.
@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([home])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
