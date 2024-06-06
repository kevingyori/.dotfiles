function kv --wraps='NVIM_APPNAME=kickstart nvim --listen /tmp/nvim.pipe' --description 'alias kv=NVIM_APPNAME=kickstart nvim'
    NVIM_APPNAME=kickstart nvim --listen /tmp/nvim.pipe $argv

end
