## Installing

You will need `git` and GNU `stow`

Clone into your `$HOME` directory or `~`

```bash
git clone https://github.com/kevingyori/.dotfiles.git ~
```

Run `stow` to symlink everything or just select what you want

```bash
stow */ # Everything (the '/' ignores the files such as the README)
```

```bash
stow nvim # Just my nvim config
```

## What I currently use

| OS           | MacOS / Fedora Asahi Remix |
| ------------ | -------------------------- |
| **WM**       | Default / Sway             |
| **Terminal** | Kitty                      |
| **Shell**    | fish                       |
| **Editor**   | Neovim - LazyVim           |
| **Browser**  | Arc / Firefox              |

> I stopped using tiling WMs on MacOS for now, they were causing more issues than they were solving

### Operating System

#### MacOS vs Linux

I dual both MacOS and Fedora Asahi Remix. Love them both for different reasons.

I mostly code on Linux.

I do all of my photo and video editing, designing and gaming on MacOS.

### Window Manager

#### Sway on Linux

I like using sway with an autotiler script for it's simplicity. It was easy to set up and works like a charm.

#### Nothing on MacOS

I've tried tiling WMs (Amethyst, yabai, and AeroSpace), but I'm not using them anymore. You can't change the default window manager on MacOS and all of these solutions were just a bit too janky for me.

I usually revisit this every few months. I really want this to work.

### Terminal

Kitty is fast, and has everything I need from a terminal emulator and multiplexer. It has replaced `tmux` for me - with a [custom kitten](https://github.com/kevingyori/.dotfiles/blob/main/kitty/.config/kitty/sessionizer.py). I love tmux, but I found Kitty easier to deal with, with no downsides.

### Shell

I switched to `fish` from `zsh` because of the built-in syntax highlighting and the auto-suggestions. It even feels a bit snappier than my `zsh` config did.

### Editor

I use the LazyVim Neovim distro with a few extra plugins and tweaks.

Would love to use my own config, but I couldn't get the lsp to work the way I wanted.

### Browser

Arc is awesome, I love the UI & UX.

On linux I use Firefox for browsing and Chromium for web dev.
