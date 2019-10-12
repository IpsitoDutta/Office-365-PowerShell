$MFA=(Get-MsolUser -all|?{$_.StrongAuthenticationMethods -ne $null}).displayname
$Allusers=(Get-MsolUser -all).displayname
$MFADisabledusers=Compare-Object -ReferenceObject $MFA -DifferenceObject $Allusers
Write-Host "============================================================="
Write-Host "Total no: of users"
($Allusers).count
Write-Host "============================================================="
Write-Host "Total no: of users with MFA Enabled"
($MFA).count
Write-Host "============================================================="
Write-Host "Total no: of users with MFA Disabled"
($MFADisabledusers).count
Write-Host "============================================================="
Write-Host "MFA Enabled Users are:"
$MFA
Write-Host "============================================================="
Write-Host "MFA disabled Users are:"
($MFADisabledusers).inputobject
Write-Host "============================================================="