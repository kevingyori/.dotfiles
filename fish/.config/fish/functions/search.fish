function search --wraps=fzf\ --preview\ \'bat\ --color=always\ --style=numbers\ --line-range=:500\ \{\}\'\ \|\ xargs\ nvim --description alias\ search=fzf\ --preview\ \'bat\ --color=always\ --style=numbers\ --line-range=:500\ \{\}\'\ \|\ xargs\ nvim
  fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' | xargs nvim $argv
        
end
