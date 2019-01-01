Enable-PSRemoting -Force
Set-ExecutionPolicy RemoteSigned -Force
$UserCredential = Get-Credential 
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection 
$SecSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session
Import-PSSession $SecSession
Connect-Msolservice -Credential $UserCredential
connect-azuread -Credential $UserCredential
connect-sposervice -url https://ipsito-admin.sharepoint.com -Credential $UserCredential
Import-Module SkypeOnlineConnector
$sfbSession = New-CsOnlineSession -Credential $UserCredential 
Import-PSSession $sfbSession
cls



