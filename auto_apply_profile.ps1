# writen by Jay
#write-center
function Write-HostCenter { param($Message) Write-Host ("{0}{1}" -f (' ' * (([Math]::Max(0, $Host.UI.RawUI.BufferSize.Width / 2) - [Math]::Floor($Message.Length / 2)))), $Message) -ForegroundColor Gray}

Write-HostCenter "***XTU-AUTO-APPLY by J***"
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$ifadmin=$currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if ($true -ne $ifadmin) {
    Write-Host  "Please run with administrator privileges!!!" -BackgroundColor Red
    Start-Sleep 5
    exit 1
}
# remove last settings
$taskName = "autoxtu"
$jobname = "xtus"
$taskExists = Get-ScheduledTask | Where-Object {$_.TaskName -like $taskName }
$JobExists = Get-ScheduledJob | Where-Object {$_.Name -like $jobname }
if($taskExists) {
    Unregister-ScheduledTask -TaskName autoxtu -Confirm:$false | Out-Null
}
if ($JobExists) {
    Unregister-ScheduledJob -Name xtus -Confirm:$false | Out-Null
    Write-Host "Old settings removed!" -BackgroundColor Blue
    Start-Sleep 3
}

# set new profile
Write-Host 'input xtu profile name' -ForegroundColor Yellow -NoNewline
$profilename = Read-Host ' ' 

$ps="C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe"
$scriptblock="-NoLogo -NonInteractive -WindowStyle Hidden -Command `"[System.Reflection.Assembly]::LoadFrom('C:\Program Files (x86)\Intel\Intel(R) Extreme Tuning Utility\Client\ProfilesApi.dll') ;[ProfilesApi.XtuProfileReturnCode]`$applyProfileResult = 0; `$profileApi = [ProfilesApi.XtuProfiles]::new() ; `$profileApi.Initialize() ;  [ProfilesApi.XtuProfileReturnCode]`$result = 0 ; `$profiles = `$profileApi.GetProfiles([ref] `$result) ; `$profile0 = `$profiles | Where-Object { `$_.ProfileName -eq '$profilename' } | Select-Object -First 1 ; if (`$profile0) {`$applied=`$profileApi.ApplyProfile(`$profile0.ProfileID, [ref]`$applyProfileResult) ; if (`$applied) {Write-Host '`$applyProfileResult. Profile applied'} else { Write-Host '`$applyProfileResult. Profile not applied.'}}`""

$task=New-ScheduledTaskAction  -Execute $ps -Argument $scriptblock
$stets=New-ScheduledTaskSettingsSet -Hidden
Register-ScheduledTask -TaskName "autoxtu" -RunLevel Highest -Settings $stets -Action $task | Out-Null


# add a trigger, just want to hide trigger under ps
$taskt0=New-JobTrigger -AtLogOn
$elevat = New-ScheduledJobOption -RunElevated
Register-ScheduledJob -Name "xtus" -ScriptBlock {Start-ScheduledTask -TaskName autoxtu} -ScheduledJobOption $elevat -Trigger $taskt0 | Out-Null

Write-Host "Done!!!" -BackgroundColor  Green -ForegroundColor Black
Write-HostCenter "***EXITING***"
Start-Sleep 3
