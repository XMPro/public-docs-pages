# Script to automate the DocFX migration process
# This script will:
# 1. Parse the tracking file to find files that need image migration
# 2. Process each file one by one
# 3. Update the tracking file
# 4. Commit and push changes

# Configuration
$trackingFile = "tracking/concepts-tracking.md"
$gitbookPath = "docs"
$docfxPath = "docs-docfx/docs"

# Function to test the DocFX server
function Test-DocFXServer {
    Write-Host "Testing DocFX server..."
    
    try {
        # Run the DocFX server script
        $process = Start-Process -FilePath "powershell" -ArgumentList "-File start-docfx-server.ps1" -PassThru
        
        # Wait for the server to start
        Write-Host "Waiting for DocFX server to start..."
        Start-Sleep -Seconds 15
        
        # Open the browser to verify
        Write-Host "Opening browser to verify DocFX server..."
        Start-Process "http://localhost:8080"
        
        # Wait for user confirmation
        $confirmation = Read-Host "Is the DocFX server working correctly? (y/n)"
        
        # Stop the server
        Write-Host "Stopping DocFX server..."
        Stop-Process -Id $process.Id -Force -ErrorAction SilentlyContinue
        
        return $confirmation -eq "y"
    }
    catch {
        Write-Host "Error testing DocFX server: $_"
        return $false
    }
    finally {
        # Make sure the process is stopped even if there's an error
        if ($process -and -not $process.HasExited) {
            Stop-Process -Id $process.Id -Force -ErrorAction SilentlyContinue
        }
    }
}

# Function to parse the tracking file and find files that need migration
function Get-FilesToMigrate {
    param (
        [string]$TrackingFile
    )
    
    $content = Get-Content -Path $TrackingFile -Raw
    $lines = $content -split "`n"
    $filesToMigrate = @()
    
    foreach ($line in $lines) {
        # Look for lines with "✓ | ❌" pattern (content confirmed but images not)
        if ($line -match "\|(.*?)\|(.*?)\| ✓ \| ❌ \|") {
            $filesToMigrate += $line.Trim()
        }
    }
    
    return $filesToMigrate
}

# Main execution
Write-Host "Starting DocFX migration process..."

# Get files that need migration
$filesToMigrate = Get-FilesToMigrate -TrackingFile $trackingFile
Write-Host "Found $($filesToMigrate.Count) files that need image migration."

# Process each file
$migratedCount = 0
foreach ($fileEntry in $filesToMigrate) {
    Write-Host "`nProcessing file entry: $fileEntry"
    
    # Call the migrate-file.ps1 script for each file
    $result = & .\migrate-file.ps1 -GitBookPath $gitbookPath -DocFXPath $docfxPath -TrackingFile $trackingFile -FileEntry $fileEntry
    
    if ($result -eq $true) {
        $migratedCount++
        Write-Host "Successfully migrated file ($migratedCount of $($filesToMigrate.Count))"
        
        # Test the DocFX server after every 5 files or at the end
        if ($migratedCount % 5 -eq 0 -or $migratedCount -eq $filesToMigrate.Count) {
            $serverOk = Test-DocFXServer
            if (-not $serverOk) {
                Write-Host "DocFX server test failed. Pausing migration."
                $continue = Read-Host "Do you want to continue with migration? (y/n)"
                if ($continue -ne "y") {
                    break
                }
            }
        }
    } else {
        Write-Host "Failed to migrate file. Continuing with next file."
    }
}

Write-Host "`nMigration process completed."
Write-Host "Successfully migrated $migratedCount out of $($filesToMigrate.Count) files."

# Check if all files have been migrated
if ($migratedCount -eq $filesToMigrate.Count) {
    Write-Host "All files have been successfully migrated!"
    
    # Update the main migration tracking document
    $mainTrackingFile = "migration-tracking.md"
    $mainContent = Get-Content -Path $mainTrackingFile -Raw
    
    # Update the status in the main tracking file
    $updatedMainContent = $mainContent -replace "- application/devices.md", "- application/devices.md ✓"
    Set-Content -Path $mainTrackingFile -Value $updatedMainContent
    
    # Commit the main tracking file update
    git add $mainTrackingFile
    git commit -m "Updated main migration tracking document"
    git push
    
    Write-Host "Updated and committed main migration tracking document."
} else {
    Write-Host "Some files could not be migrated. Please check the logs for details."
}
