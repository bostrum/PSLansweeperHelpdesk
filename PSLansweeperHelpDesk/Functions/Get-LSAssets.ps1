
function Get-LSAssets {
    
    Param (
        [Parameter(Mandatory=$true)]
        [String]$Url,

        [Parameter(Mandatory=$true)]
        [String]$TicketID
    )
    
    # API Call to get assets assigned to the ticket
    $Url = ($Url + "action=GetAssets&" + "TicketID=$TicketID") 
    $Request = Invoke-WebRequest -Uri $Url -UseBasicParsing
    
    # Checking response
    if($Request.StatusCode -ne 200) {
        throw ("{0} {1}" -f $Request.StatusCode, $Request.StatusDescription)
    }
    
    # Returning as json if success
    $Data = $Request.Content | ConvertFrom-Json
    if($Data.Success) {
        return $Data
    } else {
        throw $Data.Message
    }
}
