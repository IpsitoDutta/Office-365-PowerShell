cls

$alternateemail = Read-Host -Prompt "Enter an external alternate email address for the test global admin" 
$SecurePassword = Read-Host -Prompt "Enter the password of the new test account (8-16 characters strong)"
$tenant=(Get-Msoldomain |? {$_.isinitial -eq "True"}).name
$upn="test_GA@"+$tenant

Write-Host "Checking if such a user already exists..."

$dupecheck1=(Get-MsolUser -All | ? {$_.userprincipalname -match "$upn"}).count
$dupecheck2=(Get-MsolUser -All -ReturnDeletedUsers | ? {$_.userprincipalname -match "$upn"}).count

If ($dupecheck1 = 0) {

Write-Host "No duplicate active users found, checking the deleted users container"

If ($dupecheck2 = 0) {

Write-Host "No duplicate deleted users found, creating the new test account"

New-MsolUser -UserPrincipalName $upn -DisplayName "test GA" -FirstName "test" -LastName "GA" -PasswordNeverExpires $true -AlternateEmailAddresses $alternateemail -Password $SecurePassword -ForceChangePassword $false -StrongPasswordRequired $false -InformationAction SilentlyContinue
Add-MsolRoleMember -RoleName "Company Administrator" -RoleMemberEmailAddress $upn
$finaluser=(Get-MsolUser -UserPrincipalName $upn).UserPrincipalName
$finalrole=(Get-MsolUserRole -UserPrincipalName $upn).Name
write-host "The user created is $finaluser and the user role is $finalrole" -ForegroundColor green

} else {

Write-Host "Duplicate deleted user found, creating the new test account and prepending it with a random no:"

$rand=Get-Random
$newupn="$rand+$upn"
New-MsolUser -UserPrincipalName $newupn -DisplayName "test GA" -FirstName "test" -LastName "GA" -PasswordNeverExpires $true -AlternateEmailAddresses $alternateemail -Password $SecurePassword -ForceChangePassword $false -StrongPasswordRequired $false -InformationAction SilentlyContinue
Add-MsolRoleMember -RoleName "Company Administrator" -RoleMemberEmailAddress $upn
write-host "The user created is  and the user role is Company Administrator" -ForegroundColor green
}
} else {

Write-Host "Duplicate active user found, creating the new test account and prepending it with a random no:"

$rand=Get-Random
$newupn="$rand+$upn"
New-MsolUser -UserPrincipalName $newupn -DisplayName "test GA" -FirstName "test" -LastName "GA" -PasswordNeverExpires $true -AlternateEmailAddresses $alternateemail -Password $SecurePassword -ForceChangePassword $false -StrongPasswordRequired $false -InformationAction SilentlyContinue
Add-MsolRoleMember -RoleName "Company Administrator" -RoleMemberEmailAddress $newupn
write-host "The user created is  and the user role is Company Administrator" -ForegroundColor green

}


