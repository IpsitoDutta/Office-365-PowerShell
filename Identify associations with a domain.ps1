Set-ExecutionPolicy RemoteSigned -Force
$UserCredential = Get-Credential 
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection 
Import-PSSession $Session
Connect-Msolservice -Credential $UserCredential
$domain=Read-Host "Please enter the name of the domain that you are trying to remove"
Get-MsolUser -DomainName $domain -All|fl *userprincipalname*, *proxyaddress*, *email*
Get-MsolUser -DomainName $domain -ReturnDeletedUsers -All|fl *userprincipalname*, *proxyaddress*, *email*
Get-MsolContact -All|? {$_.EmailAddress -match $domain}|fl *proxyaddress*, *email*
Get-MsolGroup -All|? {$_.EmailAddress -match $domain}|fl *proxyaddress*, *email*
Get-Recipient -ResultSize unlimited| ? {$_.EmailAddresses -match $domain} | fl Name, RecipientType, EmailAddresses
Get-DistributionGroup -ResultSize unlimited|? {$_.EmailAddress -match $domain}|fl *proxyaddress*, *email*
Get-User -ResultSize unlimited|? {$_.WindowsEmailAddress -match $domain}|fl *proxyaddress*, *email*
Get-Group -ResultSize unlimited|? {$_.WindowsEmailAddress -match $domain}|fl *proxyaddress*, *email*
