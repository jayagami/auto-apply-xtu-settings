# remove xtu config
Set-PSDebug -Off
Unregister-ScheduledJob -Name xtus -Confirm:$false |Out-Null
Unregister-ScheduledJob -Name xtu -Confirm:$false |Out-Null
Unregister-ScheduledTask -TaskName volt -Confirm:$false |Out-Null
Unregister-ScheduledTask -TaskName watt -Confirm:$false |Out-Null
Unregister-ScheduledTask -TaskName bostwatt -Confirm:$false |Out-Null
Unregister-ScheduledTask -TaskName bosttime -Confirm:$false |Out-Null

Write-Host "Removed!"

sleep 3