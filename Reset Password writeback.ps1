import-module ADSync
$aadConnectorName = Get-ADSyncConnector|where-object {$_.name -like "*AAD"}
Get-ADSyncAADPasswordResetConfiguration –Connector $aadConnectorName.name
Set-ADSyncAADPasswordResetConfiguration –Connector $aadConnectorName.name –Enable $false
Set-ADSyncAADPasswordResetConfiguration –Connector $aadConnectorName.name –Enable $true
