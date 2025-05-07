# Optimized incremental script to verify and fix image references in markdown files
# This script processes files in batches and saves minimal progress data to avoid token limit issues
# It checks if referenced images exist and tries to find alternatives using multiple strategies

# Add System.Web assembly for URL decoding
Add-Type -AssemblyName System.Web

# Function to convert a filename to Title_Snake_Case_Convention
function ConvertToTitleSnakeCase {
    param (
        [string]$filename
    )
    
    # Get file extension
    $extension = [System.IO.Path]::GetExtension($filename)
    $nameWithoutExt = [System.IO.Path]::GetFileNameWithoutExtension($filename)
    
    # URL decode the name first
    $decodedName = [System.Web.HttpUtility]::UrlDecode($nameWithoutExt)
    
    # Replace spaces and hyphens with underscores
    $snakeCaseName = $decodedName -replace '[ -]', '_'
    
    # Return the snake case filename with extension
    return $snakeCaseName + $extension
}

# Function to generate possible alternative filenames
function GetAlternativeFilenames {
    param (
        [string]$filename,
        [switch]$preferSnakeCase
    )

    $alternatives = @()
    
    # Original filename
    $alternatives += $filename
    
    # URL decode the filename
    $decodedFilename = [System.Web.HttpUtility]::UrlDecode($filename)
    if ($decodedFilename -ne $filename) {
        $alternatives += $decodedFilename
    }
    
    # Title_Snake_Case_Convention (preferred)
    $titleSnakeCase = ConvertToTitleSnakeCase -filename $filename
    if ($titleSnakeCase -ne $filename -and $titleSnakeCase -ne $decodedFilename) {
        # Add this first if snake case is preferred
        if ($preferSnakeCase) {
            $alternatives = @($titleSnakeCase) + $alternatives
        } else {
            $alternatives += $titleSnakeCase
        }
    }
    
    # Replace spaces with underscores
    $spaceToUnderscore = $filename -replace ' ', '_'
    if ($spaceToUnderscore -ne $filename -and $spaceToUnderscore -ne $titleSnakeCase) {
        $alternatives += $spaceToUnderscore
    }
    
    # Replace %20 with underscores (URL encoded spaces)
    $encodedSpaceToUnderscore = $filename -replace '%20', '_'
    if ($encodedSpaceToUnderscore -ne $filename -and 
        $encodedSpaceToUnderscore -ne $spaceToUnderscore -and 
        $encodedSpaceToUnderscore -ne $titleSnakeCase) {
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
    
    # Also add versions with spaces replaced for decoded filename
    if ($decodedFilename -ne $filename) {
        $decodedSpaceToUnderscore = $decodedFilename -replace ' ', '_'
        if ($decodedSpaceToUnderscore -ne $decodedFilename -and 
            $decodedSpaceToUnderscore -ne $spaceToUnderscore -and 
            $decodedSpaceToUnderscore -ne $titleSnakeCase) {
            $alternatives += $decodedSpaceToUnderscore
        }
        
        $decodedSpaceToHyphen = $decodedFilename -replace ' ', '-'
        if ($decodedSpaceToHyphen -ne $decodedFilename -and 
            $decodedSpaceToHyphen -ne $spaceToHyphen) {
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
        [string]$imageFilename,
        [switch]$preferSnakeCase
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
    
    $alternativeFilenames = GetAlternativeFilenames -filename $imageFilename -preferSnakeCase:$preferSnakeCase
    
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
                        Filename = $altFilename
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
    
    # Check for backslashes in the path and fix them
    $hasBackslashes = $imagePath -match '\\'
    $forwardSlashPath = $imagePath -replace '\\', '/'
    
    if ($hasBackslashes) {
        Write-Host "Found backslashes in path: $imagePath -> $forwardSlashPath in $markdownFile"
        
        if ($fixIssues) {
            # Replace the image reference in the markdown file
            $markdownContent = Get-Content -Path $markdownFile -Raw
            
            if ($imageReference -match '!\[(.*?)\]\((.*?)(\s+".*?")?\)') {
                $newReference = "![$altText]($forwardSlashPath$titleAttr)"
            }
            elseif ($imageReference -match '<img.*?src="(.*?)".*?>') {
                $newReference = $imageReference -replace [regex]::Escape($imagePath), $forwardSlashPath
            }
            
            $markdownContent = $markdownContent -replace [regex]::Escape($imageReference), $newReference
            Set-Content -Path $markdownFile -Value $markdownContent
            
            return @{
                MarkdownFile = $markdownFile
                OldPath = $imagePath
                NewPath = $forwardSlashPath
                NewFilename = (Split-Path -Leaf $forwardSlashPath)
                Fixed = $true
                FixType = "BackslashToForwardSlash"
            }
        }
        else {
            return @{
                MarkdownFile = $markdownFile
                OldPath = $imagePath
                NewPath = $forwardSlashPath
                NewFilename = (Split-Path -Leaf $forwardSlashPath)
                Fixed = $false
                FixType = "BackslashToForwardSlash"
            }
        }
        
        # Use the forward slash path for further processing
        $imagePath = $forwardSlashPath
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
        $alternativeResult = FindImageInAlternativeDirs -markdownDir $markdownDir -imagePath $imagePath -imageFilename $imageFilename -preferSnakeCase:$preferSnakeCase
        
        if ($alternativeResult -ne $null) {
            $alternativePath = $alternativeResult.RelativePath
            $alternativeFilename = $alternativeResult.Filename
            
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
                    NewFilename = $alternativeFilename
                    Fixed = $true
                }
            }
            else {
                return @{
                    MarkdownFile = $markdownFile
                    OldPath = $imagePath
                    NewPath = $alternativePath
                    NewFilename = $alternativeFilename
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
                NewFilename = $null
                Fixed = $false
            }
        }
    }

    return $null
}

# Function to load progress from a JSON file
function LoadProgress {
    param (
        [string]$progressFile
    )
    
    if (Test-Path -Path $progressFile) {
        try {
            $progress = Get-Content -Path $progressFile -Raw | ConvertFrom-Json
            return $progress
        }
        catch {
            Write-Host "Error loading progress file: $_"
            return $null
        }
    }
    
    return $null
}

# Function to save progress to a JSON file
function SaveProgress {
    param (
        [PSCustomObject]$progress,
        [string]$progressFile
    )
    
    try {
        $progress | ConvertTo-Json -Depth 10 | Set-Content -Path $progressFile
        return $true
    }
    catch {
        Write-Host "Error saving progress file: $_"
        return $false
    }
}

# Function to process a batch of markdown files
function ProcessMarkdownBatch {
    param (
        [array]$markdownFiles,
        [int]$startIndex,
        [int]$batchSize,
        [switch]$fixIssues,
        [switch]$preferSnakeCase,
        [PSCustomObject]$progress,
        [string]$csvReport,
        [switch]$minimalMemoryUsage
    )
    
    $endIndex = [Math]::Min($startIndex + $batchSize - 1, $markdownFiles.Count - 1)
    $batchIssues = @()
    
    Write-Host "Processing batch from $($startIndex + 1) to $($endIndex + 1) of $($markdownFiles.Count) files"
    
    for ($i = $startIndex; $i -le $endIndex; $i++) {
        $file = $markdownFiles[$i]
        Write-Host "Processing $($file.FullName) [$($i + 1) of $($markdownFiles.Count)]"
        
        # Read the file content
        $content = Get-Content -Path $file.FullName -Raw
        
        # Find all image references
        $imageMatches = [regex]::Matches($content, '(!\[.*?\]\(.*?\)|<img.*?src=".*?".*?>)')
        
        foreach ($match in $imageMatches) {
            $result = CheckAndFixImageReference -markdownFile $file.FullName -imageReference $match.Value -fixIssues:$fixIssues -preferSnakeCase:$preferSnakeCase
            
            if ($result -ne $null) {
                # Add to batch issues
                $batchIssues += $result
                
                # If CSV report is enabled, append to CSV immediately to reduce memory usage
                if ($csvReport -and $minimalMemoryUsage) {
                    $result | Select-Object MarkdownFile, OldPath, NewPath, NewFilename, Fixed | 
                        Export-Csv -Path $csvReport -NoTypeInformation -Append
                }
            }
        }
        
        # Update progress with just the file path (not the full file object)
        $progress.ProcessedFiles += $file.FullName
        $progress.LastProcessedIndex = $i
        $progress.IssueCount += ($batchIssues | Where-Object { $_ -ne $null }).Count
        
        # Save progress more frequently when using minimal memory
        if ($minimalMemoryUsage -and ($i % 5 -eq 0)) {
            SaveProgress -progress $progress -progressFile $progress.ProgressFile
        }
    }
    
    return @{
        Issues = $batchIssues
        Progress = $progress
    }
}

# Function to generate a summary report
function GenerateSummaryReport {
    param (
        [array]$allIssues,
        [switch]$fixIssues,
        [int]$totalIssueCount = 0
    )
    
    $issueCount = if ($allIssues) { $allIssues.Count } else { $totalIssueCount }
    
    Write-Host "`nSummary Report:"
    Write-Host "---------------"
    Write-Host "Total issues found: $issueCount"
    
    if ($fixIssues -and $allIssues) {
        $fixedCount = ($allIssues | Where-Object { $_.Fixed -eq $true }).Count
        Write-Host "Issues fixed: $fixedCount"
        Write-Host "Issues not fixed (no alternative found): $($issueCount - $fixedCount)"
    }
    
    if ($allIssues) {
        # Group by file extension
        $extensionGroups = $allIssues | Group-Object { [System.IO.Path]::GetExtension($_.OldPath) }
        
        Write-Host "`nIssues by file extension:"
        foreach ($group in $extensionGroups) {
            Write-Host "  $($group.Name): $($group.Count)"
        }
        
        # Group by fixed status
        $statusGroups = $allIssues | Group-Object { $_.Fixed }
        
        Write-Host "`nIssues by status:"
        foreach ($group in $statusGroups) {
            $status = if ($group.Name -eq "True") { "Fixed" } else { "Not Fixed" }
            Write-Host "  $($status): $($group.Count)"
        }
    }
}

# Function to export issues to CSV
function ExportIssuesToCsv {
    param (
        [array]$allIssues,
        [string]$csvFile,
        [switch]$append
    )
    
    try {
        if ($append) {
            $allIssues | Select-Object MarkdownFile, OldPath, NewPath, NewFilename, Fixed | 
                Export-Csv -Path $csvFile -NoTypeInformation -Append
        } else {
            $allIssues | Select-Object MarkdownFile, OldPath, NewPath, NewFilename, Fixed | 
                Export-Csv -Path $csvFile -NoTypeInformation
        }
        
        Write-Host "Issues exported to $csvFile"
        return $true
    }
    catch {
        Write-Host "Error exporting issues to CSV: $_"
        return $false
    }
}

# Main execution
function Main {
    param (
        [string]$rootDir = ".",
        [switch]$fixIssues,
        [switch]$preferSnakeCase = $true,
        [int]$batchSize = 10,
        [string]$progressFile = "image-verification-progress.json",
        [string]$csvReport = "image-verification-report.csv",
        [switch]$continueFromLastRun,
        [switch]$minimalMemoryUsage
    )
    
    # Initialize progress
    $progress = $null
    
    if ($continueFromLastRun) {
        $progress = LoadProgress -progressFile $progressFile
    }
    
    if ($progress -eq $null) {
        $progress = [PSCustomObject]@{
            StartTime = Get-Date
            LastProcessedIndex = -1
            ProcessedFiles = @()
            IssueCount = 0
            ProgressFile = $progressFile
        }
    }
    else {
        Write-Host "Continuing from previous run. Last processed index: $($progress.LastProcessedIndex)"
        
        # Ensure the progress object has the IssueCount property
        if (-not (Get-Member -InputObject $progress -Name "IssueCount" -MemberType Properties)) {
            Add-Member -InputObject $progress -MemberType NoteProperty -Name "IssueCount" -Value 0
        }
        
        # Ensure the progress object has the ProgressFile property
        if (-not (Get-Member -InputObject $progress -Name "ProgressFile" -MemberType Properties)) {
            Add-Member -InputObject $progress -MemberType NoteProperty -Name "ProgressFile" -Value $progressFile
        }
    }
    
    # Get all markdown files
    $markdownFiles = Get-ChildItem -Path $rootDir -Filter "*.md" -Recurse
    
    # Filter out already processed files if continuing
    if ($continueFromLastRun -and $progress.ProcessedFiles.Count -gt 0) {
        $markdownFiles = $markdownFiles | Where-Object { $_.FullName -notin $progress.ProcessedFiles }
        Write-Host "Filtered out already processed files. Remaining: $($markdownFiles.Count)"
    }
    
    $startIndex = if ($continueFromLastRun) { $progress.LastProcessedIndex + 1 } else { 0 }
    $allIssues = @()
    
    # Initialize or clear CSV report if not in append mode
    if ($csvReport -and -not $continueFromLastRun) {
        # Create empty CSV with headers
        $emptyIssue = [PSCustomObject]@{
            MarkdownFile = ""
            OldPath = ""
            NewPath = ""
            NewFilename = ""
            Fixed = $false
        }
        $emptyIssue | Select-Object MarkdownFile, OldPath, NewPath, NewFilename, Fixed | 
            Export-Csv -Path $csvReport -NoTypeInformation
        
        # Remove the empty row
        $csvContent = Get-Content -Path $csvReport
        if ($csvContent.Count -gt 1) {
            $csvContent[0] | Set-Content -Path $csvReport
        }
    }
    
    # Process files in batches
    while ($startIndex -lt $markdownFiles.Count) {
        $result = ProcessMarkdownBatch -markdownFiles $markdownFiles -startIndex $startIndex -batchSize $batchSize `
            -fixIssues:$fixIssues -preferSnakeCase:$preferSnakeCase -progress $progress `
            -csvReport $csvReport -minimalMemoryUsage:$minimalMemoryUsage
        
        $batchIssues = $result.Issues
        $progress = $result.Progress
        
        # If not using minimal memory, add batch issues to all issues and export to CSV
        if (-not $minimalMemoryUsage) {
            $allIssues += $batchIssues
            
            # Export batch issues to CSV
            if ($csvReport) {
                ExportIssuesToCsv -allIssues $batchIssues -csvFile $csvReport -append:$continueFromLastRun
                $continueFromLastRun = $true  # For subsequent batches, always append
            }
        }
        
        # Save progress
        SaveProgress -progress $progress -progressFile $progressFile
        
        # Move to next batch
        $startIndex += $batchSize
        
        # Output batch summary
        Write-Host "Batch completed. Issues found in this batch: $($batchIssues.Count)"
        Write-Host "Total issues found so far: $($progress.IssueCount)"
        Write-Host "Progress: $($progress.LastProcessedIndex + 1) of $($markdownFiles.Count) files processed"
        
        # If all files are processed, break
        if ($progress.LastProcessedIndex -ge $markdownFiles.Count - 1) {
            break
        }
    }
    
    # Generate reports
    if ($minimalMemoryUsage) {
        # For minimal memory usage, we don't have all issues in memory, so use the count from progress
        GenerateSummaryReport -totalIssueCount $progress.IssueCount -fixIssues:$fixIssues
        Write-Host "`nDetailed report available in CSV: $csvReport"
    } else {
        GenerateSummaryReport -allIssues $allIssues -fixIssues:$fixIssues
        
        # Only show detailed report if there are a reasonable number of issues
        if ($allIssues.Count -lt 50) {
            Write-Host "`nDetailed Report:"
            Write-Host "---------------"
            
            foreach ($issue in $allIssues) {
                Write-Host "File: $($issue.MarkdownFile)"
                Write-Host "  Old path: $($issue.OldPath)"
                
                if ($issue.NewPath -ne $null) {
                    Write-Host "  New path: $($issue.NewPath)"
                    Write-Host "  New filename: $($issue.NewFilename)"
                    
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
        } else {
            Write-Host "`nToo many issues to display in console. See CSV report for details: $csvReport"
        }
    }
    
    # Return all issues (if not using minimal memory)
    if (-not $minimalMemoryUsage) {
        return $allIssues
    } else {
        return $progress.IssueCount
    }
}

# Parse command line arguments
$rootDir = "."
$fixIssues = $false
$preferSnakeCase = $true
$batchSize = 10
$progressFile = "image-verification-progress.json"
$csvReport = "image-verification-report.csv"
$continueFromLastRun = $false
$minimalMemoryUsage = $false

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
        "-batch-size" {
            $i++
            if ($i -lt $args.Count) {
                $batchSize = [int]$args[$i]
            }
        }
        "-progress-file" {
            $i++
            if ($i -lt $args.Count) {
                $progressFile = $args[$i]
            }
        }
        "-csv-report" {
            $i++
            if ($i -lt $args.Count) {
                $csvReport = $args[$i]
            }
        }
        "-continue" {
            $continueFromLastRun = $true
        }
        "-no-csv" {
            $csvReport = $null
        }
        "-minimal-memory" {
            $minimalMemoryUsage = $true
        }
    }
}

# Display run information
Write-Host "Optimized Image Reference Verification"
Write-Host "===================================="
Write-Host "Root directory: $rootDir"
Write-Host "Mode: $(if ($fixIssues) { 'Fix' } else { 'Check' })"
Write-Host "Filename preference: $(if ($preferSnakeCase) { 'Title_Snake_Case' } else { 'kebab-case' })"
Write-Host "Batch size: $batchSize"
Write-Host "Progress file: $progressFile"
Write-Host "CSV report: $(if ($csvReport) { $csvReport } else { 'Disabled' })"
Write-Host "Continue from last run: $(if ($continueFromLastRun) { 'Yes' } else { 'No' })"
Write-Host "Minimal memory usage: $(if ($minimalMemoryUsage) { 'Yes' } else { 'No' })"
Write-Host ""

# Run the main function
Main -rootDir $rootDir -fixIssues:$fixIssues -preferSnakeCase:$preferSnakeCase -batchSize $batchSize `
    -progressFile $progressFile -csvReport $csvReport -continueFromLastRun:$continueFromLastRun `
    -minimalMemoryUsage:$minimalMemoryUsage
