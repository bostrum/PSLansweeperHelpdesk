# Introduction
PowerShell module for Lansweeper Helpdesk ticket system. Provides functions for fetching data from tickets, creating or editing tickets, adding notes or searching for tickets. Can be used for different integrations from and to other systems. Automated reminders, SMS-notifications on high priority tickets, automated tickets from monitoring, third-strike closing, ticket reporting, finding similarities between new and old tickets.. and more!

Note: This is not an official or supported Lansweeper module.

## Prerequisites
1. Browse to your Lansweeper instance and go to /Configuration/Api/HelpdeskApi.aspx
2. Click on 'Add API key', set a name and copy the key.
3. Save this key as a .secret file or save in your password manager for later manual use.

## Installation
### Manual
1. Download this repository.
2. Copy the PSLansweeperHelpDesk folder to C:\Windows\System32\WindowsPowerShell\v1.0\Modules.
3. Start PowerShell and run 'Import-Module PSLansweeperHelpDesk".

## Examples
Start by creating your secret URL which will be used in all functions making the API calls:
```powershell
Import-Module PSLansweeperHelpDesk
$SecretUrl = New-LansweeperAuthUrl -Server "lansweeper.yourdomain.com" -SecretPath ".secret"
# or
$SecretUrl = New-LansweeperAuthUrl -Server "lansweeper.yourdomain.com" -Secret "1234-12-12-12-1234"
```
