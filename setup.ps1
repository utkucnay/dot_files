#Soft Link For Configs
cmd /c mklink /D D:\misc $( $PSScriptRoot + "\misc\")
cmd /c mklink /D $( $env:USERPROFILE + "\AppData\Local\nvim") $($PSScriptRoot + "\nvim\")
cmd /c mklink $( $env:USERPROFILE + "\Documents\PowerShell\Microsoft.PowerShell_profile.ps1") $($PSScriptRoot + "\powershell\Microsoft.PowerShell_profile.ps1")
cmd /c mklink /D $( $env:USERPROFILE + "\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState") $($PSScriptRoot + "\windows_terminal\LocalState")

#Install Scoop Sh
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

#Install Packages
scoop import ./scoop/scoop_export.json

#Install Packer nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\ ~/.local/share/nvim/site/pack/packer/start/packer.nvim

#Packer Install
nvim --headless -c "e $($PSScriptRoot + "\nvim\lua\theprimeagen\packer.lua")" -c "so" -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

[Environment]::SetEnvironmentVariable("Path", $env:Path + ";D:\misc", "Machine")
