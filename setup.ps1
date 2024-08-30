#Remove Files
try {
    rm $( $env:USERPROFILE + "\AppData\Local\nvim")
}
catch {

}

try {
    rm $( $env:USERPROFILE + "\Documents\PowerShell\Microsoft.PowerShell_profile.ps1")
}
catch {

}

try {
    rm $( $env:USERPROFILE + "\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState")
}
catch {

}

#Soft Link For Configs
cmd /c mklink /D D:\misc $( $PSScriptRoot + "\misc\")
cmd /c mklink /D $( $env:USERPROFILE + "\AppData\Local\nvim") $($PSScriptRoot + "\nvim\")
cmd /c mklink $( $env:USERPROFILE + "\Documents\PowerShell\Microsoft.PowerShell_profile.ps1") $($PSScriptRoot + "\powershell\Microsoft.PowerShell_profile.ps1")
cmd /c mklink /D $( $env:USERPROFILE + "\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState") $($PSScriptRoot + "\windows_terminal\LocalState")

#Install Scoop Sh
if((scoop --version | findstr .*).IsNullOrEmpty())
{
    iex "& {$(irm get.scoop.sh)} -RunAsAdmin"
}
else
{
    echo "You have a scoop"
}

#Install Packages
scoop import ./scoop/scoop_export.json

#Install Packer nvim
git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"

#Packer Install
nvim --headless -c "e $($PSScriptRoot + "\nvim\lua\theprimeagen\packer.lua")" -c "so" -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

[Environment]::SetEnvironmentVariable("Path", $env:Path + ";D:\misc", "Machine")

#Install WinUtil
irm "https://christitus.com/win" | iex
