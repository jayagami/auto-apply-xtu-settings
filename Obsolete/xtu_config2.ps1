# 降压：-undervolt;平均功耗：-watt;瞬时功耗：-bostwatt;瞬时时间：-boottime
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

$task=($tas1),($task2),($task3),($task4)

Register-ScheduledTask -TaskName "xtuc"  -RunLevel Highest -Action $task4 -Trigger $taskt