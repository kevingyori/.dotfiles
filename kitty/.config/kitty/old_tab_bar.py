"""draw kitty tab"""
# pyright: reportMissingImports=false
# pylint: disable=E0401,C0116,C0103,W0603,R0913

import json
import subprocess
import datetime
from kitty.fast_data_types import Screen, get_options
from kitty.tab_bar import (DrawData, ExtraData, TabBarData, as_rgb,
                           draw_tab_with_powerline, draw_title)

# from kitty.boss import Boss
from kitty.utils import color_as_int

opts = get_options()

INACTIVE_FG = as_rgb(int("ffffff", 16))
INACTIVE_BG = as_rgb(color_as_int(opts.color0))
ACTIVE_FG = as_rgb(int("000000", 16))
ACTIVE_BG = as_rgb(color_as_int(opts.color7))


def _get_active_windows() -> dict:
    data = json.loads(
        subprocess.run(
            ["kitty", "@", "ls"], capture_output=True, text=True
        ).stdout.strip("\n")
    )

    # Create a dictionary to store tabs and their corresponding windows
    tabs_dict = {}

    # Iterate over each tab
    for tab in data[0]['tabs']:
        tab_title = tab['title']
        tabs_dict[tab_title] = []

        # Iterate over each window in the tab
        for window in tab['windows']:
            window_title = window['title']
            window_id = window['id']
            tabs_dict[tab_title].append(
                {"window_title": window_title, "window_id": window_id})

    # Create a dictionary to store windows from the active tab
    active_tab_windows = {}

    # Iterate over each tab
    for tab in data[0]['tabs']:
        if tab['is_active']:
            tab_title = tab['title']
            active_tab_windows[tab_title] = []

            # Iterate over each window in the active tab
            for window in tab['windows']:
                window_title = window['title']
                window_id = window['id']
                window_active = window['is_active']
                # working_directory = window['env']['PWD'].split('/')[-1]
                active_tab_windows[tab_title].append(
                    {"window_title": window_title,
                        "window_id": window_id,
                        "is_active": window_active,
                        # "working_directory": working_directory
                     })

    return active_tab_windows

    # get window_title from active_tab_windows
    active_window_titles = []

    for tab_title, windows in active_tab_windows.items():
        for window in windows:
            active_window_titles.append(window["window_title"])

    return active_window_titles


def _draw_right_status(draw_data: DrawData, screen: Screen, is_last: bool) -> int:
    if not is_last:
        return screen.cursor.x

    cells = []

    for tab_title, windows in _get_active_windows().items():
        for window in windows:
            title = window["window_title"]
            is_active = window["is_active"]
            BG = ACTIVE_BG if is_active else INACTIVE_BG
            FG = ACTIVE_FG if is_active else INACTIVE_FG
            cells.append((FG, BG, f" {title} "))

    right_status_length = 0
    for _, _, cell in cells:
        right_status_length += len(cell)

    print(_get_active_windows())

    draw_spaces = screen.columns - screen.cursor.x - right_status_length
    if draw_spaces > 0:
        screen.cursor.fg = as_rgb(color_as_int(draw_data.default_bg))
        screen.cursor.bg = as_rgb(color_as_int(draw_data.default_bg))
        screen.draw(" " * draw_spaces)

    for fg, bg, cell in cells:
        screen.cursor.fg = fg
        screen.cursor.bg = bg
        screen.draw(cell)
    screen.cursor.fg = 0
    screen.cursor.bg = 0

    screen.cursor.x = max(
        screen.cursor.x, screen.columns - right_status_length)
    return screen.cursor.x


def _draw_left_status(
    draw_data: DrawData, screen: Screen, tab: TabBarData,
    before: int, max_tab_length: int, index: int, is_last: bool,
    extra_data: ExtraData
) -> int:
    orig_fg = screen.cursor.fg
    left_sep, right_sep = ('', '')
    tab_bg = screen.cursor.bg
    slant_fg = as_rgb(color_as_int(draw_data.default_bg))

    def draw_sep(which: str) -> None:
        screen.cursor.bg = tab_bg
        screen.cursor.fg = slant_fg
        screen.draw(which)
        screen.cursor.bg = tab_bg
        screen.cursor.fg = orig_fg

    max_tab_length += 1
    if max_tab_length <= 1:
        screen.draw('…')
    elif max_tab_length == 2:
        screen.draw('…|')
    elif max_tab_length < 6:
        draw_sep(left_sep)
        screen.draw((' ' if max_tab_length == 5 else '') +
                    '…' + (' ' if max_tab_length >= 4 else ''))
        draw_sep(right_sep)
    else:
        draw_sep(left_sep)
        screen.draw(' ')
        draw_title(draw_data, screen, tab, index, max_tab_length)
        extra = screen.cursor.x - before - max_tab_length
        if extra >= 0:
            screen.cursor.x -= extra + 3
            screen.draw('…')
        elif extra == -1:
            screen.cursor.x -= 2
            screen.draw('…')
        screen.draw(' ')
        draw_sep(right_sep)

    return screen.cursor.x


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    # end = draw_tab_with_powerline(
    end = _draw_left_status(
        draw_data, screen, tab, before, max_title_length, index, is_last, extra_data
    )
    _draw_right_status(
        draw_data,
        screen,
        is_last,
    )
    return end
