Write-Host "
=====================================================================
|            Welcome to Office 365 DNS Readyness Check              |                    
|                            -Designed by Ipsito Dutta              | 
=====================================================================

******************************************************************************************
Please be informed that this script can only run on Windows 8/Server 2012 R2 and above
******************************************************************************************

" -ForegroundColor DarkGreen

$domain=Read-Host "Enter domain name" 

#NS test
Write-Host ""
Write-Host "
===========================
|Running Name Server check|
===========================" -ForegroundColor DarkCyan
Write-Host ""
$ns=((Resolve-DnsName -Name $domain -Type NS).namehost)
Write-Host "Currently it points to:" 
Write-Host ""
$ns
Write-Host ""
if ($ns -match "bdm.microsoftonline.com") {
Write-Host "The NS records for the domain is managed by Office 365" -ForegroundColor Green
} Else {
Write-Host "The NS records for the domain is not managed by Office 365" -ForegroundColor Red
}


#Autodiscover Test

Write-Host ""
Write-Host "
============================
|Running Autodiscover check|
============================" -ForegroundColor DarkCyan
Write-Host ""

Write-Host ""
Write-Host "Currently it points to:"
$autod = "autodiscover"+"."+$domain
$value=((Resolve-DnsName -Name $autod -Type CNAME -ErrorAction SilentlyContinue).namehost)
Write-Host ""
$value
Write-Host ""

if ($value -match "autodiscover.outlook.com") {
Write-Host "Autodiscover is pointing to Office 365" -ForegroundColor DarkGreen
} Else {
Write-Host "Autodiscover is not pointing to Office 365" -ForegroundColor Red
}

#MX Test

Write-Host ""
Write-Host "
==================
|Running MX check|
==================" -ForegroundColor DarkCyan
Write-Host ""
$name=((Resolve-DnsName -Name $domain -Type mx -ErrorAction SilentlyContinue).nameexchange)
Write-Host "Current Value is:" 
Write-Host ""
$name

Write-Host ""
if ($name -match ".mail.protection.outlook.com") {
Write-Host "MX record is pointing to Office 365" -ForegroundColor DarkGreen
} Else {
Write-Host "MX record is not pointing to Office 365" -ForegroundColor Red
}


#SPF
Write-Host ""
Write-Host "
===================
|Running SPF check|
===================" -ForegroundColor DarkCyan
$value=((Resolve-DnsName -Name $domain -Type txt|?{$_.strings -match "spf.protection.outlook.com"}).strings)



if ($value -match "spf.protection.outlook.com") {
Write-Host ""
Write-Host "Office 365 SPF record found" -ForegroundColor DarkGreen
Write-Host ""
Write-Host "Current Value is:" $value
Write-Host ""
} else {
Write-Host ""
Write-Host "Office 365 SPF record not found" -ForegroundColor Red
}


#DKIM
Write-Host ""
Write-Host "
====================
|Running DKIM check|
====================
" -ForegroundColor DarkCyan
Write-Host ""
$new=($domain -replace "\W", "-")

$DKIM1=("selector1._domainkey."+$domain)
$DKIM2=("selector2._domainkey."+$domain)

$DKIMvalue1=(".onmicrosoft.com")

$namehost1=(Resolve-DnsName -Name $dkim1 -Type cname -ErrorAction SilentlyContinue| select namehost)
$namehost2=(Resolve-DnsName -Name $dkim2 -Type cname -ErrorAction SilentlyContinue| select namehost)

if ($namehost1 -contains $DKIMvalue1 -and $namehost2 -contains $DKIMvalue1) {
Write-Host "Office 365 DKIM records found" -ForegroundColor DarkGreen
Write-Host ""
Write-Host "Results for DKIM query show" -ForegroundColor DarkYellow
Write-Host ""
$msg=(Write-Host "No Office 365 DKIM records found" -ForegroundColor DarkRed)
Write-Host ""
Resolve-DnsName -Name $dkim1 -Type cname -ErrorVariable $msg -ErrorAction SilentlyContinue| select namehost
Write-Host ""
Resolve-DnsName -Name $dkim2 -Type cname -ErrorVariable $msg -ErrorAction SilentlyContinue| select namehost
} Else {
Write-Host "DKIM records not found" -ForegroundColor Red
}


