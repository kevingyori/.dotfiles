"""draw kitty tab"""
# pyright: reportMissingImports=false
# pylint: disable=E0401,C0116,C0103,W0603,R0913

import math
from kitty.boss import get_boss
from kitty.fast_data_types import Screen, get_options
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    TabBarData,
    as_rgb,
    draw_tab_with_separator,
)
from kitty.utils import color_as_int

opts = get_options()

# colors
BACKGROUND = as_rgb(color_as_int(opts.tab_bar_background))
MAGENTA = as_rgb(color_as_int(opts.color5))


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

    draw_tab_with_separator(
        draw_data, screen, tab, before, max_title_length, index, is_last, extra_data
    )

    if is_last:
        _draw_right_status(screen, is_last)

    return screen.cursor.x


def _draw_right_status(screen: Screen, is_last: bool) -> int:

    tab_manager = get_boss().active_tab_manager
    cells = []

    if tab_manager is not None:
        windows = tab_manager.active_tab.windows.all_windows
        if windows is not None:
            for i, window in enumerate(windows):
                window_fg = BACKGROUND if window.id == tab_manager.active_window.id else MAGENTA
                window_bg = MAGENTA if window.id == tab_manager.active_window.id else BACKGROUND
                sup = to_sup(str(i + 1))

                cells.insert(i, (window_fg, window_bg,
                             f" {sup} {window.title} "))

    # calculate leading spaces to separate tabs from right status
    right_status_length = 0
    for _, _, cell in cells:
        right_status_length += len(cell)

    # calculate leading spaces
    leading_spaces = 0
    leading_spaces = screen.columns - screen.cursor.x - right_status_length

    # draw leading spaces
    if leading_spaces > 0:
        screen.draw(" " * leading_spaces)

    # draw right status
    for fg, bg, cell in cells:
        screen.cursor.fg = fg
        screen.cursor.bg = bg
        screen.draw(cell)
    screen.cursor.fg = 0
    screen.cursor.bg = 0

    # update cursor position
    screen.cursor.x = max(
        screen.cursor.x, screen.columns - right_status_length)
    return screen.cursor.x


def to_sup(s):
    sups = {u'0': u'\u2070',
            u'1': u'\xb9',
            u'2': u'\xb2',
            u'3': u'\xb3',
            u'4': u'\u2074',
            u'5': u'\u2075',
            u'6': u'\u2076',
            u'7': u'\u2077',
            u'8': u'\u2078',
            u'9': u'\u2079'}

    return ''.join(sups.get(char, char) for char in s)
