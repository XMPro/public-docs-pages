# Enhanced script to verify and fix image references in markdown files
# This script checks if referenced images exist and tries to find alternatives using multiple strategies

# Add System.Web assembly for URL decoding
Add-Type -AssemblyName System.Web

# Function to generate possible alternative filenames
function GetAlternativeFilenames {
    param (
        [string]$filename
    )

    $alternatives = @()
    
    # Original filename
    $alternatives += $filename
    
    # Replace spaces with underscores
    $spaceToUnderscore = $filename -replace ' ', '_'
    if ($spaceToUnderscore -ne $filename) {
        $alternatives += $spaceToUnderscore
    }
    
    # Replace %20 with underscores (URL encoded spaces)
    $encodedSpaceToUnderscore = $filename -replace '%20', '_'
    if ($encodedSpaceToUnderscore -ne $filename -and $encodedSpaceToUnderscore -ne $spaceToUnderscore) {
        $alternatives += $encodedSpaceToUnderscore
    }
    
    # Replace spaces with hyphens
    $spaceToHyphen = $filename -replace ' ', '-'
    if ($spaceToHyphen -ne $filename) {
        $alternatives += $spaceToHyphen
    }
    
    # Replace %20 with hyphens
    $encodedSpaceToHyphen = $filename -replace '%20', '-'
    if ($encodedSpaceToHyphen -ne $filename -and $encodedSpaceToHyphen -ne $spaceToHyphen) {
        $alternatives += $encodedSpaceToHyphen
    }
    
    # URL decode the filename
    $decodedFilename = [System.Web.HttpUtility]::UrlDecode($filename)
    if ($decodedFilename -ne $filename) {
        $alternatives += $decodedFilename
        
        # Also add versions with spaces replaced
        $decodedSpaceToUnderscore = $decodedFilename -replace ' ', '_'
        if ($decodedSpaceToUnderscore -ne $decodedFilename) {
            $alternatives += $decodedSpaceToUnderscore
        }
        
        $decodedSpaceToHyphen = $decodedFilename -replace ' ', '-'
        if ($decodedSpaceToHyphen -ne $decodedFilename) {
            $alternatives += $decodedSpaceToHyphen
        }
    }
    
    # Return unique alternatives
    return $alternatives | Select-Object -Unique
}

# Function to search for an image in alternative directories
function FindImageInAlternativeDirs {
    param (
        [string]$markdownDir,
        [string]$imagePath,
        [string]$imageFilename
    )
    
    $alternativeDirs = @(
        # Same directory
        (Join-Path -Path $markdownDir -ChildPath (Split-Path -Parent $imagePath)),
        
        # Direct images subdirectory
        (Join-Path -Path $markdownDir -ChildPath "images"),
        
        # Parent's images directory
        (Join-Path -Path (Split-Path -Parent $markdownDir) -ChildPath "images"),
        
        # Root images directory
        (Join-Path -Path (Get-Location) -ChildPath "images"),
        
        # Docs images directory
        (Join-Path -Path (Get-Location) -ChildPath "docs/images")
    )
    
    $alternativeFilenames = GetAlternativeFilenames -filename $imageFilename
    
    foreach ($dir in $alternativeDirs) {
        if (Test-Path -Path $dir) {
            foreach ($altFilename in $alternativeFilenames) {
                $fullPath = Join-Path -Path $dir -ChildPath $altFilename
                if (Test-Path -Path $fullPath) {
                    # Calculate the relative path from the markdown file to the found image
                    $relativeDir = Get-RelativePath -from $markdownDir -to $dir
                    $relativePath = Join-Path -Path $relativeDir -ChildPath $altFilename
                    return @{
                        FullPath = $fullPath
                        RelativePath = $relativePath
                    }
                }
            }
        }
    }
    
    return $null
}

