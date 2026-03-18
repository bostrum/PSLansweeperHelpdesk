
function Remove-LSAsset {
    
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
    
    # API call to remove asset from ticket
    $Url = ($Url + "action=RemoveAsset&" + "TicketID=$TicketID&" + $Asset) 
    $Request = Invoke-WebRequest -Uri $Url -UseBasicParsing
    
    # Checking response
    if($Request.StatusCode -ne 200) {
        throw ("{0} {1}" -f $Request.StatusCode, $Request.StatusDescription)
    }
    
    $Data = $Request.Content | ConvertFrom-Json
    if($Data.Success) {
        return $Data
    } elseif($Data.Message -eq "This asset is not assigned and can not be unassigned") {
        Write-Warning "Cant remove an asset that is not assigned."
        return
    } else {
        Write-Error "Something went wrong, check output message."
        return $Data
    }
}
