# Script to run the optimized image verification with minimal memory usage
# This script will run the incremental-verify-image-references-optimized.ps1 script
# with the -minimal-memory flag to avoid token limit issues

param(
    [switch]$fix = $false,
    [int]$batchSize = 3,
    [switch]$continue = $false,
    [switch]$resetProgress = $false,
    [string]$progressFile = "image-verification-progress.json",
    [string]$csvReport = "image-verification-report.csv"
)

$fixParam = ""
if ($fix) {
    $fixParam = "-fix"
}

$continueParam = ""
if ($continue) {
    $continueParam = "-continue"
}

Write-Host "Running optimized image verification with minimal memory usage"
Write-Host "============================================================="
Write-Host "Batch size: $batchSize"
Write-Host "Fix mode: $($fix -eq $true)"
Write-Host "Continue mode: $($continue -eq $true)"
Write-Host "Reset progress: $($resetProgress -eq $true)"
Write-Host "Progress file: $progressFile"
Write-Host "CSV report: $csvReport"

# Reset progress file if requested
if ($resetProgress) {
    if (Test-Path $progressFile) {
        Write-Host "Resetting progress file: $progressFile"
        Remove-Item $progressFile -Force
    }
}

# Run the optimized image verification script with minimal memory usage
$command = ".\incremental-verify-image-references-optimized.ps1 -batch-size $batchSize $fixParam $continueParam -minimal-memory -progress-file $progressFile -csv-report $csvReport"
Write-Host "Executing: $command"
Invoke-Expression $command

Write-Host "`nOptimized image verification completed."
Write-Host "The script used minimal memory to avoid token limit issues."
Write-Host "Results are available in the CSV report: $csvReport"

# Provide guidance for future runs
Write-Host "`nTo continue this verification in the future, run:"
Write-Host "  .\run-image-verification-optimized.ps1 -batchSize $batchSize -continue -fix:$($fix -eq $true)"

# Provide guidance if token limit might still be an issue
Write-Host "`nIf you still encounter token limit issues, try:"
Write-Host "  1. Using an even smaller batch size:"
Write-Host "     .\run-image-verification-optimized.ps1 -batchSize 1 -continue"
Write-Host "  2. Resetting progress and starting with a small batch size:"
Write-Host "     .\run-image-verification-optimized.ps1 -batchSize 1 -resetProgress"
Write-Host "  3. Using a different progress file for each run:"
Write-Host "     .\run-image-verification-optimized.ps1 -progressFile 'progress-part1.json' -csvReport 'report-part1.csv'"
