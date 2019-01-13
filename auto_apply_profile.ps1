# writen by Jay
$taskName = "autoxtu"
$taskExists = Get-ScheduledTask | Where-Object {$_.TaskName -like $taskName }
if($taskExists) {
    Unregister-ScheduledTask -TaskName autoxtu -Confirm:$false
    "Old settings removed!"
    Start-Sleep 3
}

$profilename = Read-Host 'imput xtu profile name '


$ps="C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe"
$scriptblock="[System.Reflection.Assembly]::LoadFrom('C:\Program Files (x86)\Intel\Intel(R) Extreme Tuning Utility\Client\ProfilesApi.dll') ;[ProfilesApi.XtuProfileReturnCode]`$applyProfileResult = 0; `$profileApi = [ProfilesApi.XtuProfiles]::new() ; `$profileApi.Initialize() ;  [ProfilesApi.XtuProfileReturnCode]`$result = 0 ; `$profiles = `$profileApi.GetProfiles([ref] `$result) ; `$profile0 = `$profiles | Where-Object { `$_.ProfileName -eq '$profilename' } | Select-Object -First 1 ; if (`$profile0) {`$applied=`$profileApi.ApplyProfile(`$profile0.ProfileID, [ref]`$applyProfileResult) ; if (`$applied) {Write-Host '`$applyProfileResult. Profile applied'} else { Write-Host '`$applyProfileResult. Profile not applied.'}}"

$task=New-ScheduledTaskAction  -Execute $ps -Argument $scriptblock
$stets=New-ScheduledTaskSettingsSet -Hidden
$Time = New-ScheduledTaskTrigger -AtLogOn 
Register-ScheduledTask -TaskName "autoxtu" -Trigger $Time -RunLevel Highest -Settings $stets -Action $task | Out-Null

Write-Host "Done!!!You should check your profile name if not working!"
sleep 3
