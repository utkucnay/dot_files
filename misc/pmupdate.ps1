scoop update -a
winget update --all
nvim --headless -c "e $( $env:USERPROFILE + "\AppData\Local\nvim\lua\theprimeagen\packer.lua")" -c "so" -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
