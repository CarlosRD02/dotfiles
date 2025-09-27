from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
import qtheme 
import os
import subprocess
from colors import *
from libqtile.widget import backlight

# Grupo de Atajos de Teclas

mod = "mod4"
terminal = guess_terminal()

keys = [
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    Key([mod, "shift"], "j", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "right", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "up", lazy.layout.shuffle_up(), desc="Move window up"),

    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    Key([mod, "shift"],"Return",lazy.layout.toggle_split(),desc="Toggle between split and unsplit sides of stack"),

    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window"),
    Key([mod, "shift",], "space", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "e", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key(["control"], "space", lazy.spawn("rofi -show run")),
    # Launch alacritty
    Key(["control", "mod1"], "t", lazy.spawn("alacritty"), desc="Launch Alacritty terminal"),
    
    Key([mod], "o", lazy.spawn("xfce4-screenshooter"), desc="Screnshoot"),
    Key([mod], "e", lazy.spawn("thunar"), desc="Thunar")
]


# Grupo de workspaces

for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )

group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
group_labels = ["", "󰨞", "", "󰈹", "󰊢", "", "", "", ""]

groups = [Group(name, label=label) for name, label in zip(group_names, group_labels)]

for i, group in enumerate(groups):
    keys.extend(
        [
            Key(
                [mod],
                group.name,
                lazy.group[group.name].toscreen(),
                desc=f"Switch to group {group_labels[i]}",
            ),
            Key(
                [mod, "shift"],
                group.name,
                lazy.window.togroup(group.name, switch_group=True),
                desc=f"Switch to & move focused window to group {group_labels[i]}",
            ),
        ]
    )

colors = qtheme.nord  # o qtheme.dracula, qtheme.gruvboxs

# Grupo de Layouts

layouts = [
    layout.Columns(border_width=0, margin=3, fair=False),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

# Grupo Widgets

widget_defaults = dict(
     font="Arial",
     fontsize=13,
     padding=3,
    foreground=foreground,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        wallpaper='/home/carlos/Imágenes/wallpaperbetter.com_1920x1080.jpg',
        wallpaper_mode='fill',
        top=bar.Bar(
            [
               
                #widget.TextBox(" "),
                widget.GroupBox(
                    font="Symbols Nerd Font Mono", 
                    fontsize=14, 
                    margin_y=1, 
                    #margin=6,
                    spacing=6,
                    #padding=0,
                    #margin_x=4, 
                    #padding_y=3, 
                    #padding_x=1,
                    #borderwidth = 2.5, 
                    active=color3,
                    foreground=foreground,
                    background=background,
                    block_highlight_text_color=color2,
                    inactive=foreground_inactive,
                    rounded = True,
                    #highlight_color= color3, 
                    highlight_method='text',
                    this_current_screen_border=color1, 
                    this_screen_border=color3, 
                    center_aligned = True,
                    disable_drag = True
                ),
                widget.WindowName(
                    for_current_screen = True     
                ),
                widget.TextBox(
                    text='',
                    #background = color3,
                    foreground = color1,
                    fontsize = 30,
                    #padding = 2,
                ),
		
                widget.Volume(
                    font="Symbols Nerd Font Mono",
                    fontsize=14,
                    mute_format='', 
                    unmute_format='  {volume}%', 
                    step=5,
                    background=color1, 
                    foreground=background,
                    
                ),
                widget.TextBox(
                    text='',
                    background = background,
                    foreground = color2,
                    fontsize = 30,
                    #padding = 2,
                    
                ),
                widget.KeyboardLayout(
                    font="Symbols Nerd Font Mono",
                    fontsize=14,
                    configured_keyboards=['us intl', 'es'],
                    display_map={'us intl': '   us intl',  'es': '   es'},
                    background=color2, 
                    foreground=foreground
                ),
                widget.TextBox(
                    text='|',
                    background = background,
                    foreground = color3,
                    fontsize = 22,
                    padding = 2
                ),

                widget.CPU(
                    font="Symbols Nerd Font Mono",
                    fontsize=14,
                    format=' {load_percent}%', 
                    background=background, 
                    foreground=color3
                ),
                widget.TextBox(
                    text='|',
                    background = background,
                    foreground = color3,
                    
                    fontsize = 22,
                    padding = 2
                ),
                widget.Memory(
                    font="Symbols Nerd Font Mono",
                    fontsize=14,
                    format=' {MemUsed: .0f}{mm}/{MemTotal: .0f}{mm}', 
                    #update_interval=1.0,
                    measure_mem='M',
                    background=background, 
                    foreground=color4
                ),
                widget.TextBox(
                    text='|',
                    background = background,
                    foreground = color3,
                    fontsize = 22,
                    padding = 2
                ),
                # widget.TextBox(
                #     " ", 
                #     font="Symbols Nerd Font Mono",
                #     fontsize=30, 
                #     padding=-14, 
                #     background=color4, 
                #     foreground=color5
                # ),
                widget.Clock(
                    font="Symbols Nerd Font Mono",
                    fontsize=14,
                    format="%a %d/%m %I:%M %p", 
                    background=background, 
                    foreground=color5
                ),
                widget.TextBox(
                    text='|',
                    background = background,
                    foreground = color3,
                    update_interval=1.0,
                    fontsize = 22,
                    padding = 2
                ),
                # widget.TextBox(
                #     text='󰅁',
                #     background = background,
                #     foreground = color3,
                #     update_interval=1.0,
                #     fontsize = 22,
                #     padding = 2
                # ),
                # widget.TextBox(
                #     " ",
                #     font="Symbols Nerd Font Mono", 
                #     fontsize=30, 
                #     padding=-14, 
                #     background=color5, 
                #     foreground=color1
                # ),
                # widget.WidgetBox(
                #     widgets=[
                #         widget.QuickExit(
                #             font="Symbols Nerd Font Mono",
                #             default_text = ' 󰍃', 
                #             countdown_format = ' {}  ', 
                #             background=color1, 
                #             foreground=foreground2, 

                #         ),
                #         widget.TextBox(
                #             " 󰐥",
                #             font="Symbols Nerd Font Mono",
                #             fontsize=30,
                #             background=color1, 
                #             foreground=foreground2,
                #           #  mouse_callbacks={'Button1':lazy.spawn(powerMenu)}
                #             ),
                #     ],
                #    font="Symbols Nerd Font Mono",
                #    text_closed=' ',
                #    text_open='  ',
                #    background=color1, 
                #    foreground=foreground2,
                #),
                #widget.TextBox(
                #" ", 
                #font="Symbols Nerd Font Mono",
                #background=color1
                #),
                widget.Systray(
                    #padding=2
                ),

               
                
            ],
            20,
            background = background,
            opacity = 0.80,
            #margin = [0,0,1,0]
            # border_width=[2, 0, 2, 0],  # Si quieres bordes, descomenta y ajusta
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]
        ),
    ),
]

# Grupo de Mouse


# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]


dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False

# Floating Layouts

floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
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

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

## Autostart ##
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([home])

wmname = "LG3D"
