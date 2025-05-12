# Master Migration Script for GitBook to DocFX
# This script automates the migration of content and images from GitBook to DocFX format

param(
    [Parameter(Mandatory=$false)]
    [string]$SectionName = "",
    
    [Parameter(Mandatory=$false)]
    [switch]$AllSections = $false,
    
    [Parameter(Mandatory=$false)]
    [switch]$UpdateTrackingOnly = $false,
    
    [Parameter(Mandatory=$false)]
    [switch]$CommitChanges = $true
)

# Configuration
$gitbookRoot = "docs"
$docfxRoot = "docs-docfx/docs"
$trackingDir = "tracking"
$mainTrackingFile = "migration-tracking.md"

# Available sections
$sections = @(
    "resources",
    "concepts",
    "getting-started",
    "how-tos",
    "blocks-toolbox",
    "administration",
    "installation",
    "release-notes"
)

# Function to validate section name
function Validate-Section {
    param (
        [string]$Name
    )
    
    if ($sections -contains $Name) {
        return $true
    }
    return $false
}

# Function to get tracking file path for a section
function Get-TrackingFilePath {
    param (
        [string]$Section
    )
    
    return "$trackingDir/$Section-tracking.md"
}

# Function to get files that need migration from a tracking file
function Get-FilesToMigrate {
    param (
        [string]$TrackingFilePath
    )
    
    $trackingContent = Get-Content -Path $TrackingFilePath -Raw
    $fileMatches = [regex]::Matches($trackingContent, 'docs\\(.*?) \| docs-docfx\\docs\\(.*?) \| ✓ \| ⚠️ \| ✓')
    
    $filesToMigrate = @()
    foreach ($match in $fileMatches) {
        $gitbookRelativePath = $match.Groups[1].Value
        $docfxRelativePath = $match.Groups[2].Value
        $filesToMigrate += @{
            GitbookPath = "$gitbookRoot/$($gitbookRelativePath -replace '\\', '/')"
            DocfxPath = "$docfxRoot/$($docfxRelativePath -replace '\\', '/')"
            TrackingPattern = [regex]::Escape("docs\$gitbookRelativePath | docs-docfx\docs\$docfxRelativePath | ✓ | ⚠️ | ✓")
            TrackingReplacement = "docs\$gitbookRelativePath | docs-docfx\docs\$docfxRelativePath | ✓ | ✓ | ✓"
        }
    }
    
    return $filesToMigrate
}

