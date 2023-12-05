function nvim-lazy --wraps='NVIM_APPNAME nvim' --wraps='NVIM_APPNAME=LazyVim nvim' --description 'alias nvim-lazy=NVIM_APPNAME=LazyVim nvim'
  NVIM_APPNAME=LazyVim nvim $argv
        
end
