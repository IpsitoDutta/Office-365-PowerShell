Import-Module ADSync
$adConnector = "domain.com" 
$aadConnector = “domain.onmicrosoft.com - AAD” 

Set-ADSyncAADPasswordSyncState -ConnectorName $aadConnector –Enable $False
Set-ADSyncAADPasswordSyncConfiguration -SourceConnector $adConnector -TargetConnector $aadConnector -Enable $False

get-ADSyncAADPasswordSyncConfiguration -sourceconnector $adConnector 

Set-ADSyncAADPasswordSyncState -ConnectorName $aadConnector –Enable $true
Set-ADSyncAADPasswordSyncConfiguration -SourceConnector $adConnector -TargetConnector $aadConnector -Enable $true

get-ADSyncAADPasswordSyncConfiguration -sourceconnector $adConnector 
