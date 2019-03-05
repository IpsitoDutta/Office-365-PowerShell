Write-host ""
$svc=Read-Host "Please enter the federation service name"
Write-host ""
Write-host ""
"ADFS IDP intiated Link" 
Write-host "https://$svc/adfs/ls/IdpInitiatedSignon.aspx" -ForegroundColor DarkGreen
Write-host ""
Write-host ""
"ADFS Metadata URL"
Write-host "https://$svc/federationmetadata/2007-06/federationmetadata.xml" -ForegroundColor DarkGreen
Write-host ""
Write-host ""
"ADFS Mex URL"
Write-host "https://$svc/adfs/services/trust/mex" -ForegroundColor DarkGreen

Write-host ""
Write-host ""
$port80=((Test-NetConnection -ComputerName $svc -Port 80).tcptestsucceeded)
$port443=((Test-NetConnection -ComputerName $svc -Port 43).tcptestsucceeded)
Write-host ""
Write-host ""
if ($port80 -match "True") {
Write-host "Port 80 seems to be open to the Internet"-ForegroundColor Green}
Else {
Write-host "Port 80 seems to be closed to the Internet" -ForegroundColor Red }
Write-host ""
Write-host ""
if ($port443 -match "True") {
Write-host "Port 443 seems to be open to the Internet" -ForegroundColor Green}
Else {
Write-host "Port 443 seems to be closed to the Internet" -ForegroundColor Red}
Write-host ""
Write-host ""




