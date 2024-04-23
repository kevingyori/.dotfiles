# function fish_title
#     if set -q argv[1]
#         echo $argv
#     else
#         echo (basename "$PWD")
#     end
# end

# function fish_title
#     set -q argv[1]; or set argv fish
#     # Looks like ~/d/fish: git log
#     # or /e/apt: fish
#     echo (fish_prompt_pwd_dir_length=1 prompt_pwd): $argv
# end
function fish_title
    # `prompt_pwd` shortens the title. This helps prevent tabs from becoming very wide.
    echo $argv[1] (prompt_pwd)
    pwd
end
