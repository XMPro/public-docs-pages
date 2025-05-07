# Script to identify and fix navigation issues in DocFX documentation

Write-Host "Starting navigation issue detection and fixing script..." -ForegroundColor Green

# Define the base directory
$baseDir = "."
$docsDir = Join-Path $baseDir "docs"
$tocFiles = @()

# Function to find all TOC files
function Find-TocFiles {
    param (
        [string]$Directory
    )
    
    $files = Get-ChildItem -Path $Directory -Filter "toc.yml" -Recurse
    return $files
}

# Function to parse a TOC file
function Parse-TocFile {
    param (
        [string]$FilePath
    )
    
    $content = Get-Content -Path $FilePath -Raw
    $tocEntries = @()
    
    # Simple YAML parser for toc.yml files
    $lines = $content -split "`n"
    $currentEntry = $null
    
    foreach ($line in $lines) {
        $line = $line.Trim()
        
        # Skip empty lines and comments
        if ([string]::IsNullOrWhiteSpace($line) -or $line.StartsWith("#")) {
            continue
        }
        
        # New entry starts with -
        if ($line.StartsWith("-")) {
            if ($null -ne $currentEntry) {
                $tocEntries += $currentEntry
            }
            
            $currentEntry = @{
                Name = $null
                Href = $null
                Items = @()
            }
            
            continue
        }
        
        # Parse name and href
        if ($line -match "name:\s*(.+)") {
            $currentEntry.Name = $matches[1].Trim()
        }
        elseif ($line -match "href:\s*(.+)") {
            $currentEntry.Href = $matches[1].Trim()
        }
        elseif ($line -match "homepage:\s*(.+)") {
            $currentEntry.Href = $matches[1].Trim()
        }
    }
    
    # Add the last entry
    if ($null -ne $currentEntry) {
        $tocEntries += $currentEntry
    }
    
    return @{
        Path = $FilePath
        Entries = $tocEntries
    }
}

# Function to verify a TOC file
function Verify-TocFile {
    param (
        [hashtable]$TocFile
    )
    
    $issues = @()
    $tocDir = Split-Path -Parent $TocFile.Path
    
    foreach ($entry in $TocFile.Entries) {
        # Check if href exists and is valid
        if ($null -ne $entry.Href) {
            $hrefPath = Join-Path $tocDir $entry.Href
            
            # Check if the file exists
            if (-not (Test-Path $hrefPath)) {
                $issues += @{
                    Type = "MissingFile"
                    TocFile = $TocFile.Path
                    Entry = $entry.Name
                    Href = $entry.Href
                    Path = $hrefPath
                }
            }
        }
    }
    
    return $issues
}

