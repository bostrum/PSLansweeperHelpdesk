
function Search-LSTickets {
    
    Param (
        [Parameter(Mandatory=$true)]
        [String]$Url,

        [Int]$MaxResults,
        [String]$State,
        [String]$Priority,
        [Int]$FromUserId,
        [Int]$AgentId,
        [Bool]$Flagged,
        [DateTime]$MinDate,
        [DateTime]$MaxDate,
        [String]$Description,
        [String]$Subject,
        [String]$Type
    )

     # Base parameters for url
    $params = @{
        action   = 'SearchTickets'
    }
    
    # Add optional search filters if used
    if($MaxResults)  {$params.MaxResults = $MaxResults}
    if($State)       {$params.State = $State}
    if($Priority)    {$params.Priority = $Priority}
    if($FromUserId)  {$params.FromUserId = $FromUserId}
    if($AgentId)     {$params.AgentId = $AgentId}
    if($Flagged)     {$params.Flagged = $Flagged}
    if($MinDate)     {$params.MinDate = $MinDate}
    if($MaxDate)     {$params.MaxDate = $MaxDate}
    if($Description) {$params.Description = $Description}
    if($Subject)     {$params.Subject = $Subject}
    if($Type)        {$params.Type = $Type}

    # Building query string
    $queryString = ($params.GetEnumerator() | ForEach-Object {
        '{0}={1}' -f [uri]::EscapeDataString($_.Key), [uri]::EscapeDataString([string]$_.Value)
    }) -join '&'
    $fullUrl = '{0}{1}' -f $Url, $queryString

    # Search for tickets using filters in parameter
    $Request = Invoke-WebRequest -Uri $fullUrl -UseBasicParsing
    
    # Checking response
    if($Request.StatusCode -ne 200) {
        throw ("{0} {1}" -f $Request.StatusCode, $Request.StatusDescription)
    }
    if(-not (($Request.Content | ConvertFrom-Json).Success)) {
        Write-Error "Search was not successful."
        return $Request
    }

    return ($Request.Content | ConvertFrom-Json)
}