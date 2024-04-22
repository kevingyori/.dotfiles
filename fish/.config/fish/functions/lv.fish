function lv --wraps='NVIM_APPNAME=LazyVim nvim --listen /tmp/nvim.pipe' --description 'alias lv=NVIM_APPNAME=LazyVim nvim'
    NVIM_APPNAME=LazyVim nvim --listen /tmp/nvim.pipe $argv

end
