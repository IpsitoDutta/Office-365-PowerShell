#Check for host name, hotfixes installed, RAM

(Systeminfo).domain


#Check for hard disk sizes

Get-disk |fl

#Check the last time the machine was re-booted

Get-CimInstance Win32_OperatingSystem|select last*

#Check for list of windows updates installed

Get-wmiobject -class win32_quickfixengineering |ft

#Check for domain registration status

$domain=(gwmi win32_computersystem).domain
$domain

nltest /dsgetdc:$domain
   
tnc microsoftonline.com -TraceRoute 

#Find applicable group policies

gpresult /h m:\group

#Check for proxy connections

netsh winhttp show proxy

#Check for open and closed ports

netstat -anob



tnc microsoftonline.com -TraceRoute 

#Check for installed applications
WMIC product get name


Get-NetFirewallRule |? {$_.enabled -match "True"}

|FT displayname, direction, primarystatus, enabled


Need to check the following WMI objects:

Win32_NTDomain 
Win32_Volume 
Win32_OperatingSystem
Win32_ComputerSystem
Win32_DiskDrive
Win32_NTEventlogFile 
Win32_Account
Win32_UserAccount
Win32_Group
Win32_TimeZone
Win32_CurrentTime 
Win32_LocalTime
Win32_UTCTime
Win32_SystemPartitions 
Win32_SystemDevices
Win32_ComputerSystemProcessor 
Win32_NTLogEventUser 

