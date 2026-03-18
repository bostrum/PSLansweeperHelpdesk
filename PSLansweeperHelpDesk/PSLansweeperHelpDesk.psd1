@{
    RootModule        = "PSLansweeperHelpDesk.psm1"
    ModuleVersion     = "1.0.0"
    GUID              = "d55622ec-6709-4eab-9935-8b520f9bb640"
    Author            = "Felix Boström"
    CompanyName       = ""
    Copyright         = ""
    FunctionsToExport = @(
        "Add-LSAsset",
        "Add-LSNote",
        "Add-LSTicket",
        "Edit-LSCustomField",
        "Edit-LSTicket",
        "Get-LSAssets",
        "Get-LSNotes",
        "Get-LSTicket",
        "New-LansweeperAuthUrl",
        "Remove-LSAsset",
        "Remove-LSCustomField",
        "Search-LSTickets",
        "Search-LSUsers"
    )
    CmdletsToExport   = @()
    VariablesToExport = @()
    AliasesToExport   = @()
}
