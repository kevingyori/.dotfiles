function dark --wraps="kitty @ --to='$KITTY_LISTEN_ON' set-colors -a ~/.config/kitty/dark-theme.conf && nvim --server /tmp/nvim.pipe --remote-send ':set background=dark<cr>'" --description 'set dark theme in nvim and kitty'
    kitty @ --to="$KITTY_LISTEN_ON" kitten themes Github Dark && kitty @ --to="$KITTY_LISTEN_ON" set-colors -a ~/.config/kitty/dark-theme.conf && nvim --server /tmp/nvim.pipe --remote-send ':set background=dark<cr>' $argv

end
