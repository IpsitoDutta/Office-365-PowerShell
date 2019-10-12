$st = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
$st.RelyingParty = "*"
$st.State = “Enabled”
$sta = @($st)
Set-MsolUser -UserPrincipalName $_.userprincipalname -StrongAuthenticationRequirements $sta
}
}
Else {
write-host $_.userprincipalname,"does not have an auth phone number."
get-msoluser -UserPrincipalName $_.userprincipalname | Select-Object userprincipalname,PhoneNumber,MobilePhone | export-csv -path C:\temp\noauthphonenumber.csv -Append
}
}
