function fish_title
    if set -q argv[1]
        echo $argv[1]
    else
        echo (basename "$PWD")
    end
end
# function fish_title
#     set -q argv[1]; or set argv fish
#     # Looks like ~/d/fish: git log
#     # or /e/apt: fish
#     echo (fish_prompt_pwd_dir_length=1 prompt_pwd): $argv;
# end
