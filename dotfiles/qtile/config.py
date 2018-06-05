# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from time import time
from pathlib import Path
import os
import subprocess

try:
    from typing import List  # noqa: F401
except ImportError:
    pass


# bl_inc = 'gdbus call --session --dest org.gnome.SettingsDaemon.Power --object-path /org/gnome/SettingsDaemon/Power --method org.gnome.SettingsDaemon.Power.Screen.StepUp'
# bl_dec = 'gdbus call --session --dest org.gnome.SettingsDaemon.Power --object-path /org/gnome/SettingsDaemon/Power --method org.gnome.SettingsDaemon.Power.Screen.StepDown'
bl_inc = 'xbacklight -inc 5'
bl_dec = 'xbacklight -dec 5'
vol_toggle = 'pactl set-sink-mute alsa_output.pci-0000_00_1b.0.analog-stereo toggle'
vol_up = 'pactl set-sink-volume alsa_output.pci-0000_00_1b.0.analog-stereo +3%'
vol_down = 'pactl set-sink-volume alsa_output.pci-0000_00_1b.0.analog-stereo -3%'

mod = "mod4"

keys = [
    # Switch between windows in current stack pane
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),

    # Move windows up or down in current stack
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right()),

	Key([mod, "control"], "Down", lazy.layout.grow_down()),
    Key([mod, "control"], "Up", lazy.layout.grow_up()),
    Key([mod, "control"], "Left", lazy.layout.grow_left()),
    Key([mod, "control"], "Right", lazy.layout.grow_right()),

    Key([mod, "shift"], "n", lazy.layout.normalize()),
    Key([mod, "shift"], "v", lazy.layout.toggle_split()),

    # toggle fullscreen for current window
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    # kill current window
    Key([mod, "shift"], "q", lazy.window.kill()),

    # starting applications
    Key([mod], "Return", lazy.spawn("urxvtc")),
    Key([mod], "g", lazy.spawn("google-chrome")),
    Key([mod], "s", lazy.spawn("subl")),
    Key([mod], "t", lazy.spawn("nautilus")),
    Key([mod], "m", lazy.spawn("urxvtc -e ncmpcpp")),

    # Toggle between different layouts as defined below
    # Key([mod], "Tab", lazy.next_layout()),

    Key([mod, "shift"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "d", lazy.spawncmd()),

    # key bindings for function keys
    Key([], 'XF86MonBrightnessDown', lazy.spawn(bl_dec)),
    Key([], 'XF86MonBrightnessUp', lazy.spawn(bl_inc)),
    Key([], 'XF86AudioMute', lazy.spawn(vol_toggle)),
    Key([], 'XF86AudioRaiseVolume', lazy.spawn(vol_up)),
    Key([], 'XF86AudioLowerVolume', lazy.spawn(vol_down)),
    Key([], 'XF86AudioPlay', lazy.spawn("mpc toggle")),
    Key([], 'XF86AudioNext', lazy.spawn("mpc next")),
    Key([], 'XF86AudioPrev', lazy.spawn("mpc prev")),

    Key([mod, "control"], "l", lazy.spawn("/home/jordan/tools/betterlockscreen/betterlockscreen -l")),

]


groups = [Group(i, ) for i in "12345"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen()),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
    ])

layouts = [
    layout.Bsp(border_focus='#8e8e8e', border_normal='#3f3f3f', border_width=2, margin=1.5),
]

widget_defaults = dict(
    font='sans',
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()


screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(font='tewi', fontsize=10, borderwidth=1, padding=1.5),
                widget.Prompt(font='tewi', fontsize=10),
                widget.WindowName(font='tewi', fontsize=10),
                # widget.TextBox("default config", name="default"),
                widget.Systray(icon_size=12),
                # widget.Volume(),
                # widget.Wlan(interface='wlp7s0'),
                # widget.Sep(),
                # widget.LaunchBar(progs=('logout', 'qshell:self.qtile.cmd_shutdown', 'logout from qtile')),
                widget.TextBox(text='%s'%(subprocess.check_output(['mpc', 'current']))[:-1], font='tewi', fontsize=10),
                widget.Sep(size_percent=70),
                # widget.Image(filename='/home/jordan/.icons/sun.png'),
                widget.Backlight(backlight_name='intel_backlight', brightness_file='brightness', font='tewi', fontsize=10),
                widget.Sep(size_percent=70),
                widget.BatteryIcon(),
                widget.Battery(font='tewi', fontsize=10),
                widget.Sep(size_percent=70),
                widget.Clock(format='%m-%d %a %I:%M %p', font='tewi', fontsize=10),
            ],
            18,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]


@hook.subscribe.startup_once
def autostart():
	home = os.path.expanduser('/home/jordan/.config/qtile/autostart.sh')
	subprocess.call([home])



dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, github issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = 'qtile'
