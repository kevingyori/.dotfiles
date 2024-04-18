# modified from https://github.com/taylorzr/kitty-meow

from kittens.tui.handler import result_handler
import argparse
import json
import os
import subprocess
from datetime import datetime
from typing import List

from kitty.boss import Boss

parser = argparse.ArgumentParser(description="meow")

parser.add_argument(
    "--dir",
    dest="dirs",
    action="append",
    default=[],
    # required=True,
    help="directories to find projects",
)

parser.add_argument(
    "--shortcut",
    dest="shortcut",
    action="store",
    default="",
    help="shortcut to dir to launch",
)


def main(args: List[str]) -> str:
    opts = parser.parse_args(args[1:])

    # FIXME: How to call boss in the main function?
    # data = boss.call_remote_control(None, ("ls",))
    kitty_ls = json.loads(
        subprocess.run(
            ["kitty", "@", "ls"], capture_output=True, text=True
        ).stdout.strip("\n")
    )

    if opts.shortcut != "":
        return ""

    tabs_and_projects = [tab["title"] for tab in kitty_ls[0]["tabs"]]
    projects = []

    for dir in opts.dirs:
        if dir.endswith("/"):
            for f in os.scandir(dir):
                if f.is_dir():
                    name = os.path.basename(f.path)
                    pretty_path = f.path.replace(
                        os.path.expanduser("~"), "~", 1)
                    projects.append(pretty_path)
                    if name not in tabs_and_projects:
                        tabs_and_projects.append(pretty_path)
        else:
            name = os.path.basename(dir)
            projects.append(dir)
            if name not in tabs_and_projects:
                tabs_and_projects.append(dir)

    bin_path = os.getenv("BIN_PATH", "")

    default_prompt = "project"
    # NOTE: Can't use ' char within any of the binds
    bind = 'alt-l:change-prompt({0}> )+reload(printf "{1}")'.format(
        default_prompt, "\n".join(tabs_and_projects)
    )
    args = [
        f"{bin_path}fzf",
        f"--prompt={default_prompt}> ",
        f"--bind={bind}",
    ]
    p = subprocess.Popen(args, stdin=subprocess.PIPE, stdout=subprocess.PIPE)
    out = p.communicate(input="\n".join(tabs_and_projects).encode())[0]
    selection = out.decode().strip()

    # from kittens.tui.loop import debug
    # debug(selection)

    return selection


def handle_result(
    args: List[str], answer: str, target_window_id: int, boss: Boss
) -> None:
    opts = parser.parse_args(args[1:])

    if opts.shortcut != "":
        path = opts.shortcut
        dir = os.path.basename(path)
    else:
        if not answer:
            return
        path, *rest = answer.split()
        dir = os.path.basename(path)

    with open(f"{os.path.expanduser('~')}/.config/kitty/meow/history", "a") as history:
        history.write(f"{dir} {datetime.now().isoformat()}\n")
        history.close()

    kitty_ls = json.loads(boss.call_remote_control(None, ("ls",)))
    for tab in kitty_ls[0]["tabs"]:
        if tab["title"] == dir:
            boss.call_remote_control(
                None, ("focus-tab", "--match", f"title:^{dir}$"))
            return

    window_id = boss.call_remote_control(
        None,
        (
            "launch",
            "--type",
            "tab",
            "--tab-title",
            dir,
            "--cwd",
            path,
        ),
    )

    parent_window = boss.window_id_map.get(window_id)

    # start editor and another window
    boss.call_remote_control(parent_window, ("send-text", "lv .\n"))
    boss.call_remote_control(
        parent_window,
        ("launch", "--type", "window", "--dont-take-focus", "--cwd", path),
    )
