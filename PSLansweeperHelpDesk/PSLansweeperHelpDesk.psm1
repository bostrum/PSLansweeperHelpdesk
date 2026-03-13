
$functions  = Get-ChildItem -Path "$PSScriptRoot\Functions\*.ps1" -Recurse

foreach ($file in $functions) {
    . $file.FullName
}

Export-ModuleMember -Function $functions.BaseName