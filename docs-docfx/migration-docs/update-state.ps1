# Update state to Phase 6
$stateFile = "navigation-migration-state.json"
$state = Get-Content $stateFile | ConvertFrom-Json
$state.phase = 6
$state.completed = $false
if (-not $state.use_cases_migrated) {
    $state | Add-Member -MemberType NoteProperty -Name "use_cases_migrated" -Value @()
}
$state | ConvertTo-Json -Depth 10 | Set-Content $stateFile
Write-Host "State updated to Phase 6"
