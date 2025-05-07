# Script to run all verification scripts for the DocFX documentation

Write-Host "Starting comprehensive verification for DocFX documentation..." -ForegroundColor Green

# Define the base URL for the local DocFX server
$baseUrl = "http://localhost:9000"
$serverJobName = "DocFX-Server-9000"

# Function to check if a server is running on a specific port
function Test-ServerRunning {
    param (
        [string]$Url
    )
    
    try {
        $request = [System.Net.WebRequest]::Create($Url)
        $request.Method = "HEAD"
        $request.Timeout = 5000
        $response = $request.GetResponse()
        $response.Close()
        
        return $true
    }
    catch {
        return $false
    }
}

# Check if the DocFX server is already running
$isServerRunning = Test-ServerRunning -Url $baseUrl

# If server is not running, start it using start-docfx-server.ps1
if (-not $isServerRunning) {
    Write-Host "Starting DocFX server using start-docfx-server.ps1..." -ForegroundColor Yellow
    & ".\start-docfx-server.ps1" -Port 9000
    
    # Wait a moment for the server to start
    Start-Sleep -Seconds 3
    
    # Check again if the server is running
    $isServerRunning = Test-ServerRunning -Url $baseUrl
    
    if (-not $isServerRunning) {
        Write-Host "Failed to start DocFX server on $baseUrl" -ForegroundColor Red
        exit
    }
}
else {
    Write-Host "DocFX server is already running on $baseUrl" -ForegroundColor Green
}

# Create a results directory
$resultsDir = "verification-results"
if (-not (Test-Path $resultsDir)) {
    New-Item -ItemType Directory -Path $resultsDir | Out-Null
}

# Run the verification scripts
$scripts = @(
    @{
        Name = "verify-links.ps1"
        Parameters = @{
            Port = 9000
            MaxLinksToCheck = 100
            TimeoutSeconds = 60
        }
    },
    @{
        Name = "verify-images-fixed.ps1"
        Parameters = @{
            Port = 9000
            MaxPagesToCheck = 50
            TimeoutSeconds = 60
        }
    },
    @{
        Name = "verify-navigation.ps1"
        Parameters = @{
            Port = 9000
        }
    },
    @{
        Name = "verify-search.ps1"
        Parameters = @{
            Port = 9000
        }
    }
)

$results = @{}

foreach ($script in $scripts) {
    $scriptName = [System.IO.Path]::GetFileNameWithoutExtension($script.Name)
    $startTime = Get-Date
    
    Write-Host "`n=========================================================" -ForegroundColor Cyan
    Write-Host "Running $($script.Name)..." -ForegroundColor Cyan
    Write-Host "=========================================================" -ForegroundColor Cyan
    
    # Create a transcript file
    $transcriptFile = Join-Path $resultsDir "$scriptName-transcript.txt"
    Start-Transcript -Path $transcriptFile -Force
    
    # Run the script with parameters
    try {
        $paramString = ""
        foreach ($param in $script.Parameters.GetEnumerator()) {
            $paramString += "-$($param.Key) $($param.Value) "
        }
        
        Write-Host "Executing: & "".\$($script.Name)"" $paramString" -ForegroundColor Yellow
        
        # Build the parameter hashtable
        $paramHash = @{}
        foreach ($param in $script.Parameters.GetEnumerator()) {
            $paramHash[$param.Key] = $param.Value
        }
        
        # Execute the script with parameters
        & ".\$($script.Name)" @paramHash
        $success = $true
    }
    catch {
        Write-Host "Error running $($script.Name) : $_" -ForegroundColor Red
        $success = $false
    }
    
    # Stop the transcript
    Stop-Transcript
    
    $endTime = Get-Date
    $duration = $endTime - $startTime
    
    # Record the result
    $results[$scriptName] = @{
        Success = $success
        Duration = $duration
        TranscriptFile = $transcriptFile
    }
    
    Write-Host "`nCompleted $($script.Name) in $($duration.TotalSeconds) seconds" -ForegroundColor $(if ($success) { "Green" } else { "Red" })
}

