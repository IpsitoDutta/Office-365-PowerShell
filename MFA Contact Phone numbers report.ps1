#Extract MFA Authentication phone number for users

$cred = Get-Credential
Import-Module MsOnline
Connect-MsolService -Credential $cred

get-msoluser -all | ForEach-Object {
$authphone = (Get-MsolUser -userprincipalname $_.userprincipalname).StrongAuthenticationUserDetails.PhoneNumber
$officephone = (Get-MsolUser -UserPrincipalName $_.userprincipalname).PhoneNumber
$mobilephone = (Get-MsolUser -UserPrincipalName $_.userprincipalname).MobilePhone

If ($authphone -ne $null) {
#check if authphone contains officephone or mobilephone
If ($authphone.endswith($officephone) -or $authphone.endswith($mobilephone)) {
Write-Host $_.userprincipalname,"has an consistent auth phone number ",$authphone
}
Else {
Write-Host $_.userprincipalname,"has an inconsistent auth phone number."
get-msoluser -UserPrincipalName $_.userprincipalname | Select-Object userprincipalname,PhoneNumber,MobilePhone,@{name="AuthPhoneNumber";expression={(Get-MsolUser -userprincipalname $_.userprincipalname).StrongAuthenticationUserDetails.PhoneNumber}}| export-csv -path C:\temp\inconsistentusers.csv -Append
