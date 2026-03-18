
$functions  = Get-ChildItem -Path "$PSScriptRoot\Functions\*.ps1" -Recurse -ErrorAction SilentlyContinue

foreach ($file in $functions) {
    try {
    . $file.FullName
    } catch {
        Write-Error "Error when importing $($file.fullname): $_"
    }
}

Export-ModuleMember -Function $functions.BaseName
