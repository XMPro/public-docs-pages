param (
    [Parameter(Mandatory=$true)]
    [string]$GitBookPath,
    
    [Parameter(Mandatory=$true)]
    [string]$DocFXPath,
    
    [Parameter(Mandatory=$true)]
    [string]$TrackingFile,
    
    [Parameter(Mandatory=$true)]
    [string]$FileEntry
)

# Extract file paths from the entry
$gitbookRelativePath = ($FileEntry -split '\|')[0].Trim()
$docfxRelativePath = ($FileEntry -split '\|')[1].Trim()

# Full paths
$gitbookFullPath = $gitbookRelativePath
$docfxFullPath = $docfxRelativePath

Write-Host "Processing file: $docfxRelativePath"

# 1. Check if the file exists
if (-not (Test-Path $gitbookFullPath)) {
    Write-Host "Error: GitBook file not found: $gitbookFullPath"
    return $false
}

if (-not (Test-Path $docfxFullPath)) {
    Write-Host "Error: DocFX file not found: $docfxFullPath"
    return $false
}

# 2. Extract image references from GitBook file
$gitbookContent = Get-Content -Path $gitbookFullPath -Raw
$docfxContent = Get-Content -Path $docfxFullPath -Raw

# Find all image references in the GitBook file
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

if ($images.Count -eq 0) {
    Write-Host "No images found in the file."
    return $false
}

# 3. Create images directory if it doesn't exist
$docfxDir = Split-Path -Parent $docfxFullPath
$imagesDir = Join-Path $docfxDir "images"
if (-not (Test-Path $imagesDir)) {
    New-Item -ItemType Directory -Path $imagesDir -Force | Out-Null
    Write-Host "Created images directory: $imagesDir"
}

# 4. Copy images from GitBook assets to DocFX images directory
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

# 5. Update image references in the DocFX file
$updatedContent = $docfxContent
foreach ($match in $imageMatches) {
    $originalRef = $match.Value
    $imagePath = $match.Groups[1].Value
    
    if ($imagePath -match '\.gitbook/assets/(.*?)(?:\>)?$') {
        $imageName = $matches[1]
        # Fix the image name if it has a closing parenthesis
        if ($imageName -match '(.*?)\)$' -and -not $imageName.EndsWith(').png')) {
            $imageName = $imageName + '.png'
        }
        # Remove escape characters from the image name
        $imageName = $imageName -replace '_', ''
        $cleanImageName = $imageName -replace " \(", "-" -replace "\)", ""
        $newRef = $originalRef -replace [regex]::Escape($imagePath), "images/$cleanImageName"
        $updatedContent = $updatedContent -replace [regex]::Escape($originalRef), $newRef
    }
}

# Write the updated content back to the DocFX file
Set-Content -Path $docfxFullPath -Value $updatedContent
Write-Host "Updated image references in: $docfxFullPath"

# 6. Update the tracking file
$trackingContent = Get-Content -Path $TrackingFile -Raw
$pattern = [regex]::Escape($FileEntry -replace "\|.*\| ✓ \| ❌ \|", "") + "\|.*\| ✓ \| ❌ \|"
$replacement = ($FileEntry -replace "\|.*\| ✓ \| ❌ \|", "") + "| ✓ | ✓ |"
$updatedTrackingContent = $trackingContent -replace $pattern, $replacement

Set-Content -Path $TrackingFile -Value $updatedTrackingContent
Write-Host "Updated tracking file: $TrackingFile"

# 7. Commit the changes
$gitMessage = "Migrated images for $docfxRelativePath"
git add $docfxFullPath
git add $imagesDir
git add $TrackingFile
git commit -m $gitMessage
git push

Write-Host "Committed and pushed changes for: $docfxRelativePath"
return $true
