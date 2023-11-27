function ll --wraps=ls --wraps='lsd -la' --description 'alias ll=lsd -la'
  lsd -la $argv
        
end
