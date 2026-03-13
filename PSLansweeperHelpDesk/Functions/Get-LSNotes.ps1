
function Get-LSNotes {
    
    Param (
        [Parameter(Mandatory=$true)]
        [String]$Url,

        [Parameter(Mandatory=$true)]
        [String]$TicketID
    )

    # API Call to get ticket notes using secret url and ticket id
    $Url = ($Url + "action=GetNotes&" + "TicketID=$TicketID") 
    $Request = Invoke-WebRequest -Uri $Url -UseBasicParsing
    
    # Checking response
    if($Request.StatusCode -ne 200) {
        throw ("{0} {1}" -f $Request.StatusCode, $Request.StatusDescription)
    }

    # Returning ticket notes as json
    $Request.Content | ConvertFrom-Json
}