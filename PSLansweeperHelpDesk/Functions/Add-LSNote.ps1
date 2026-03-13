
function Add-LSNote {
    
    Param (
        [Parameter(Mandatory=$true)]
        [String]$Url,

        [Parameter(Mandatory=$true)]
        [String]$TicketID,

        [Parameter(Mandatory=$true)]
        [String]$Text,

        # Non-mandatory
        [String]$Username,
        [String]$Displayname,
        [String]$Email,
        [String]$Files,
        [ValidateSet("Public", "Internal")]
        [String]$Type
    )

     # Base parameters for url
    $params = @{
        action   = 'AddNote'
        TicketID = $TicketID
        Text     = $Text
    }
    
    # Add optional parameters if used
    if($Username)    {$params.Username    = $Username}
    if($Displayname) {$params.Displayname = $Displayname}
    if($Email)       {$params.Email       = $Email}
    if($Type)        {$params.Type        = $Type}
    if($Files)       {$params.Files       = $Files}

    # Building query string
    $queryString = ($params.GetEnumerator() | ForEach-Object {
        '{0}={1}' -f [uri]::EscapeDataString($_.Key), [uri]::EscapeDataString([string]$_.Value)
    }) -join '&'
    $fullUrl = '{0}{1}' -f $Url, $queryString

    # Add note using the api
    $Request = Invoke-WebRequest -Uri $fullUrl -UseBasicParsing
    
    # Checking response
    if($Request.StatusCode -ne 200) {
        throw ("{0} {1}" -f $Request.StatusCode, $Request.StatusDescription)
    }
    if(($Request.Content | ConvertFrom-Json).Success) {
        Write-Host "Note has been added successfully!" -ForegroundColor "Green"
    } else {
        Write-Host "Something went wrong when adding note." -ForegroundColor "Red"
        Write-Error $Request.Content
    }

    return $Request.Content
}