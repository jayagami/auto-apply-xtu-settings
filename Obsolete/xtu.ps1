param (
    [int]$undervolt=$(throw "Parameter missing: -undervolt") ,
    [int]$watt=$(throw "Parameter missing: -watt") ,
    [int]$bostwatt=$(throw "Parameter missing: -bostwatt") ,
    [int]$bosttime=$(throw "Parameter missing: -bosttime")
)
$xtu='C:\Program Files (x86)\Intel\Intel(R) Extreme Tuning Utility\Client\XtuCLI.exe'
$taskt=New-ScheduledTaskTrigger -AtLogOn

$arg1='-t -id 34 -v '+$undervolt
$arg2='-t -id 48 -v '+$watt
$arg3='-t -id 47 -v '+$bostwatt
$arg4='-t -id 66 -v '+$bosttime

$task1=New-ScheduledTaskAction -Execute $xtu -Argument $arg1
$task2=New-ScheduledTaskAction -Execute $xtu -Argument $arg2
$task3=New-ScheduledTaskAction -Execute $xtu -Argument $arg3
$task4=New-ScheduledTaskAction -Execute $xtu -Argument $arg4


Register-ScheduledTask -TaskName "volt"  -RunLevel Highest -Action $task1 -Trigger $taskt
Register-ScheduledTask -TaskName "watt"  -RunLevel Highest -Action $task2 -Trigger $taskt
Register-ScheduledTask -TaskName "bostwatt"  -RunLevel Highest -Action $task3 -Trigger $taskt
Register-ScheduledTask -TaskName "bosttime"  -RunLevel Highest -Action $task4 -Trigger $taskt