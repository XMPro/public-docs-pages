# Script to verify and fix image references in markdown files
# The script will check if referenced images exist and try to find alternatives with underscores instead of spaces

# Function to convert spaces to underscores in a filename
function ConvertToSnakeCase {
    param (
        [string]$filename
    )
    
    # Replace spaces with underscores
    $snakeCaseFilename = $filename -replace ' ', '_'
    
    # Return the snake case filename
    return $snakeCaseFilename
}

# Function to check if an image exists and find alternatives if needed
function CheckAndFixImageReference {
    param (
        [string]$markdownFile,
        [string]$imageReference,
        [switch]$fixIssues
    )
    
    # Extract the image path from the reference
    # Handle both ![alt](path) and <img src="path"> formats
    if ($imageReference -match '!\[.*?\]\((.*?)\)') {
        $imagePath = $matches[1]
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
    
    # Decode URL-encoded characters
    $decodedPath = [System.Web.HttpUtility]::UrlDecode($imagePath)
    
    # Get the directory of the markdown file
    $markdownDir = Split-Path -Parent $markdownFile
    
    # Construct the full path to the image
    $fullImagePath = Join-Path -Path $markdownDir -ChildPath $decodedPath
    $fullImagePath = [System.IO.Path]::GetFullPath($fullImagePath)
    
    # Check if the image exists
    $imageExists = Test-Path -Path $fullImagePath
    
    if (-not $imageExists) {
        # Try to find an alternative with underscores instead of spaces
        $imageFilename = Split-Path -Leaf $decodedPath
        $imageDir = Split-Path -Parent $decodedPath
        
        $snakeCaseFilename = ConvertToSnakeCase $imageFilename
        $alternativePath = Join-Path -Path $imageDir -ChildPath $snakeCaseFilename
        $fullAlternativePath = Join-Path -Path $markdownDir -ChildPath $alternativePath
        $fullAlternativePath = [System.IO.Path]::GetFullPath($fullAlternativePath)
        
        $alternativeExists = Test-Path -Path $fullAlternativePath
        
        if ($alternativeExists) {
            Write-Host "Found alternative for $imagePath -> $alternativePath in $markdownFile"
            
            if ($fixIssues) {
                # Replace the image reference in the markdown file
                $markdownContent = Get-Content -Path $markdownFile -Raw
                
                if ($imageReference -match '!\[.*?\]\((.*?)\)') {
                    $newReference = $imageReference -replace [regex]::Escape($imagePath), $alternativePath
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
        [switch]$fixIssues
    )
    
    # Add System.Web assembly for URL decoding
    Add-Type -AssemblyName System.Web
    
    # Get all markdown files
    $markdownFiles = Get-ChildItem -Path $rootDir -Filter "*.md" -Recurse
    
    $issues = @()
    
    foreach ($file in $markdownFiles) {
        Write-Host "Processing $($file.FullName)"
        
        # Read the file content
        $content = Get-Content -Path $file.FullName -Raw
        
        # Find all image references
        $imageMatches = [regex]::Matches($content, '(!\[.*?\]\(.*?\)|<img.*?src=".*?".*?>)')
        
        foreach ($match in $imageMatches) {
            $result = CheckAndFixImageReference -markdownFile $file.FullName -imageReference $match.Value -fixIssues:$fixIssues
            
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

# Check if -fix parameter is provided
if ($args -contains "-fix") {
    $fixIssues = $true
    Write-Host "Running in fix mode - will update markdown files"
}
else {
    Write-Host "Running in check mode - will only report issues"
    Write-Host "Use -fix parameter to automatically fix issues"
}

$issues = ProcessMarkdownFiles -rootDir $rootDir -fixIssues:$fixIssues

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
