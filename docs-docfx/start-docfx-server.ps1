# Script to start DocFX server as a background job
param(
    [Parameter(Mandatory=$false)]
    [int]$Port = 8088,
    
    [Parameter(Mandatory=$false)]
    [string]$SitePath = "_site"
)

# Check if there are any existing DocFX jobs and remove them
$existingJobs = Get-Job | Where-Object { $_.Name -like "DocFX*" }
if ($existingJobs) {
    Write-Host "Found existing DocFX jobs. Stopping them..." -ForegroundColor Yellow
    $existingJobs | Stop-Job
    $existingJobs | Remove-Job
    Write-Host "Existing DocFX jobs removed." -ForegroundColor Green
}

# Start DocFX server as a background job
$jobName = "DocFX-Server-$Port"
$scriptBlock = {
    param($workingDir, $port, $sitePath)
    Set-Location $workingDir
    & docfx serve $sitePath --port $port
}

Write-Host "Starting DocFX server on port $Port as a background job..." -ForegroundColor Cyan
$job = Start-Job -Name $jobName -ScriptBlock $scriptBlock -ArgumentList $PWD, $Port, $SitePath

# Wait a moment for the server to start
Start-Sleep -Seconds 2

# Check if the job is running
$jobInfo = Get-Job -Name $jobName
if ($jobInfo.State -eq "Running") {
    Write-Host "DocFX server is running on http://localhost:$Port" -ForegroundColor Green
    Write-Host "You can now run verification scripts or browse the site." -ForegroundColor Green
    Write-Host ""
    Write-Host "To check the status of the server, run:" -ForegroundColor Yellow
    Write-Host "Get-Job -Name '$jobName'" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "To see server output, run:" -ForegroundColor Yellow
    Write-Host "Receive-Job -Name '$jobName'" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "To stop the server when done, run:" -ForegroundColor Yellow
    Write-Host "Stop-Job -Name '$jobName'; Remove-Job -Name '$jobName'" -ForegroundColor Yellow
} else {
    Write-Host "Failed to start DocFX server. Job state: $($jobInfo.State)" -ForegroundColor Red
    Write-Host "Error details:" -ForegroundColor Red
    Receive-Job -Name $jobName
    Remove-Job -Name $jobName
}
