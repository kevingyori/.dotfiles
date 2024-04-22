function light --wraps="kitty @ --to='$KITTY_LISTEN_ON' set-colors -a ~/.config/kitty/light-theme.conf && nvim --server /tmp/nvim.pipe --remote-send ':set background=light<cr>'" --description 'set light theme in nvim and kitty'
    kitty @ --to="$KITTY_LISTEN_ON" kitten themes Catppuccin-Latte && kitty @ --to="$KITTY_LISTEN_ON" set-colors -a ~/.config/kitty/light-theme.conf && nvim --server /tmp/nvim.pipe --remote-send ':set background=light<cr>' $argv

end