#DMARC
Write-Host ""
Write-Host "
====================
|Running DMRAC check|
====================
" -ForegroundColor DarkCyan
$dmarc=((Resolve-DnsName -Name "_dmarc.$domain" -Type txt -ErrorAction SilentlyContinue).strings)
Write-Host ""
if ($dmarc-match "v=DMARC1; p") {

Write-Host "DMARC Record found" -ForegroundColor Darkgreen
Write-Host ""
Write-Host "Current Value is:"
Write-Host ""
(Resolve-DnsName -Name "_dmarc.$domain" -Type txt -ea SilentlyContinue).strings
Write-Host ""

} else {
Write-Host "DMARC Record not found" -ForegroundColor  red
Write-Host ""
}

#Export data

$confirm=Read-Host  "Would you like to get the unedited version of DNS records query? Please know that this will show errors if any for the dns query. (Y/N)"
Write-Host ""
if ($confirm -match "Y") {

Write-Host "
Name Server DNS records are:
============================
" -ForegroundColor Magenta 
Write-Host ""
$NameServer=(Resolve-DnsName -Name $domain -Type NS)
$NameServer
Write-Host ""


Write-Host "
Autodiscover records are:
=========================
" -ForegroundColor DarkMagenta
Write-Host ""
$autodiscover=(Resolve-DnsName -Name $autod -Type CNAME -ErrorAction SilentlyContinue)
$autodiscover
Write-Host ""


Write-Host "
MX records are:
================
" -ForegroundColor DarkMagenta
Write-Host ""
$Mailexchanger=(Resolve-DnsName -Name $domain -Type mx -ErrorAction SilentlyContinue)
$Mailexchanger
Write-Host ""


Write-Host "
SPF records are:
================
" -ForegroundColor DarkMagenta
Write-Host ""
$spfrecord=(Resolve-DnsName -Name $domain -Type txt|?{$_.strings -match "spf.protection.outlook.com"})
$spfrecord
Write-Host ""


Write-Host "
DKIM records are:
=================
" -ForegroundColor DarkMagenta
Write-Host ""
$domainkey1=(Resolve-DnsName -Name $dkim1 -Type cname -ErrorAction SilentlyContinue)
$domainkey2=(Resolve-DnsName -Name $dkim2 -Type cname -ErrorAction SilentlyContinue)
$domainkey1
$domainkey2
Write-Host ""


Write-Host "
DMARC records are:
==================
" -ForegroundColor DarkMagenta
Write-Host ""
$dmarcrecord=(Resolve-DnsName -Name "_dmarc.$domain" -Type txt -ea SilentlyContinue)
$dmarcrecord
Write-Host ""
} else {
Write-host "Done!" -ForegroundColor Green
}
Write-Host ""

#Additional notes

Write-Host "
================================================================================================================================================================================================================================
Additional  Information: 																						                                                                                                     			
																												                                                                                                                
Please see the article below for additional information about DNS records needed for domain delegation:															                                                            	
																													                                                                                                        
https://support.office.com/en-us/article/Change-nameservers-to-set-up-Office-365-with-any-domain-registrar-a8b487a9-2a45-4581-9dc4-5d28a47010a2										                                        
																												                                                                                                                
Please see the article below for additional DNS records needed for Office 365  work loads. Please note the article below is for partially delegated domains with Go daddy. For Other DNS registrars, please search internet:	
																												                                                                                                                
https://support.office.com/en-us/article/Create-DNS-records-at-GoDaddy-for-Office-365-F40A9185-B6D5-4A80-BB31-AA3BB0CAB48A#bkmk_add_mx												                                            
================================================================================================================================================================================================================================
" -ForegroundColor DarkGreen


