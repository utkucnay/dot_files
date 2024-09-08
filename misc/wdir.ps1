$directories = Get-ChildItem "D:\project" -directory | Select -ExpandProperty FullName

$selected_directoy = $( $directories | fzf)

if ($selected_directoy -eq $null)
{

}
else
{
    cd $selected_directoy
    nvim $selected_directoy
}
