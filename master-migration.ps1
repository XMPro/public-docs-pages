# Master script to orchestrate the entire DocFX migration process
# This script will:
# 1. Process files that need only image migration
# 2. Process files that need both content and image migration
# 3. Update the main migration tracking document
# 4. Test the DocFX server after each batch

# Configuration
$trackingFile = "tracking/concepts-tracking.md"
$mainTrackingFile = "migration-tracking.md"

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

# Function to update the main migration tracking document
function Update-MainTrackingDocument {
    param (
        [string]$Section,
        [string]$Status
    )
    
    $mainContent = Get-Content -Path $mainTrackingFile -Raw
    
    # Update the status in the main tracking file
    $pattern = "- $Section"
    $replacement = "- $Section $Status"
    $updatedMainContent = $mainContent -replace $pattern, $replacement
    
    Set-Content -Path $mainTrackingFile -Value $updatedMainContent
    
    # Commit the main tracking file update
    git add $mainTrackingFile
    git commit -m "Updated migration status for $Section"
    git push
    
    Write-Host "Updated and committed main migration tracking document for $Section."
}

# Function to check if a section is complete
function Is-SectionComplete {
    param (
        [string]$TrackingFile,
        [string]$Section
    )
    
    $content = Get-Content -Path $TrackingFile -Raw
    $lines = $content -split "`n"
    $incomplete = $false
    
    foreach ($line in $lines) {
        if ($line -match "$Section.*\| ❌ \|") {
            $incomplete = $true
            break
        }
    }
    
    return -not $incomplete
}

# Main execution
Write-Host "Starting master migration process..."

# Step 1: Process files that need only image migration
Write-Host "`n=== Processing files that need only image migration ==="
& .\run-migration.ps1

# Test the DocFX server
$serverOk = Test-DocFXServer
if (-not $serverOk) {
    Write-Host "DocFX server test failed after image migration. Please check the logs."
    exit
}

# Step 2: Process files that need both content and image migration
Write-Host "`n=== Processing files that need both content and image migration ==="
& .\migrate-content-and-images.ps1

# Test the DocFX server
$serverOk = Test-DocFXServer
if (-not $serverOk) {
    Write-Host "DocFX server test failed after content and image migration. Please check the logs."
    exit
}

# Step 3: Check if all sections are complete and update the main tracking document
Write-Host "`n=== Checking section completion status ==="

# Check Application section
if (Is-SectionComplete -TrackingFile $trackingFile -Section "application") {
    Write-Host "Application section is complete!"
    Update-MainTrackingDocument -Section "application" -Status "✓"
} else {
    Write-Host "Application section is not complete yet."
}

# Check Recommendation section
if (Is-SectionComplete -TrackingFile $trackingFile -Section "recommendation") {
    Write-Host "Recommendation section is complete!"
    Update-MainTrackingDocument -Section "recommendation" -Status "✓"
} else {
    Write-Host "Recommendation section is not complete yet."
}

# Check other sections
$otherSections = @("collection", "connector", "landing-pages", "version", "manage-access", "category", "variable", "insights")
foreach ($section in $otherSections) {
    if (Is-SectionComplete -TrackingFile $trackingFile -Section $section) {
        Write-Host "$section is complete!"
        Update-MainTrackingDocument -Section $section -Status "✓"
    } else {
        Write-Host "$section is not complete yet."
    }
}

# Final check
$allComplete = $true
$content = Get-Content -Path $trackingFile -Raw
if ($content -match "\| ❌ \|") {
    $allComplete = $false
}

if ($allComplete) {
    Write-Host "`nAll migration tasks have been completed successfully!"
    
    # Update the main migration tracking document
    $mainContent = Get-Content -Path $mainTrackingFile -Raw
    $updatedMainContent = $mainContent -replace "## Current Focus: Concepts Section Image Issues", "## Current Focus: Migration Complete ✓"
    Set-Content -Path $mainTrackingFile -Value $updatedMainContent
    
    # Commit the main tracking file update
    git add $mainTrackingFile
    git commit -m "Migration complete!"
    git push
    
    Write-Host "Updated and committed main migration tracking document."
} else {
    Write-Host "`nSome migration tasks are still pending. Please run this script again after addressing any issues."
}

Write-Host "`nMaster migration process completed."
