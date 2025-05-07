# Script to run the image verification with a smaller batch size to avoid token limits
# This script will run the incremental-verify-image-references.ps1 script with a batch size of 3
# and the -continue flag to continue from where it left off if needed

param(
    [switch]$fix = $false,
    [int]$batchSize = 3,
    [switch]$continue = $false,
    [switch]$resetProgress = $false
)

$fixParam = ""
if ($fix) {
    $fixParam = "-fix"
}

$continueParam = ""
if ($continue) {
    $continueParam = "-continue"
}

Write-Host "Running image verification with batch size: $batchSize"
Write-Host "Fix mode: $($fix -eq $true)"
Write-Host "Continue mode: $($continue -eq $true)"
Write-Host "Reset progress: $($resetProgress -eq $true)"

# Reset progress file if requested
if ($resetProgress) {
    $progressFile = "image-verification-progress.json"
    if (Test-Path $progressFile) {
        Write-Host "Resetting progress file: $progressFile"
        Remove-Item $progressFile -Force
    }
}

# Run the image verification script
$command = ".\incremental-verify-image-references.ps1 -batch-size $batchSize $fixParam $continueParam"
Write-Host "Executing: $command"
Invoke-Expression $command

# Provide guidance if token limit might be an issue
if ($batchSize -gt 1) {
    Write-Host "`nNote: If you encounter token limit issues, try running with a smaller batch size:"
    Write-Host "  .\run-image-verification.ps1 -batchSize 1 -continue"
    Write-Host "Or reset the progress file to start fresh:"
    Write-Host "  .\run-image-verification.ps1 -batchSize 1 -resetProgress"
}