# Function to get relative path between two directories
function Get-RelativePath {
    param (
        [string]$from,
        [string]$to
    )
    
    # Convert to absolute paths
    $fromPath = [System.IO.Path]::GetFullPath($from)
    $toPath = [System.IO.Path]::GetFullPath($to)
    
    # If they're the same, return "."
    if ($fromPath -eq $toPath) {
        return "."
    }
    
    # Split paths into segments
    $fromSegments = $fromPath -split [regex]::Escape([System.IO.Path]::DirectorySeparatorChar)
    $toSegments = $toPath -split [regex]::Escape([System.IO.Path]::DirectorySeparatorChar)
    
    # Find common prefix
    $commonPrefixLength = 0
    $minLength = [Math]::Min($fromSegments.Length, $toSegments.Length)
    
    for ($i = 0; $i -lt $minLength; $i++) {
        if ($fromSegments[$i] -eq $toSegments[$i]) {
            $commonPrefixLength++
        }
        else {
            break
        }
    }
    
    # Build relative path
    $relativePath = ""
    
    # Add ".." for each segment in 'from' path after the common prefix
    for ($i = $commonPrefixLength; $i -lt $fromSegments.Length; $i++) {
        if ($fromSegments[$i]) {  # Skip empty segments
            $relativePath += ".." + [System.IO.Path]::DirectorySeparatorChar
        }
    }
    
    # Add segments from 'to' path after the common prefix
    for ($i = $commonPrefixLength; $i -lt $toSegments.Length; $i++) {
        if ($toSegments[$i]) {  # Skip empty segments
            $relativePath += $toSegments[$i]
            if ($i -lt $toSegments.Length - 1) {
                $relativePath += [System.IO.Path]::DirectorySeparatorChar
            }
        }
    }
    
    # If relative path is empty, return "."
    if (-not $relativePath) {
        return "."
    }
    
    return $relativePath
}

# Function to check if an image exists and find alternatives if needed
function CheckAndFixImageReference {
    param (
        [string]$markdownFile,
        [string]$imageReference,
        [switch]$fixIssues,
        [switch]$preferSnakeCase
    )

    # Extract the image path from the reference
    # Handle both ![alt](path) and <img src="path"> formats
    $imagePath = $null
    $fullPattern = $null
    $altText = $null
    
    if ($imageReference -match '!\[(.*?)\]\((.*?)(\s+".*?")?\)') {
        $altText = $matches[1]
        $imagePath = $matches[2]
        $titleAttr = $matches[3]
        $fullPattern = $matches[0]
    }
    elseif ($imageReference -match '<img.*?src="(.*?)".*?>') {
        $imagePath = $matches[1]
        $fullPattern = $matches[0]
    }
    else {
        return $null
    }

    # Skip external URLs
    if ($imagePath -match '^https?://') {
        return $null
    }

    # Skip image references with variables or complex paths
    if ($imagePath -match '\$' -or $imagePath -match '\{') {
        return $null
    }

    # Get the directory of the markdown file
    $markdownDir = Split-Path -Parent $markdownFile

    # Get the image filename
    $imageFilename = Split-Path -Leaf $imagePath
    
    # Try to find the image
    $imageFound = $false
    $fullImagePath = Join-Path -Path $markdownDir -ChildPath $imagePath
    
    try {
        $fullImagePath = [System.IO.Path]::GetFullPath($fullImagePath)
        $imageFound = Test-Path -Path $fullImagePath
    }
    catch {
        # Path might contain illegal characters
        $imageFound = $false
    }

    if (-not $imageFound) {
        # Try to find an alternative
        $alternativeResult = FindImageInAlternativeDirs -markdownDir $markdownDir -imagePath $imagePath -imageFilename $imageFilename
        
        if ($alternativeResult -ne $null) {
            $alternativePath = $alternativeResult.RelativePath
            Write-Host "Found alternative for $imagePath -> $alternativePath in $markdownFile"

            if ($fixIssues) {
                # Replace the image reference in the markdown file
                $markdownContent = Get-Content -Path $markdownFile -Raw

                if ($imageReference -match '!\[(.*?)\]\((.*?)(\s+".*?")?\)') {
                    $newReference = "![$altText]($alternativePath$titleAttr)"
                }
                elseif ($imageReference -match '<img.*?src="(.*?)".*?>') {
                    $newReference = $imageReference -replace [regex]::Escape($imagePath), $alternativePath
                }

                $markdownContent = $markdownContent -replace [regex]::Escape($imageReference), $newReference
                Set-Content -Path $markdownFile -Value $markdownContent

                return @{
                    MarkdownFile = $markdownFile
                    OldPath = $imagePath
                    NewPath = $alternativePath
                    Fixed = $true
                }
            }
            else {
                return @{
                    MarkdownFile = $markdownFile
                    OldPath = $imagePath
                    NewPath = $alternativePath
                    Fixed = $false
                }
            }
        }
        else {
            Write-Host "Image not found and no alternative found: $imagePath in $markdownFile"
            return @{
                MarkdownFile = $markdownFile
                OldPath = $imagePath
                NewPath = $null
                Fixed = $false
            }
        }
    }

    return $null
}