# Function to migrate a single file
function Migrate-File {
    param (
        [hashtable]$FileInfo,
        [string]$TrackingFilePath
    )
    
    $gitbookPath = $FileInfo.GitbookPath
    $docfxPath = $FileInfo.DocfxPath
    
    # Check if the files exist
    if (-not (Test-Path $gitbookPath)) {
        Write-Host "Error: GitBook file not found: $gitbookPath"
        return $false
    }

    if (-not (Test-Path $docfxPath)) {
        Write-Host "Error: DocFX file not found: $docfxPath"
        return $false
    }
    
    # Create images directory if it doesn't exist
    $docfxDir = Split-Path -Parent $docfxPath
    $imagesDir = Join-Path $docfxDir "images"
    if (-not (Test-Path $imagesDir)) {
        New-Item -ItemType Directory -Path $imagesDir -Force | Out-Null
        Write-Host "Created images directory: $imagesDir"
    }
    
    # Read the GitBook file to identify images and content
    $gitbookContent = Get-Content -Path $gitbookPath -Raw
    
    # Find image references
    $imageMatches = [regex]::Matches($gitbookContent, '!\[.*?\]\(<?(.*?)>?\)')
    $imagesToCopy = @()

    foreach ($match in $imageMatches) {
        $imagePath = $match.Groups[1].Value
        if ($imagePath -match '\.gitbook/assets/(.*\.(png|gif|jpg|jpeg))') {
            $imageName = $matches[1]
            $imagesToCopy += $imageName
        }
    }

    Write-Host "Found $($imagesToCopy.Count) images to copy for $gitbookPath"
    
    # Copy images
    $sourceDir = "docs\.gitbook\assets"
    $copiedImages = @()

    foreach ($image in $imagesToCopy) {
        $sourcePath = Join-Path $sourceDir $image
        # Clean up the image name for the destination
        $cleanImageName = $image -replace " \(", "-" -replace "\)", "" -replace " ", "_"
        $destPath = Join-Path $imagesDir $cleanImageName
        
        if (Test-Path $sourcePath) {
            Copy-Item $sourcePath $destPath -Force
            $copiedImages += $cleanImageName
            Write-Host "  Copied: $image to $destPath"
        } else {
            Write-Host "  Warning: Source file not found: $sourcePath"
        }
    }
    
    # Update the content with the original GitBook content
    $updatedContent = $gitbookContent
    
    # Convert GitBook hint syntax to DocFX note syntax
    $updatedContent = $updatedContent -replace '{% hint style="warning" %}(.*?){% endhint %}', '> [!WARNING]$1'
    $updatedContent = $updatedContent -replace '{% hint style="info" %}(.*?){% endhint %}', '> [!NOTE]$1'
    $updatedContent = $updatedContent -replace '{% hint style="danger" %}(.*?){% endhint %}', '> [!CAUTION]$1'
    $updatedContent = $updatedContent -replace '{% hint style="success" %}(.*?){% endhint %}', '> [!TIP]$1'
    
    # Convert GitBook content-ref syntax to DocFX links
    $updatedContent = $updatedContent -replace '{% content-ref url="(.*?)" %}.*?{% endcontent-ref %}', '* [$1]($1)'
    
    # Convert GitBook figure syntax to DocFX image syntax
    $updatedContent = $updatedContent -replace '<figure><img src="(.*?)" alt=""><figcaption><p>(.*?)</p></figcaption></figure>', '![$2]($1)'
    
    # Convert HTML color markup to DocFX syntax
    $updatedContent = $updatedContent -replace '<mark style="color:red;">(.*?)</mark>', '<span style="color:red;">$1</span>'
    
    # Update image references
    foreach ($match in $imageMatches) {
        $originalRef = $match.Value
        $imagePath = $match.Groups[1].Value
        
        if ($imagePath -match '\.gitbook/assets/(.*\.(png|gif|jpg|jpeg))') {
            $imageName = $matches[1]
            $cleanImageName = $imageName -replace " \(", "-" -replace "\)", "" -replace " ", "_"
            $newRef = $originalRef -replace [regex]::Escape($imagePath), "images/$cleanImageName"
            $updatedContent = $updatedContent -replace [regex]::Escape($originalRef), $newRef
        }
    }
    
    # Write the updated content back to the DocFX file
    Set-Content -Path $docfxPath -Value $updatedContent
    Write-Host "Updated content and image references in: $docfxPath"
    
    # Update the tracking file if not in update-tracking-only mode
    if (-not $UpdateTrackingOnly) {
        $trackingContent = Get-Content -Path $TrackingFilePath -Raw
        $pattern = $FileInfo.TrackingPattern
        $replacement = $FileInfo.TrackingReplacement
        $updatedTrackingContent = $trackingContent -replace $pattern, $replacement
        Set-Content -Path $TrackingFilePath -Value $updatedTrackingContent
        Write-Host "Updated tracking file: $TrackingFilePath"
    }
    
    return $true
}

