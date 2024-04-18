function f --wraps='cd ' --wraps='fd --type d --min-depth 1 --max-depth 1 --hidden . "/Users/kevingyori/dev" "/Users/kevingyori/" | fzf' --description 'alias f=cd /Users/kevingyori/.dotfiles/'
    cd $(fd --type d --min-depth 1 --max-depth 1 --hidden . "/Users/kevingyori/dev" "/Users/kevingyori/" | fzf) $argv
    # cd $(fd --type d --min-depth 1 --max-depth 1 --hidden . "/Users/kevingyori/dev" "/Users/kevingyori/" | fzf)
end
