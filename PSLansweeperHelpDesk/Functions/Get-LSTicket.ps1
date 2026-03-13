
function Get-LSTicket {
    
    Param (
        [Parameter(Mandatory=$true)]
        [String]$Url,

        [Parameter(Mandatory=$true)]
        [String]$TicketID
    )

    # API Call to get ticket using secret url and ticket id
    $Url = ($Url + "action=GetTicket&" + "TicketID=$TicketID") 
    $Request = Invoke-WebRequest -Uri $Url -UseBasicParsing
    
    # Checking response
    if($Request.StatusCode -ne 200) {
        throw ("{0} {1}" -f $Request.StatusCode, $Request.StatusDescription)
    }

    # Returning ticket data as json
    $Request.Content | ConvertFrom-Json
}