# Function to fix common TOC issues
function Fix-TocIssues {
    param (
        [array]$Issues
    )
    
    $fixedIssues = @()
    
    foreach ($issue in $Issues) {
        $fixed = $false
        
        switch ($issue.Type) {
            "MissingFile" {
                # Try to find the file with different extensions
                $directory = Split-Path -Parent $issue.Path
                $filename = Split-Path -Leaf $issue.Path
                $filenameWithoutExt = [System.IO.Path]::GetFileNameWithoutExtension($filename)
                
                # Check for .md file
                $mdFile = Join-Path $directory "$filenameWithoutExt.md"
                if (Test-Path $mdFile) {
                    # Fix the href in the TOC file
                    $tocContent = Get-Content -Path $issue.TocFile -Raw
                    $oldHref = "href: $($issue.Href)"
                    $newHref = "href: $($issue.Href -replace '\.[^.]+$', '.md')"
                    $newTocContent = $tocContent -replace [regex]::Escape($oldHref), $newHref
                    
                    # Save the updated TOC file
                    Set-Content -Path $issue.TocFile -Value $newTocContent
                    
                    $fixed = $true
                    $fixedIssues += @{
                        Type = $issue.Type
                        TocFile = $issue.TocFile
                        Entry = $issue.Entry
                        OldHref = $issue.Href
                        NewHref = $issue.Href -replace '\.[^.]+$', '.md'
                    }
                    
                    Write-Host "Fixed missing file issue in $($issue.TocFile) for $($issue.Entry) by changing extension to .md" -ForegroundColor Green
                }
                else {
                    # Check for .html file
                    $htmlFile = Join-Path $directory "$filenameWithoutExt.html"
                    if (Test-Path $htmlFile) {
                        # Fix the href in the TOC file
                        $tocContent = Get-Content -Path $issue.TocFile -Raw
                        $oldHref = "href: $($issue.Href)"
                        $newHref = "href: $($issue.Href -replace '\.[^.]+$', '.html')"
                        $newTocContent = $tocContent -replace [regex]::Escape($oldHref), $newHref
                        
                        # Save the updated TOC file
                        Set-Content -Path $issue.TocFile -Value $newTocContent
                        
                        $fixed = $true
                        $fixedIssues += @{
                            Type = $issue.Type
                            TocFile = $issue.TocFile
                            Entry = $issue.Entry
                            OldHref = $issue.Href
                            NewHref = $issue.Href -replace '\.[^.]+$', '.html'
                        }
                        
                        Write-Host "Fixed missing file issue in $($issue.TocFile) for $($issue.Entry) by changing extension to .html" -ForegroundColor Green
                    }
                    else {
                        # Try to find a file with a similar name
                        $files = Get-ChildItem -Path $directory -File
                        $bestMatch = $null
                        $bestMatchScore = 0
                        
                        foreach ($file in $files) {
                            $fileNameWithoutExt = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
                            $score = 0
                            
                            # Calculate similarity score (simple implementation)
                            $minLength = [Math]::Min($filenameWithoutExt.Length, $fileNameWithoutExt.Length)
                            for ($i = 0; $i -lt $minLength; $i++) {
                                if ($filenameWithoutExt[$i] -eq $fileNameWithoutExt[$i]) {
                                    $score++
                                }
                            }
                            
                            # Normalize score
                            $score = $score / [Math]::Max($filenameWithoutExt.Length, $fileNameWithoutExt.Length)
                            
                            if ($score > $bestMatchScore) {
                                $bestMatchScore = $score
                                $bestMatch = $file
                            }
                        }
                        
                        if ($null -ne $bestMatch -and $bestMatchScore > 0.7) {
                            # Fix the href in the TOC file
                            $tocContent = Get-Content -Path $issue.TocFile -Raw
                            $oldHref = "href: $($issue.Href)"
                            $newHref = "href: $($bestMatch.Name)"
                            $newTocContent = $tocContent -replace [regex]::Escape($oldHref), $newHref
                            
                            # Save the updated TOC file
                            Set-Content -Path $issue.TocFile -Value $newTocContent
                            
                            $fixed = $true
                            $fixedIssues += @{
                                Type = $issue.Type
                                TocFile = $issue.TocFile
                                Entry = $issue.Entry
                                OldHref = $issue.Href
                                NewHref = $bestMatch.Name
                            }
                            
                            Write-Host "Fixed missing file issue in $($issue.TocFile) for $($issue.Entry) by changing to similar file $($bestMatch.Name)" -ForegroundColor Green
                        }
                        else {
                            # Create a placeholder file
                            $placeholderContent = @"
# $($issue.Entry)

This is a placeholder page for "$($issue.Entry)". The actual content will be added later.

## TODO

- Add content for this page
- Update links and references
- Add images and other assets
"@
                            
                            # Ensure the directory exists
                            if (-not (Test-Path $directory)) {
                                New-Item -Path $directory -ItemType Directory -Force | Out-Null
                            }
                            
                            # Create the placeholder file
                            $placeholderFile = Join-Path $directory "$filenameWithoutExt.md"
                            Set-Content -Path $placeholderFile -Value $placeholderContent
                            
                            # Fix the href in the TOC file
                            $tocContent = Get-Content -Path $issue.TocFile -Raw
                            $oldHref = "href: $($issue.Href)"
                            $newHref = "href: $($issue.Href -replace '\.[^.]+$', '.md')"
                            $newTocContent = $tocContent -replace [regex]::Escape($oldHref), $newHref
                            
                            # Save the updated TOC file
                            Set-Content -Path $issue.TocFile -Value $newTocContent
                            
                            $fixed = $true
                            $fixedIssues += @{
                                Type = $issue.Type
                                TocFile = $issue.TocFile
                                Entry = $issue.Entry
                                OldHref = $issue.Href
                                NewHref = $issue.Href -replace '\.[^.]+$', '.md'
                                Action = "Created placeholder file"
                            }
                            
                            Write-Host "Fixed missing file issue in $($issue.TocFile) for $($issue.Entry) by creating placeholder file $placeholderFile" -ForegroundColor Green
                        }
                    }
                }
            }
        }
        
        if (-not $fixed) {
            Write-Host "Could not fix issue in $($issue.TocFile) for $($issue.Entry) ($($issue.Type))" -ForegroundColor Yellow
        }
    }
    
    return $fixedIssues
}

