#Remove Files
if(test-path $( $env:USERPROFILE + "\AppData\Local\nvim"))
{
    rm $( $env:USERPROFILE + "\AppData\Local\nvim")
}

if(test-path $( $env:USERPROFILE + "\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"))
{
    rm $( $env:USERPROFILE + "\Documents\PowerShell\Microsoft.PowerShell_profile.ps1")
}

if(test-path $( $env:USERPROFILE + "\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"))
{
    rm $( $env:USERPROFILE + "\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState")
}

if(! (test-path $( $env:USERPROFILE + "\Documents\PowerShell")) )
{
    mkdir $( $env:USERPROFILE + "\Documents\PowerShell")
}

#Soft Link For Configs
cmd /c mklink /D D:\misc $( $PSScriptRoot + "\misc\")
cmd /c mklink /D $( $env:USERPROFILE + "\AppData\Local\nvim") $($PSScriptRoot + "\nvim\")
cmd /c mklink $( $env:USERPROFILE + "\Documents\PowerShell\Microsoft.PowerShell_profile.ps1") $($PSScriptRoot + "\powershell\Microsoft.PowerShell_profile.ps1")
cmd /c mklink /D $( $env:USERPROFILE + "\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState") $($PSScriptRoot + "\windows_terminal\LocalState")

#Install Scoop Sh
if(! (test-path $( $env:USERPROFILE + "\scoop")) )
{
    iex "& {$(irm get.scoop.sh)} -RunAsAdmin"
}

#Install Packages
scoop bucket add main
scoop install git
scoop import ./scoop/scoop_export.json

#Install Packer nvim
git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"

#Packer Install
nvim --headless -c "e $($PSScriptRoot + "\nvim\lua\theprimeagen\packer.lua")" -c "so" -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

[Environment]::SetEnvironmentVariable("Path", $env:Path + ";D:\misc", "Machine")

#Install WinUtil
irm "https://christitus.com/win" | iex