# Main function to process all markdown files
function ProcessMarkdownFiles {
    param (
        [string]$rootDir,
        [switch]$fixIssues,
        [switch]$preferSnakeCase
    )

    # Get all markdown files
    $markdownFiles = Get-ChildItem -Path $rootDir -Filter "*.md" -Recurse

    $issues = @()
    $totalFiles = $markdownFiles.Count
    $currentFile = 0

    foreach ($file in $markdownFiles) {
        $currentFile++
        Write-Host "Processing $($file.FullName) [$currentFile of $totalFiles]"

        # Read the file content
        $content = Get-Content -Path $file.FullName -Raw

        # Find all image references
        $imageMatches = [regex]::Matches($content, '(!\[.*?\]\(.*?\)|<img.*?src=".*?".*?>)')

        foreach ($match in $imageMatches) {
            $result = CheckAndFixImageReference -markdownFile $file.FullName -imageReference $match.Value -fixIssues:$fixIssues -preferSnakeCase:$preferSnakeCase

            if ($result -ne $null) {
                $issues += $result
            }
        }
    }

    return $issues
}

# Main execution
$rootDir = "."  # Current directory
$fixIssues = $false  # Set to $true to automatically fix issues
$preferSnakeCase = $true  # Prefer snake_case for filenames

# Parse command line arguments
for ($i = 0; $i -lt $args.Count; $i++) {
    switch ($args[$i]) {
        "-fix" {
            $fixIssues = $true
        }
        "-dir" {
            $i++
            if ($i -lt $args.Count) {
                $rootDir = $args[$i]
            }
        }
        "-prefer-snake-case" {
            $preferSnakeCase = $true
        }
        "-prefer-kebab-case" {
            $preferSnakeCase = $false
        }
    }
}

if ($fixIssues) {
    Write-Host "Running in fix mode - will update markdown files"
}
else {
    Write-Host "Running in check mode - will only report issues"
    Write-Host "Use -fix parameter to automatically fix issues"
}

if ($preferSnakeCase) {
    Write-Host "Preferring snake_case for filenames"
}
else {
    Write-Host "Preferring kebab-case for filenames"
}

$issues = ProcessMarkdownFiles -rootDir $rootDir -fixIssues:$fixIssues -preferSnakeCase:$preferSnakeCase

# Output summary
Write-Host "`nSummary:"
Write-Host "--------"
Write-Host "Total issues found: $($issues.Count)"

if ($fixIssues) {
    $fixedCount = ($issues | Where-Object { $_.Fixed -eq $true }).Count
    Write-Host "Issues fixed: $fixedCount"
    Write-Host "Issues not fixed (no alternative found): $($issues.Count - $fixedCount)"
}

# Output detailed report
Write-Host "`nDetailed Report:"
Write-Host "---------------"

foreach ($issue in $issues) {
    Write-Host "File: $($issue.MarkdownFile)"
    Write-Host "  Old path: $($issue.OldPath)"

    if ($issue.NewPath -ne $null) {
        Write-Host "  New path: $($issue.NewPath)"

        if ($issue.Fixed) {
            Write-Host "  Status: Fixed"
        }
        else {
            Write-Host "  Status: Alternative found but not fixed (run with -fix to update)"
        }
    }
    else {
        Write-Host "  Status: No alternative found"
    }

    Write-Host ""
}