# Function to check for inconsistencies between TOC files
function Find-TocInconsistencies {
    param (
        [array]$TocFiles
    )
    
    $inconsistencies = @()
    
    # Group TOC files by parent directory
    $tocsByDirectory = @{}
    
    foreach ($toc in $TocFiles) {
        $directory = Split-Path -Parent $toc.Path
        $parentDirectory = Split-Path -Parent $directory
        
        if (-not $tocsByDirectory.ContainsKey($parentDirectory)) {
            $tocsByDirectory[$parentDirectory] = @()
        }
        
        $tocsByDirectory[$parentDirectory] += $toc
    }
    
    # Check for inconsistencies within each directory
    foreach ($directory in $tocsByDirectory.Keys) {
        $directoryTocs = $tocsByDirectory[$directory]
        
        if ($directoryTocs.Count -gt 1) {
            # Compare TOC entries
            for ($i = 0; $i -lt $directoryTocs.Count; $i++) {
                for ($j = $i + 1; $j -lt $directoryTocs.Count; $j++) {
                    $toc1 = $directoryTocs[$i]
                    $toc2 = $directoryTocs[$j]
                    
                    # Check for entries with the same name but different hrefs
                    foreach ($entry1 in $toc1.Entries) {
                        foreach ($entry2 in $toc2.Entries) {
                            if ($entry1.Name -eq $entry2.Name -and $entry1.Href -ne $entry2.Href) {
                                $inconsistencies += @{
                                    Type = "InconsistentHref"
                                    TocFile1 = $toc1.Path
                                    TocFile2 = $toc2.Path
                                    Entry = $entry1.Name
                                    Href1 = $entry1.Href
                                    Href2 = $entry2.Href
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    return $inconsistencies
}

# Function to fix TOC inconsistencies
function Fix-TocInconsistencies {
    param (
        [array]$Inconsistencies
    )
    
    $fixedInconsistencies = @()
    
    foreach ($inconsistency in $Inconsistencies) {
        $fixed = $false
        
        switch ($inconsistency.Type) {
            "InconsistentHref" {
                # Check which href points to an existing file
                $tocDir1 = Split-Path -Parent $inconsistency.TocFile1
                $tocDir2 = Split-Path -Parent $inconsistency.TocFile2
                
                $hrefPath1 = Join-Path $tocDir1 $inconsistency.Href1
                $hrefPath2 = Join-Path $tocDir2 $inconsistency.Href2
                
                $href1Exists = Test-Path $hrefPath1
                $href2Exists = Test-Path $hrefPath2
                
                if ($href1Exists -and -not $href2Exists) {
                    # Use href1 in both TOC files
                    $tocContent = Get-Content -Path $inconsistency.TocFile2 -Raw
                    $oldHref = "href: $($inconsistency.Href2)"
                    $newHref = "href: $($inconsistency.Href1)"
                    $newTocContent = $tocContent -replace [regex]::Escape($oldHref), $newHref
                    
                    # Save the updated TOC file
                    Set-Content -Path $inconsistency.TocFile2 -Value $newTocContent
                    
                    $fixed = $true
                    $fixedInconsistencies += @{
                        Type = $inconsistency.Type
                        TocFile = $inconsistency.TocFile2
                        Entry = $inconsistency.Entry
                        OldHref = $inconsistency.Href2
                        NewHref = $inconsistency.Href1
                    }
                    
                    Write-Host "Fixed inconsistent href in $($inconsistency.TocFile2) for $($inconsistency.Entry) by changing to $($inconsistency.Href1)" -ForegroundColor Green
                }
                elseif ($href2Exists -and -not $href1Exists) {
                    # Use href2 in both TOC files
                    $tocContent = Get-Content -Path $inconsistency.TocFile1 -Raw
                    $oldHref = "href: $($inconsistency.Href1)"
                    $newHref = "href: $($inconsistency.Href2)"
                    $newTocContent = $tocContent -replace [regex]::Escape($oldHref), $newHref
                    
                    # Save the updated TOC file
                    Set-Content -Path $inconsistency.TocFile1 -Value $newTocContent
                    
                    $fixed = $true
                    $fixedInconsistencies += @{
                        Type = $inconsistency.Type
                        TocFile = $inconsistency.TocFile1
                        Entry = $inconsistency.Entry
                        OldHref = $inconsistency.Href1
                        NewHref = $inconsistency.Href2
                    }
                    
                    Write-Host "Fixed inconsistent href in $($inconsistency.TocFile1) for $($inconsistency.Entry) by changing to $($inconsistency.Href2)" -ForegroundColor Green
                }
                elseif ($href1Exists -and $href2Exists) {
                    # Both files exist, keep both but log the inconsistency
                    Write-Host "Both files exist for inconsistent href in $($inconsistency.TocFile1) and $($inconsistency.TocFile2) for $($inconsistency.Entry)" -ForegroundColor Yellow
                    $fixed = $true
                }
                else {
                    # Neither file exists, create a placeholder file and update both TOC files
                    $tocDir1 = Split-Path -Parent $inconsistency.TocFile1
                    $placeholderContent = @"
# $($inconsistency.Entry)

This is a placeholder page for "$($inconsistency.Entry)". The actual content will be added later.

## TODO

- Add content for this page
- Update links and references
- Add images and other assets
"@
                    
                    # Create the placeholder file
                    $placeholderFile = Join-Path $tocDir1 "$($inconsistency.Entry.ToLower().Replace(' ', '-')).md"
                    $placeholderHref = "$($inconsistency.Entry.ToLower().Replace(' ', '-')).md"
                    
                    # Ensure the directory exists
                    $placeholderDir = Split-Path -Parent $placeholderFile
                    if (-not (Test-Path $placeholderDir)) {
                        New-Item -Path $placeholderDir -ItemType Directory -Force | Out-Null
                    }
                    
                    Set-Content -Path $placeholderFile -Value $placeholderContent
                    
                    # Update both TOC files
                    $tocContent1 = Get-Content -Path $inconsistency.TocFile1 -Raw
                    $oldHref1 = "href: $($inconsistency.Href1)"
                    $newHref1 = "href: $placeholderHref"
                    $newTocContent1 = $tocContent1 -replace [regex]::Escape($oldHref1), $newHref1
                    
                    $tocContent2 = Get-Content -Path $inconsistency.TocFile2 -Raw
                    $oldHref2 = "href: $($inconsistency.Href2)"
                    $newHref2 = "href: $placeholderHref"
                    $newTocContent2 = $tocContent2 -replace [regex]::Escape($oldHref2), $newHref2
                    
                    # Save the updated TOC files
                    Set-Content -Path $inconsistency.TocFile1 -Value $newTocContent1
                    Set-Content -Path $inconsistency.TocFile2 -Value $newTocContent2
                    
                    $fixed = $true
                    $fixedInconsistencies += @{
                        Type = $inconsistency.Type
                        TocFile1 = $inconsistency.TocFile1
                        TocFile2 = $inconsistency.TocFile2
                        Entry = $inconsistency.Entry
                        OldHref1 = $inconsistency.Href1
                        OldHref2 = $inconsistency.Href2
                        NewHref = $placeholderHref
                        Action = "Created placeholder file"
                    }
                    
                    Write-Host "Fixed inconsistent href in $($inconsistency.TocFile1) and $($inconsistency.TocFile2) for $($inconsistency.Entry) by creating placeholder file $placeholderFile" -ForegroundColor Green
                }
            }
        }
        
        if (-not $fixed) {
            Write-Host "Could not fix inconsistency between $($inconsistency.TocFile1) and $($inconsistency.TocFile2) for $($inconsistency.Entry) ($($inconsistency.Type))" -ForegroundColor Yellow
        }
    }
    
    return $fixedInconsistencies
}

# Function to check for broken links in markdown files
function Find-BrokenLinks {
    param (
        [string]$Directory
    )
    
    $brokenLinks = @()
    $markdownFiles = Get-ChildItem -Path $Directory -Filter "*.md" -Recurse
    
    foreach ($file in $markdownFiles) {
        $content = Get-Content -Path $file.FullName -Raw
        $fileDir = Split-Path -Parent $file.FullName
        
        # Find all markdown links
        $linkMatches = [regex]::Matches($content, '\[([^\]]+)\]\(([^)]+)\)')
        
        foreach ($match in $linkMatches) {
            $linkText = $match.Groups[1].Value
            $linkUrl = $match.Groups[2].Value
            
            # Skip external links, anchors, and absolute paths
            if ($linkUrl.StartsWith("http") -or $linkUrl.StartsWith("#") -or $linkUrl.StartsWith("/")) {
                continue
            }
            
            # Resolve the link path
            $linkPath = Join-Path $fileDir $linkUrl
            
            # Check if the file exists
            if (-not (Test-Path $linkPath)) {
                $brokenLinks += @{
                    Type = "BrokenLink"
                    File = $file.FullName
                    LinkText = $linkText
                    LinkUrl = $linkUrl
                    ResolvedPath = $linkPath
                }
            }
        }
    }
    
    return $brokenLinks
}

# Function to fix broken links in markdown files
function Fix-BrokenLinks {
    param (
        [array]$BrokenLinks
    )
    
    $fixedLinks = @()
    
    foreach ($link in $BrokenLinks) {
        $fixed = $false
        
        # Try to find the file with different extensions
        $directory = Split-Path -Parent $link.ResolvedPath
        $filename = Split-Path -Leaf $link.ResolvedPath
        $filenameWithoutExt = [System.IO.Path]::GetFileNameWithoutExtension($filename)
        
        # Check for .md file
        $mdFile = Join-Path $directory "$filenameWithoutExt.md"
        if (Test-Path $mdFile) {
            # Fix the link in the markdown file
            $content = Get-Content -Path $link.File -Raw
            $oldLink = "[$($link.LinkText)]($($link.LinkUrl))"
            $newLink = "[$($link.LinkText)]($($link.LinkUrl -replace '\.[^.]+$', '.md'))"
            $newContent = $content -replace [regex]::Escape($oldLink), $newLink
            
            # Save the updated markdown file
            Set-Content -Path $link.File -Value $newContent
            
            $fixed = $true
            $fixedLinks += @{
                Type = $link.Type
                File = $link.File
                LinkText = $link.LinkText
                OldUrl = $link.LinkUrl
                NewUrl = $link.LinkUrl -replace '\.[^.]+$', '.md'
            }
            
            Write-Host "Fixed broken link in $($link.File) for [$($link.LinkText)]($($link.LinkUrl)) by changing extension to .md" -ForegroundColor Green
        }
        else {
            # Check for .html file
            $htmlFile = Join-Path $directory "$filenameWithoutExt.html"
            if (Test-Path $htmlFile) {
                # Fix the link in the markdown file
                $content = Get-Content -Path $link.File -Raw
                $oldLink = "[$($link.LinkText)]($($link.LinkUrl))"
                $newLink = "[$($link.LinkText)]($($link.LinkUrl -replace '\.[^.]+$', '.html'))"
                $newContent = $content -replace [regex]::Escape($oldLink), $newLink
                
                # Save the updated markdown file
                Set-Content -Path $link.File -Value $newContent
                
                $fixed = $true
                $fixedLinks += @{
                    Type = $link.Type
                    File = $link.File
                    LinkText = $link.LinkText
                    OldUrl = $link.LinkUrl
                    NewUrl = $link.LinkUrl -replace '\.[^.]+$', '.html'
                }
                
                Write-Host "Fixed broken link in $($link.File) for [$($link.LinkText)]($($link.LinkUrl)) by changing extension to .html" -ForegroundColor Green
            }
            else {
                # Try to find a file with a similar name
                $files = Get-ChildItem -Path $directory -File -ErrorAction SilentlyContinue
                if ($null -ne $files) {
                    $bestMatch = $null
                    $bestMatchScore = 0
                    
                    foreach ($file in $files) {
                        $fileNameWithoutExt = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
                        $score = 0
                        
                        # Calculate similarity score (simple implementation)
                        $minLength = [Math]::Min($filenameWithoutExt.Length, $fileNameWithoutExt.Length)
                        for ($i = 0; $i -lt $minLength; $i++) {
                            if ($filenameWithoutExt[$i] -eq $fileNameWithoutExt[$i]) {
                                $score++
                            }
                        }
                        
                        # Normalize score
                        $score = $score / [Math]::Max($filenameWithoutExt.Length, $fileNameWithoutExt.Length)
                        
                        if ($score > $bestMatchScore) {
                            $bestMatchScore = $score
                            $bestMatch = $file
                        }
                    }
                    
                    if ($null -ne $bestMatch -and $bestMatchScore > 0.7) {
                        # Fix the link in the markdown file
                        $content = Get-Content -Path $link.File -Raw
                        $oldLink = "[$($link.LinkText)]($($link.LinkUrl))"
                        
                        # Calculate the relative path from the markdown file to the best match
                        $markdownDir = Split-Path -Parent $link.File
                        $bestMatchDir = Split-Path -Parent $bestMatch.FullName
                        $relativePath = Get-RelativePath -From $markdownDir -To $bestMatchDir
                        $newUrl = if ($relativePath) { "$relativePath/$($bestMatch.Name)" } else { $bestMatch.Name }
                        
                        $newLink = "[$($link.LinkText)]($newUrl)"
                        $newContent = $content -replace [regex]::Escape($oldLink), $newLink
                        
                        # Save the updated markdown file
                        Set-Content -Path $link.File -Value $newContent
                        
                        $fixed = $true
                        $fixedLinks += @{
                            Type = $link.Type
                            File = $link.File
                            LinkText = $link.LinkText
                            OldUrl = $link.LinkUrl
                            NewUrl = $newUrl
                        }
                        
                        Write-Host "Fixed broken link in $($link.File) for [$($link.LinkText)]($($link.LinkUrl)) by changing to similar file $newUrl" -ForegroundColor Green
                    }
                }
            }
        }
        
        if (-not $fixed) {
            Write-Host "Could not fix broken link in $($link.File) for [$($link.LinkText)]($($link.LinkUrl))" -ForegroundColor Yellow
        }
    }
    
    return $fixedLinks
}

# Helper function to get relative path
function Get-RelativePath {
    param (
        [string]$From,
        [string]$To
    )
    
    $fromUri = New-Object System.Uri "file://$From"
    $toUri = New-Object System.Uri "file://$To"
    
    $relativePath = [System.Uri]::UnescapeDataString($fromUri.MakeRelativeUri($toUri).ToString()).Replace('/', '\')
    
    if ($relativePath) {
        return $relativePath.Replace('\', '/')
    }
    else {
        return ""
    }
}

# Main script execution

# Find all TOC files
Write-Host "Finding TOC files..." -ForegroundColor Cyan
$tocFilesList = Find-TocFiles -Directory $docsDir
Write-Host "Found $($tocFilesList.Count) TOC files" -ForegroundColor Green

# Parse TOC files
Write-Host "Parsing TOC files..." -ForegroundColor Cyan
foreach ($tocFile in $tocFilesList) {
    $parsedToc = Parse-TocFile -FilePath $tocFile.FullName
    $tocFiles += $parsedToc
}
Write-Host "Parsed $($tocFiles.Count) TOC files" -ForegroundColor Green

# Verify TOC files
Write-Host "Verifying TOC files..." -ForegroundColor Cyan
$tocIssues = @()
foreach ($tocFile in $tocFiles) {
    $issues = Verify-TocFile -TocFile $tocFile
    $tocIssues += $issues
}
Write-Host "Found $($tocIssues.Count) issues in TOC files" -ForegroundColor $(if ($tocIssues.Count -eq 0) { "Green" } else { "Yellow" })

# Fix TOC issues
if ($tocIssues.Count -gt 0) {
    Write-Host "Fixing TOC issues..." -ForegroundColor Cyan
    $fixedTocIssues = Fix-TocIssues -Issues $tocIssues
    Write-Host "Fixed $($fixedTocIssues.Count) TOC issues" -ForegroundColor Green
}

# Find TOC inconsistencies
Write-Host "Finding TOC inconsistencies..." -ForegroundColor Cyan
$tocInconsistencies = Find-TocInconsistencies -TocFiles $tocFiles
Write-Host "Found $($tocInconsistencies.Count) TOC inconsistencies" -ForegroundColor $(if ($tocInconsistencies.Count -eq 0) { "Green" } else { "Yellow" })

# Fix TOC inconsistencies
if ($tocInconsistencies.Count -gt 0) {
    Write-Host "Fixing TOC inconsistencies..." -ForegroundColor Cyan
    $fixedTocInconsistencies = Fix-TocInconsistencies -Inconsistencies $tocInconsistencies
    Write-Host "Fixed $($fixedTocInconsistencies.Count) TOC inconsistencies" -ForegroundColor Green
}

# Find broken links in markdown files
Write-Host "Finding broken links in markdown files..." -ForegroundColor Cyan
$brokenLinks = Find-BrokenLinks -Directory $docsDir
Write-Host "Found $($brokenLinks.Count) broken links in markdown files" -ForegroundColor $(if ($brokenLinks.Count -eq 0) { "Green" } else { "Yellow" })

# Fix broken links
if ($brokenLinks.Count -gt 0) {
    Write-Host "Fixing broken links..." -ForegroundColor Cyan
    $fixedBrokenLinks = Fix-BrokenLinks -BrokenLinks $brokenLinks
    Write-Host "Fixed $($fixedBrokenLinks.Count) broken links" -ForegroundColor Green
}

# Generate a summary report
$summaryReport = @"
# Navigation Issues Fix Summary

## TOC Issues
- Total issues found: $($tocIssues.Count)
- Total issues fixed: $($fixedTocIssues.Count)

## TOC Inconsistencies
- Total inconsistencies found: $($tocInconsistencies.Count)
- Total inconsistencies fixed: $($fixedTocInconsistencies.Count)

## Broken Links
- Total broken links found: $($brokenLinks.Count)
- Total broken links fixed: $($fixedBrokenLinks.Count)

## Summary
- Total issues found: $($tocIssues.Count + $tocInconsistencies.Count + $brokenLinks.Count)
- Total issues fixed: $($fixedTocIssues.Count + $fixedTocInconsistencies.Count + $fixedBrokenLinks.Count)
"@

# Save the summary report
$summaryReportPath = Join-Path $baseDir "navigation-fix-summary.md"
Set-Content -Path $summaryReportPath -Value $summaryReport

Write-Host "`nNavigation issues fix complete!" -ForegroundColor Green
Write-Host "Summary report saved to $summaryReportPath" -ForegroundColor Green
Write-Host "`nRun the following command to verify the navigation:" -ForegroundColor Cyan
Write-Host ".\verify-navigation.ps1" -ForegroundColor Cyan
