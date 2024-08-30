$directories = "D:\Walker", "D:\Pacman"

$selected_directoy = $( $directories | fzf)

cd $selected_directoy

nvim $selected_directoy
