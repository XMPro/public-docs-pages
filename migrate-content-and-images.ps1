# Script to migrate files that need both content and image migration

# Configuration
$trackingFile = "tracking/concepts-tracking.md"
$gitbookPath = "docs"
$docfxPath = "docs-docfx/docs"

# Function to parse the tracking file and find files that need both content and image migration
function Get-FilesToMigrate {
    param (
        [string]$TrackingFile
    )
    
    $content = Get-Content -Path $TrackingFile -Raw
    $lines = $content -split "`n"
    $filesToMigrate = @()
    
    foreach ($line in $lines) {
        # Look for lines with "❌ | ❌" pattern (content not confirmed and images not confirmed)
        if ($line -match "\|(.*?)\|(.*?)\| ❌ \| ❌ \|") {
            $filesToMigrate += $line.Trim()
        }
    }
    
    return $filesToMigrate
}

# Function to migrate content from GitBook to DocFX
function Migrate-Content {
    param (
        [string]$GitBookPath,
        [string]$DocFXPath
    )
    
    # Read the GitBook content
    $gitbookContent = Get-Content -Path $GitBookPath -Raw
    
    # Convert GitBook syntax to DocFX syntax
    # 1. Replace image paths
    $updatedContent = $gitbookContent -replace '\]\(<?(\.\.\/)*\.gitbook\/assets\/(.*?)>\)', '](images/$2)'
    
    # 2. Replace other GitBook-specific syntax if needed
    # Add more replacements as needed
    
    # Write the updated content to the DocFX file
    Set-Content -Path $DocFXPath -Value $updatedContent
    
    Write-Host "Migrated content from $GitBookPath to $DocFXPath"
    return $true
}

# Main execution
Write-Host "Starting content and image migration process..."

# Get files that need migration
$filesToMigrate = Get-FilesToMigrate -TrackingFile $trackingFile
Write-Host "Found $($filesToMigrate.Count) files that need both content and image migration."

# Process each file
$migratedCount = 0
foreach ($fileEntry in $filesToMigrate) {
    Write-Host "`nProcessing file entry: $fileEntry"
    
    # Extract file paths from the entry
    $gitbookRelativePath = ($fileEntry -split '\|')[0].Trim()
    $docfxRelativePath = ($fileEntry -split '\|')[1].Trim()
    
    # Full paths
    $gitbookFullPath = $gitbookRelativePath
    $docfxFullPath = $docfxRelativePath
    
    Write-Host "GitBook path: $gitbookFullPath"
    Write-Host "DocFX path: $docfxFullPath"
    
    # 1. Check if the files exist
    if (-not (Test-Path $gitbookFullPath)) {
        Write-Host "Error: GitBook file not found: $gitbookFullPath"
        continue
    }
    
    # Create DocFX directory if it doesn't exist
    $docfxDir = Split-Path -Parent $docfxFullPath
    if (-not (Test-Path $docfxDir)) {
        New-Item -ItemType Directory -Path $docfxDir -Force | Out-Null
        Write-Host "Created directory: $docfxDir"
    }
    
    # 2. Migrate content
    $contentMigrated = Migrate-Content -GitBookPath $gitbookFullPath -DocFXPath $docfxFullPath
    
    if (-not $contentMigrated) {
        Write-Host "Failed to migrate content. Continuing with next file."
        continue
    }
    
# 3. Extract image references and copy images
    $gitbookContent = Get-Content -Path $gitbookFullPath -Raw
    $imageMatches = [regex]::Matches($gitbookContent, '!\[.*?\]\((.*?)\)')
    $images = @()
    
    foreach ($match in $imageMatches) {
        $imagePath = $match.Groups[1].Value
        # Extract just the filename from the path
        if ($imagePath -match '\.gitbook/assets/(.*?)(?:\>)?$') {
            $imageName = $matches[1]
            # Fix the image name if it has a closing parenthesis
            if ($imageName -match '(.*?)\)$' -and -not $imageName.EndsWith(').png')) {
                $imageName = $imageName + '.png'
            }
            # Remove escape characters from the image name
            $imageName = $imageName -replace '_', ''
            $images += $imageName
        }
    }
    
    Write-Host "Found $($images.Count) images in the GitBook file."
    
    # Create images directory if it doesn't exist
    $imagesDir = Join-Path $docfxDir "images"
    if (-not (Test-Path $imagesDir)) {
        New-Item -ItemType Directory -Path $imagesDir -Force | Out-Null
        Write-Host "Created images directory: $imagesDir"
    }
    
    # Copy images from GitBook assets to DocFX images directory
    $sourceDir = "docs\.gitbook\assets"
    $copiedImages = @()
    
    foreach ($image in $images) {
        $sourcePath = Join-Path $sourceDir $image
        # Clean up the image name for the destination
        $cleanImageName = $image -replace " \(", "-" -replace "\)", ""
        $destPath = Join-Path $imagesDir $cleanImageName
        
        if (Test-Path $sourcePath) {
            Copy-Item $sourcePath $destPath -Force
            $copiedImages += $cleanImageName
            Write-Host "Copied: $image to $destPath"
        } else {
            Write-Host "Warning: Source file not found: $sourcePath"
        }
    }
    
    # 4. Update the tracking file
    $trackingContent = Get-Content -Path $trackingFile -Raw
    $pattern = [regex]::Escape($gitbookRelativePath) + " \| " + [regex]::Escape($docfxRelativePath) + " \| ❌ \| ❌ \|"
    $replacement = "$gitbookRelativePath | $docfxRelativePath | ✓ | ✓ |"
    $updatedTrackingContent = $trackingContent -replace $pattern, $replacement
    
    Set-Content -Path $trackingFile -Value $updatedTrackingContent
    Write-Host "Updated tracking file: $trackingFile"
    
    # 5. Commit the changes
    $gitMessage = "Migrated content and images for $docfxRelativePath"
    git add $docfxFullPath
    git add $imagesDir
    git add $trackingFile
    git commit -m $gitMessage
    git push
    
    Write-Host "Committed and pushed changes for: $docfxRelativePath"
    $migratedCount++
}

Write-Host "`nMigration process completed."
Write-Host "Successfully migrated $migratedCount out of $($filesToMigrate.Count) files."

# Update the main migration tracking document if all files were migrated
if ($migratedCount -eq $filesToMigrate.Count -and $filesToMigrate.Count -gt 0) {
    Write-Host "All files have been successfully migrated!"
    
    # Update the main migration tracking document
    $mainTrackingFile = "migration-tracking.md"
    $mainContent = Get-Content -Path $mainTrackingFile -Raw
    
    # Update the status in the main tracking file
    $updatedMainContent = $mainContent -replace "(content also not confirmed)", "✓"
    Set-Content -Path $mainTrackingFile -Value $updatedMainContent
    
    # Commit the main tracking file update
    git add $mainTrackingFile
    git commit -m "Updated main migration tracking document"
    git push
    
    Write-Host "Updated and committed main migration tracking document."
}