# Function to update the main tracking file
function Update-MainTrackingFile {
    param (
        [string]$Section
    )
    
    $mainTrackingContent = Get-Content -Path $mainTrackingFile -Raw
    
    # Check if all sections are complete
    $allComplete = $true
    foreach ($sec in $sections) {
        $trackingFilePath = Get-TrackingFilePath -Section $sec
        $trackingContent = Get-Content -Path $trackingFilePath -Raw
        if ($trackingContent -match '⚠️|❌') {
            $allComplete = $false
            break
        }
    }
    
    if ($allComplete) {
        # Update to show all sections complete
        $pattern = "## Current Focus:.*?(?=###|$)"
        $replacement = @"
## Current Focus: All Sections Complete

We have successfully addressed image and content issues in all sections:
- Resources section: All files completed ✓
- Concepts section: All files completed ✓
- Getting Started section: All files completed ✓
- How-Tos section: All files completed ✓
- Blocks Toolbox section: All files completed ✓
- Administration section: All files completed ✓
- Installation section: All files completed ✓
- Release Notes section: All files completed ✓

The migration is now complete!

"@
        $updatedMainTrackingContent = $mainTrackingContent -replace $pattern, $replacement
    } else {
        # Update to focus on the current section
        $pattern = "## Current Focus:.*?(?=###|$)"
        $replacement = @"
## Current Focus: $Section Section Image Issues

After addressing previous sections, we're now focusing on the $Section section, which has files with image issues marked as ⚠️ (needs attention).

"@
        $updatedMainTrackingContent = $mainTrackingContent -replace $pattern, $replacement
    }
    
    Set-Content -Path $mainTrackingFile -Value $updatedMainTrackingContent
    Write-Host "Updated main tracking file: $mainTrackingFile"
}

# Function to commit changes
function Commit-Changes {
    param (
        [string]$Section,
        [array]$MigratedFiles
    )
    
    if ($MigratedFiles.Count -eq 0) {
        Write-Host "No files were migrated, skipping commit."
        return
    }
    
    # Add all modified files
    foreach ($file in $MigratedFiles) {
        git add $file.DocfxPath
    }
    
    # Add tracking files
    $trackingFilePath = Get-TrackingFilePath -Section $Section
    git add $trackingFilePath
    git add $mainTrackingFile
    
    # Commit changes
    $commitMessage = "Migrated $($MigratedFiles.Count) files in $Section section"
    git commit -m $commitMessage
    
    # Push changes
    git push
    
    Write-Host "Committed and pushed changes: $commitMessage"
}

# Main script execution
if (-not $AllSections -and -not $SectionName) {
    Write-Host "Please specify a section name or use -AllSections switch."
    Write-Host "Available sections: $($sections -join ', ')"
    exit
}

if ($AllSections) {
    foreach ($section in $sections) {
        Write-Host "Processing section: $section"
        $trackingFilePath = Get-TrackingFilePath -Section $section
        
        if (-not (Test-Path $trackingFilePath)) {
            Write-Host "Tracking file not found: $trackingFilePath"
            continue
        }
        
        $filesToMigrate = Get-FilesToMigrate -TrackingFilePath $trackingFilePath
        Write-Host "Found $($filesToMigrate.Count) files to migrate in $section section."
        
        $migratedFiles = @()
        foreach ($file in $filesToMigrate) {
            $success = Migrate-File -FileInfo $file -TrackingFilePath $trackingFilePath
            if ($success) {
                $migratedFiles += $file
            }
        }
        
        Update-MainTrackingFile -Section $section
        
        if ($CommitChanges) {
            Commit-Changes -Section $section -MigratedFiles $migratedFiles
        }
    }
} else {
    if (-not (Validate-Section -Name $SectionName)) {
        Write-Host "Invalid section name: $SectionName"
        Write-Host "Available sections: $($sections -join ', ')"
        exit
    }
    
    Write-Host "Processing section: $SectionName"
    $trackingFilePath = Get-TrackingFilePath -Section $SectionName
    
    if (-not (Test-Path $trackingFilePath)) {
        Write-Host "Tracking file not found: $trackingFilePath"
        exit
    }
    
    $filesToMigrate = Get-FilesToMigrate -TrackingFilePath $trackingFilePath
    Write-Host "Found $($filesToMigrate.Count) files to migrate in $SectionName section."
    
    $migratedFiles = @()
    foreach ($file in $filesToMigrate) {
        $success = Migrate-File -FileInfo $file -TrackingFilePath $trackingFilePath
        if ($success) {
            $migratedFiles += $file
        }
    }
    
    Update-MainTrackingFile -Section $SectionName
    
    if ($CommitChanges) {
        Commit-Changes -Section $SectionName -MigratedFiles $migratedFiles
    }
}

Write-Host "Migration process completed."
