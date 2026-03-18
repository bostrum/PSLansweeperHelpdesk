
function Remove-LSCustomField {
    
    Param (
        [Parameter(Mandatory=$true)]
        [String]$Url,

        [Parameter(Mandatory=$true)]
        [String]$TicketID,
        
        [Parameter(Mandatory=$true)]
        [String]$CustomFieldName
    )

    # API call to remove custom field
    $Url = ($Url + "action=DeleteTicketCustomField&" + "TicketID=$TicketID&" + "CustomFieldName=$CustomFieldName&")
    $Request = Invoke-WebRequest -Uri $Url -UseBasicParsing
    
    # Checking response
    if($Request.StatusCode -ne 200) {
        throw ("{0} {1}" -f $Request.StatusCode, $Request.StatusDescription)
    }
    
    # Success check and data return
    $Data = $Request.Content | ConvertFrom-Json
    if($Data.Success) {
        return $Data
    } else {
        Write-Error "Removing custom field failed, check output message."
        return $Data
    }
}
