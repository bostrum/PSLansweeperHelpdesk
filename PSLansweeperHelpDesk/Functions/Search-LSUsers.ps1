
function Search-LSUsers {
    
    Param (
        [Parameter(Mandatory=$true)]
        [String]$Url,

        [Int]$MaxResults,
        [String]$Email,
        [String]$Name,
        [String]$Upn,
        [String]$Username,
        [String]$UserDomain,
        [String]$Description,
        [String]$Address,
        [String]$Telephone,
        [String]$Mobile,
        [String]$Fax,
        [String]$Company,
        [String]$Department
    )
    
    # URL parameter build with used filters only
    $params = @{
        action   = 'SearchUsers'
    }
    if($MaxResults)  {$params.MaxResults  = $MaxResults}
    if($Email)       {$params.Email       = $Email}
    if($Name)        {$params.Name        = $Name}
    if($Upn)         {$params.Upn         = $Upn}
    if($Username)    {$params.Username    = $Username}
    if($UserDomain)  {$params.UserDomain  = $UserDomain}
    if($Description) {$params.Description = $Description}
    if($Address)     {$params.Address     = $Address}
    if($Telephone)   {$params.Telephone   = $Telephone}
    if($Mobile)      {$params.Mobile      = $Mobile}
    if($Fax)         {$params.Fax         = $Fax}
    if($Company)     {$params.Company     = $Company}
    if($Department)  {$params.Department  = $Department}
    
    # Building query string
    $queryString = ($params.GetEnumerator() | ForEach-Object {
        '{0}={1}' -f [uri]::EscapeDataString($_.Key), [uri]::EscapeDataString([string]$_.Value)
    }) -join '&'
    $fullUrl = '{0}{1}' -f $Url, $queryString
    
    # API call for user search
    $Request = Invoke-WebRequest -Uri $fullUrl -UseBasicParsing
    
    # Checking HTTP response
    if($Request.StatusCode -ne 200) {
        throw ("{0} {1}" -f $Request.StatusCode, $Request.StatusDescription)
    }
    
    # Success check
    $Data = ($Request.Content | ConvertFrom-Json)
    if(-not $Data.Success) {
        Write-Error "Search was not successful."
        return $Request
    } else {
        return $Data
    }
}
