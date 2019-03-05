function convertto-immutableid {
[cmdletbinding()]
param (
    [Parameter(Mandatory=$True,Position=1)]
    [string]$objectguid
)    

[system.convert]::ToBase64String((new-object system.guid("$objectguid")).ToByteArray())
}
function convertto-objectguid {
[cmdletbinding()]
param (
    [Parameter(Mandatory=$True,Position=1)]
    [string]$immutableid
)    

new-object -TypeName system.guid -ArgumentList (,[system.convert]::FromBase64String($immutableid))
}
set-alias cvtimmu -Value convertto-immutableid
set-alias cvtguid -Value convertto-objectguid

