
function Edit-LSCustomField {
    
    Param (
        [Parameter(Mandatory=$true)]
        [String]$Url,

        [Parameter(Mandatory=$true)]
        [String]$TicketID,
        
        [Parameter(Mandatory=$true)]
        [String]$CustomFieldName,

        [Parameter(Mandatory = $true, ParameterSetName = 'Value')]
        [string]$CustomFieldValue,

        [Parameter(Mandatory = $true, ParameterSetName = 'Values')]
        [string]$CustomFieldValues,

        [Parameter(Mandatory = $true, ParameterSetName = 'JSON')]
        [string]$CustomFieldJSON
    )
    
    # Checking value type used
    $FieldValue = if($PSCmdlet.ParameterSetName -eq 'Value') {
        "CustomFieldValue=$CustomFieldValue"
    } elseif($PSCmdlet.ParameterSetName -eq 'Values') {
        "CustomFieldValues=$CustomFieldValues"
    } elseif($PSCmdlet.ParameterSetName -eq 'JSON') {
        "CustomFieldJSON=$CustomFieldJSON"
    }
    
    # API call to edit custom field
    $Url = ($Url + "action=EditTicketCustomField&" + "TicketID=$TicketID&" + "CustomFieldName=$CustomFieldName&" + $FieldValue) 
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
        Write-Error "Editing custom field failed, check output message."
        return $Data
    }
}
