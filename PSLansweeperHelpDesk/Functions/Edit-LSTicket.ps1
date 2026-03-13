
function Edit-LSTicket {
    
    Param (
        [Parameter(Mandatory=$true)][String]$Url,
        [Parameter(Mandatory=$true)][String]$TicketId,

        # Non-mandatory fields
        [String]$Subject,
        [String]$Description,
        [String]$State,
        [String]$Type,
        [String]$Priority,
        [String]$Team,
        [String]$Username,
        [String]$Displayname,
        [String]$Email,
        [String]$AgentUsername,
        [String]$AgentEmail,
        [String]$Subscribers,
        [String]$Unsubscribers,
        [Bool]$FollowUp,
        [Int]$FollowUpDuration,
        [DateTime]$FollowupDate,
        [Bool]$Unassign,
        [Bool]$Personal
    )

     # Base parameters for url
    $params = @{
        action      = 'EditTicket'
        TicketID = $TicketID
    }
    
    # Add optional parameters if used
    if($Subject)          {$params.Subject          = $Subject}
    if($Description)      {$params.Description      = $Description}
    if($State)            {$params.State            = $State}
    if($Type)             {$params.Type             = $Type}
    if($Priority)         {$params.Priority         = $Priority}
    if($Team)             {$params.Team             = $Team}
    if($Username)         {$params.Username         = $Username}
    if($Displayname)      {$params.Displayname      = $Displayname}
    if($Email)            {$params.Email            = $Email}
    if($AgentUsername)    {$params.AgentUsername    = $AgentUsername}
    if($AgentEmail)       {$params.AgentEmail       = $AgentEmail}
    if($Subscribers)      {$params.Subscribers      = $Subscribers}
    if($Unsubscribers)    {$params.Unsubscribers    = $Unsubscribers}
    if($FollowUp)         {$params.FollowUp         = $FollowUp}
    if($FollowUpDuration) {$params.FollowUpDuration = $FollowUpDuration}
    if($FollowUpDate)     {$params.FollowUpDate     = $FollowUpDate}
    if($Unassign)         {$params.Unassign         = $Unassign}
    if($Personal)         {$params.Personal         = $Personal}

    # Building query string
    $queryString = ($params.GetEnumerator() | ForEach-Object {
        '{0}={1}' -f [uri]::EscapeDataString($_.Key), [uri]::EscapeDataString([string]$_.Value)
    }) -join '&'
    $fullUrl = '{0}{1}' -f $Url, $queryString

    # Edit ticket using the api
    $Request = Invoke-WebRequest -Uri $fullUrl -UseBasicParsing
    
    # Checking response
    if($Request.StatusCode -ne 200) {
        throw ("{0} {1}" -f $Request.StatusCode, $Request.StatusDescription)
    }
    if(($Request.Content | ConvertFrom-Json).Success) {
        Write-Host "Ticket has been modified successfully!" -ForegroundColor "Green"
    } else {
        Write-Host "Something went wrong when editing ticket." -ForegroundColor "Red"
        Write-Error $Request.Content
    }

    return ($Request.Content | ConvertFrom-Json)
}