# write by Jay
Write-Host "Run as administrator!!!"
$undervolt = Read-Host 'volt Settings in mV '
$watt = Read-Host 'Long Boost Settings in Watts '
$bostwatt = Read-Host 'Short Boost Settings in Watts '
$bosttime = Read-Host 'Boost Time Settings in seconds '

$xtu='C:\Program Files (x86)\Intel\Intel(R) Extreme Tuning Utility\Client\XtuCLI.exe'
#$timespan=New-TimeSpan -Start 00:00:10 -End 00:00:15
$taskt0=New-JobTrigger -AtLogOn
$taskt=New-JobTrigger -AtLogOn -RandomDelay 00:00:10

$arg1='-t -id 34 -v '+$undervolt
$arg2='-t -id 48 -v '+$watt
$arg3='-t -id 47 -v '+$bostwatt
$arg4='-t -id 66 -v '+$bosttime

$elevat = New-ScheduledJobOption -RunElevated

$task1=New-ScheduledTaskAction -Execute $xtu -Argument $arg1
$task2=New-ScheduledTaskAction -Execute $xtu -Argument $arg2
$task3=New-ScheduledTaskAction -Execute $xtu -Argument $arg3
$task4=New-ScheduledTaskAction -Execute $xtu -Argument $arg4
$Scriptblock={
    Start-ScheduledTask -TaskName "volt"
    Start-ScheduledTask -TaskName "watt"
    Start-ScheduledTask -TaskName "bostwatt"
    Start-ScheduledTask -TaskName "bosttime"
}

Register-ScheduledJob -Name "xtus" -ScriptBlock {Start-Service XTU3SERVICE} -ScheduledJobOption $elevat -Trigger $taskt0 | Out-Null
Register-ScheduledTask -TaskName "volt"  -RunLevel Highest -Action $task1 | Out-Null
Register-ScheduledTask -TaskName "watt"  -RunLevel Highest -Action $task2 | Out-Null
Register-ScheduledTask -TaskName "bostwatt"  -RunLevel Highest -Action $task3 | Out-Null
Register-ScheduledTask -TaskName "bosttime"  -RunLevel Highest -Action $task4 | Out-Null
Register-ScheduledJob -Name "xtu" -ScriptBlock $Scriptblock -ScheduledJobOption $elevat -Trigger $taskt | Out-Null


Start-ScheduledTask -TaskName 'volt' -ErrorAction Inquire
Start-ScheduledTask -TaskName 'watt' -ErrorAction Inquire
Start-ScheduledTask -TaskName 'bostwatt' -ErrorAction Inquire
Start-ScheduledTask -TaskName 'bosttime' -ErrorAction Inquire


Write-Host 'All done!!!'
sleep 3