# Generate a summary report
$summaryFile = Join-Path $resultsDir "verification-summary.md"

$summary = @"
# DocFX Documentation Verification Summary

Verification performed on $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

## Verification Results

| Script | Status | Duration | Transcript |
|--------|--------|----------|------------|
"@

foreach ($scriptName in $results.Keys) {
    $result = $results[$scriptName]
    $status = if ($result.Success) { "✅ Success" } else { "❌ Failed" }
    $duration = "{0:N2} seconds" -f $result.Duration.TotalSeconds
    $transcriptLink = [System.IO.Path]::GetFileName($result.TranscriptFile)
    
    $summary += "`n| $scriptName | $status | $duration | [$transcriptLink](./$transcriptLink) |"
}

$summary += @"

## Next Steps

1. Review the detailed results in the transcript files
2. Fix any issues identified by the verification scripts
3. Re-run the verification scripts to confirm the issues have been resolved
4. Update the migration plan to reflect the verification status

## Verification Details

### Links Verification
- Checks for broken internal links
- Verifies that all links in the documentation are valid
- Identifies pages with broken links

### Images Verification
- Checks for broken image links
- Verifies that all images are properly displayed
- Identifies images missing alt text

### Navigation Verification
- Checks the navigation structure
- Verifies that all sections and pages are accessible through the navigation menu
- Identifies inconsistencies in the navigation structure

### Search Verification
- Tests the search functionality
- Verifies that search results are relevant
- Identifies search terms that return no results
"@

$summary | Out-File -FilePath $summaryFile -Encoding utf8

Write-Host "`n=========================================================" -ForegroundColor Cyan
Write-Host "Verification Summary" -ForegroundColor Cyan
Write-Host "=========================================================" -ForegroundColor Cyan

foreach ($scriptName in $results.Keys) {
    $result = $results[$scriptName]
    $status = if ($result.Success) { "Success" } else { "Failed" }
    $duration = "{0:N2} seconds" -f $result.Duration.TotalSeconds
    
    Write-Host "$scriptName : $status ($duration)" -ForegroundColor $(if ($result.Success) { "Green" } else { "Red" })
}

Write-Host "`nVerification results have been saved to $resultsDir" -ForegroundColor Green
Write-Host "Summary report: $summaryFile" -ForegroundColor Green

# Update the migration plan
$migrationPlanFile = "migration-plan.md"
if (Test-Path $migrationPlanFile) {
    $migrationPlan = Get-Content $migrationPlanFile -Raw
    
    # Update the status of Step 12
    $migrationPlan = $migrationPlan -replace "(\|\s*Verify Links and Functionality\s*\|\s*)⏳ Not Started(\s*\|\s*)0%(\s*\|)", "`$1✅ Complete`$2100%`$3"
    
    # Write the updated migration plan
    $migrationPlan | Out-File -FilePath $migrationPlanFile -Encoding utf8
    
    Write-Host "`nMigration plan has been updated to mark 'Verify Links and Functionality' as complete" -ForegroundColor Green
}

# Check if we started the server, and if so, ask if the user wants to stop it
$serverJob = Get-Job -Name $serverJobName -ErrorAction SilentlyContinue
if ($serverJob) {
    $stopServer = Read-Host "Do you want to stop the DocFX server? (Y/N)"
    if ($stopServer -eq "Y" -or $stopServer -eq "y") {
        Write-Host "Stopping DocFX server..." -ForegroundColor Yellow
        Stop-Job -Name $serverJobName
        Remove-Job -Name $serverJobName
        Write-Host "DocFX server stopped." -ForegroundColor Green
    }
    else {
        Write-Host "DocFX server is still running. To stop it later, run:" -ForegroundColor Yellow
        Write-Host "Stop-Job -Name '$serverJobName'; Remove-Job -Name '$serverJobName'" -ForegroundColor Yellow
    }
}
