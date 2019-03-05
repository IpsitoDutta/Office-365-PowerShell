
<#
.Synopsis
This commannd allows you to look up time for the 4 major US Time Zone: EST, CST, MST, PST.
.Description
If on a call, you quickly need to look up the time in any one of four US time zones, this command should be handy.
.Example
PS C:\Users\IPSITO> Get-Time -zone est
09 March 2018 11:38:05
.Example
PS C:\Users\IPSITO> Get-Time -zone ist
09 March 2018 22:08:08
.Example
PS C:\Users\IPSITO> Get-Time -zone pst
09 March 2018 08:38:14
.Example
PS C:\Users\IPSITO> Get-Time -zone mst
09 March 2018 09:38:18
.Example
PS C:\Users\IPSITO> Get-Time -zone cst
09 March 2018 10:38:21
.Example
PS C:\Users\IPSITO> gt
cmdlet Get-Time at command pipeline position 1
Supply values for the following parameters:
zone: est
09 March 2018 11:38:59
.Example
PS C:\Users\IPSITO> gt
cmdlet Get-Time at command pipeline position 1
Supply values for the following parameters:
zone: ist
09 March 2018 22:09:03
#>


function Get-EST {
Set-Alias Get-EST -Value EST

$test=get-date
[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId($test, [System.TimeZoneInfo]::Local.Id, "US Eastern Standard Time")
Write-Host ""
}

function Get-CST {
Set-Alias Get-EST -Value CST

$test=get-date
[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId($test, [System.TimeZoneInfo]::Local.Id, "Central Standard Time")
Write-Host ""
}

function Get-MST {
Set-Alias Get-EST -Value MST

$test=get-date
[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId($test, [System.TimeZoneInfo]::Local.Id, "Mountain Standard Time")
Write-Host ""
}

function Get-PST {
Set-Alias Get-EST -Value PST

$test=get-date
[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId($test, [System.TimeZoneInfo]::Local.Id, "Pacific Standard Time")
Write-Host ""
}

function Get-IST {
Set-Alias Get-EST -Value IST

$test=get-date
[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId($test, [System.TimeZoneInfo]::Local.Id, "India Standard Time")
Write-Host ""
}

function Get-GMT {
Set-Alias Get-EST -Value GMT

$test=get-date
[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId($test, [System.TimeZoneInfo]::Local.Id, "UTC")
Write-Host ""
}


function Get-Time {
Set-Alias Get-Time -Value time
Write-Host ""
Write-Host "GMT/UTC"
Write-Host "===================="
$test=get-date
[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId($test, [System.TimeZoneInfo]::Local.Id, "UTC")
Write-Host ""

Write-Host "EST"
Write-Host "===================="
$test=get-date
[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId($test, [System.TimeZoneInfo]::Local.Id, "US Eastern Standard Time")
Write-Host ""

Write-Host "CST"
Write-Host "===================="
$test=get-date
[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId($test, [System.TimeZoneInfo]::Local.Id, "Central Standard Time")
Write-Host ""

Write-Host "MST"
Write-Host "===================="
$test=get-date
[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId($test, [System.TimeZoneInfo]::Local.Id, "Mountain Standard Time")
Write-Host ""

Write-Host "PST"
Write-Host "===================="
$test=get-date
[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId($test, [System.TimeZoneInfo]::Local.Id, "Pacific Standard Time")
Write-Host ""


Write-Host "IST"
Write-Host "===================="
$test=get-date
[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId($test, [System.TimeZoneInfo]::Local.Id, "India Standard Time")
Write-Host ""
}

<#
.Synopsis
This command will help you to convert between the following time zones :IST, EST, PST, MST, CST.
.Description
Often when we have to honor call back requests, appointments, meetings etc. we recieve the request in one time zone whereas we are in another.
Hence this command.
.Example
PS C:\Users\IPSITO> ct
cmdlet Convert-time at command pipeline position 1
Supply values for the following parameters:
time: 21:31
stz: ist
dtz: est
09 March 2018 11:01:00
.Example
PS C:\Users\IPSITO> ct -time 21:31 -stz ist -dtz est
09 March 2018 11:01:00
.Example
PS C:\Users\IPSITO> ct
cmdlet Convert-time at command pipeline position 1
Supply values for the following parameters:
time: 9/3/2018 21:45
stz: ist
dtz: est
03 September 2018 12:15:00
.Example
PS C:\Users\IPSITO> Convert-time -time 21:54 -stz ist -dtz est
09 March 2018 11:24:00
.Parameter STZ
Identifies the source time zone, that the time input belongs to and needs to be converted from.
.Parameter DTZ
Identifies the destination time zone, that the ouput time needs to belong to and needs to be converted to.
.Parameter Time
Identifies the time that the user wants to convert
#>

function Convert-time {
[cmdletbinding()]
param (
    [Parameter(Mandatory=$True,Position=1)]
    [string]$time,
    [Parameter(Mandatory=$True)]
    [string]$stz,
    [Parameter(Mandatory=$True)]
    [string]$dtz
)
Set-Alias CT -Value Convert-time

if ($stz -eq "EST") {
$stz="US Eastern Standard Time"
} else {
if ($stz -eq "CST") {
$stz="Central Standard Time"
} else {
if ($stz -eq "MST") {
$stz="Mountain Standard Time"
} else {
if ($stz -eq "PST") {
$stz="Pacific Standard Time"
} else {
if ($stz -eq "IST") {
$stz="India Standard Time"
} else {
Write-Host "Invaid Input. Please try again." -ForegroundColor Red
}}}}}

if ($dtz -eq "EST") {
$dtz="US Eastern Standard Time"
} else {
if ($dtz -eq "CST") {
$dtz="Central Standard Time"
} else {
if ($dtz -eq "MST") {
$dtz="Mountain Standard Time"
} else {
if ($dtz -eq "PST") {
$dtz="Pacific Standard Time"
} else {
if ($dtz -eq "IST") {
$dtz="India Standard Time"
} else {
Write-Host "Invaid Input. Please try again." -ForegroundColor Red
}}}}}

$source=([system.timezoneinfo]::GetSystemTimeZones() | where { $_.ID -eq $t}).id
$dest=([system.timezoneinfo]::GetSystemTimeZones() | where { $_.ID -eq $c}).id
[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId($time, $stz, $dtz)
}

