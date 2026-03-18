
function Add-LSAsset {
    
    Param (
        [Parameter(Mandatory=$true)]
        [String]$Url,

        [Parameter(Mandatory=$true)]
        [String]$TicketID,
        
        [Parameter(Mandatory = $true, ParameterSetName = 'ByIP')]
        [string]$IPAddress,

        [Parameter(Mandatory = $true, ParameterSetName = 'ByName')]
        [string]$AssetName
    )
    
    # Input either by name or ip
    $Asset = if ($PSCmdlet.ParameterSetName -eq 'ByIP') {
        "IPAddress=$IPAddress"
    } else {
        "AssetName=$AssetName"
    }
    
    # API call to add asset to ticket
    $Url = ($Url + "action=AddAsset&" + "TicketID=$TicketID&" + $Asset) 
    $Request = Invoke-WebRequest -Uri $Url -UseBasicParsing
    
    # Checking response
    if($Request.StatusCode -ne 200) {
        throw ("{0} {1}" -f $Request.StatusCode, $Request.StatusDescription)
    }
    
    $Data = $Request.Content | ConvertFrom-Json
    if($Data.Success) {
        return $Data
    } else {
        Write-Error "Adding asset was not successful, check output message."
        return $Data
    }
}
