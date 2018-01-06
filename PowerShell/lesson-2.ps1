"my new string"

Get-Date
(Get-Date)

"myobj1","myobj2",(Get-Date),362,(Get-Host),"myobj3"

#New-Item -ItemType File
#New-Item -ItemType Directory
#New-Item -ItemType SymbolicLink
#New-Item -ItemType Junction
#New-Item -ItemType HardLink

New-Item -Path alias:np -Value notepad

Get-Process | sort cpu | more

Get-Host | Get-Member
Get-Member -InputObject (Get-Date)
Get-Date | Get-Member -MemberType Properties
Get-Date | Get-Member -MemberType Property
Get-Process | Get-Member | more
Get-WmiObject -Class win32_process | Get-Member | more

(Get-Date).GetType()
("test").GetType()
(5).GetType()

("a","b","c").Length
("a","b","c").Count

(Get-Date).DayOfWeek
(Get-Date).DayOfWeek | Get-Member

Get-Process powershell
Get-Process powershell | Format-List *
(Get-Process powershell).StartInfo
(Get-Process powershell).StartInfo.EnvironmentVariables

(gwmi -Class win32_process).GetOwner()
(gwmi -Class win32_process).GetOwner().usee