
function Add-LSTicket {
    
    Param (
        [Parameter(Mandatory=$true)][String]$Url,
        [Parameter(Mandatory=$true)][String]$Subject,
        [Parameter(Mandatory=$true)][String]$Description,

        # Non-mandatory fields
        [String]$Type,
        [String]$Priority,
        [String]$Team,
        [String]$Username,
        [String]$Displayname,
        [String]$Email,
        [String]$AgentUsername,
        [String]$AgentEmail,
        [DateTime]$Date,
        [Bool]$AgentInitiated,
        [Bool]$Personal,
        [String]$CustomFields, # Example: {"customFields":[{"name":"customField","value":"Text value here"}]}
        [String]$Files
    )

     # Base parameters for url
    $params = @{
        action      = 'AddTicket'
        Subject     = $Subject
        Description = $Description
    }
    
    # Add optional parameters if used
    if($Type)           {$params.Type           = $Type}
    if($Priority)       {$params.Priority       = $Priority}
    if($Team)           {$params.Team           = $Team}
    if($Username)       {$params.Username       = $Username}
    if($Displayname)    {$params.Displayname    = $Displayname}
    if($Email)          {$params.Email          = $Email}
    if($AgentUsername)  {$params.AgentUsername  = $AgentUsername}
    if($AgentEmail)     {$params.AgentEmail     = $AgentEmail}
    if($Date)           {$params.Date           = $Date}
    if($AgentInitiated) {$params.AgentInitiated = $AgentInitiated}
    if($Personal)       {$params.Personal       = $Personal}
    if($CustomFields)   {$params.CustomFields   = $CustomFields}
    if($Files)          {$params.Files          = $Files}

    # Building query string
    $queryString = ($params.GetEnumerator() | ForEach-Object {
        '{0}={1}' -f [uri]::EscapeDataString($_.Key), [uri]::EscapeDataString([string]$_.Value)
    }) -join '&'
    $fullUrl = '{0}{1}' -f $Url, $queryString

    # Creating ticket using the api
    $Request = Invoke-WebRequest -Uri $fullUrl -UseBasicParsing
    
    # Checking response
    if($Request.StatusCode -ne 200) {
        throw ("{0} {1}" -f $Request.StatusCode, $Request.StatusDescription)
    }
    if(($Request.Content | ConvertFrom-Json).Success) {
        Write-Host "Ticket has been created successfully!" -ForegroundColor "Green"
    } else {
        Write-Host "Something went wrong when creating ticket." -ForegroundColor "Red"
        Write-Error $Request.Content
    }

    return ($Request.Content | ConvertFrom-Json)
}