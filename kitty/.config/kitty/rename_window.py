from typing import List
from kitty.boss import Boss


def main(args: List[str]) -> str:
    # this is the main entry point of the kitten, it will be executed in
    # the overlay window when the kitten is launched
    answer = input('Rename window to: ')
    # whatever this function returns will be available in the
    # handle_result() function
    return answer


def handle_result(args: List[str], answer: str, target_window_id: int, boss: Boss) -> None:
    # get the kitty window into which to paste answer
    w = boss.window_id_map.get(target_window_id)
    if w is not None:
        boss.call_remote_control(
            w, ("set-window-title", answer))
