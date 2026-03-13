<#
 .SYNOPSIS
  Lansweeper URL creation.

 .DESCRIPTION
  Creates URL used for Lansweeper Help Desk API calls.
  Using server name or FQDN combined with secret from file or string parameter.

 .EXAMPLE
   # Simple url creation with secret file in current folder
   New-AuthUrl -Server "lansweeper.domain.com" -Secret "1234"

 .EXAMPLE
   # Manual url creation using string parameter for secret
   New-AuthUrl -Server "lansweeper.domain.com" -SecretPath "C:\.secret"
#>

function New-LansweeperAuthUrl {

    Param (
        [Parameter(Mandatory=$true)]
        [String]$Server,
        
        [String]$Secret,
        [String]$SecretPath
    )

    # Using secret file instead of string
    if(-not $Secret) {
       $Secret = (Get-Content $SecretPath -Raw).Trim()
    }

    # Webrequest with site address
    $Url = "https://$Server/api.aspx?key=$Secret&"
    $Request = Invoke-WebRequest $Url -UseBasicParsing

    # Error handling and return
    if($Request.StatusCode -eq 200) {
        return $Url
    } else {
        throw ("{0} {1}" -f $Request.StatusCode, $Request.StatusDescription)
    }
}