# AI Migration Helper Script for GitBook to DocFX
# This script helps automate the migration process from GitBook to DocFX
# It handles common conversion patterns and provides utilities for batch processing

param (
    [Parameter(Mandatory = $false)]
    [string]$SourceDir = "docs-gitbook/docs",
    
    [Parameter(Mandatory = $false)]
    [string]$DestDir = "docs-docfx/docs",
    
    [Parameter(Mandatory = $false)]
    [string]$Mode = "analyze",  # Options: analyze, convert, images, toc, verify
    
    [Parameter(Mandatory = $false)]
    [string]$Section = "",  # Specific section to process, e.g., "concepts/agent"
    
    [Parameter(Mandatory = $false)]
    [switch]$Recursive = $true,
    
    [Parameter(Mandatory = $false)]
    [switch]$Force = $false
)

# Create a log file
$logFile = "docs-docfx/migration-log.txt"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Add-Content -Path $logFile -Value "=== Migration started at $timestamp ==="

function Write-Log {
    param (
        [string]$Message,
        [string]$Level = "INFO"
    )
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "[$timestamp] [$Level] $Message"
    Write-Host $logMessage
    Add-Content -Path $logFile -Value $logMessage
}

function Analyze-Structure {
    param (
        [string]$Directory,
        [switch]$Recursive
    )
    
    Write-Log "Analyzing directory structure: $Directory"
    
    if ($Recursive) {
        $files = Get-ChildItem -Path $Directory -Recurse -File | Where-Object { $_.Extension -eq ".md" }
    }
    else {
        $files = Get-ChildItem -Path $Directory -File | Where-Object { $_.Extension -eq ".md" }
    }
    
    Write-Log "Found $($files.Count) Markdown files"
    
    # Analyze file types and patterns
    $summaryFiles = $files | Where-Object { $_.Name -eq "SUMMARY.md" }
    $readmeFiles = $files | Where-Object { $_.Name -eq "README.md" }
    $otherFiles = $files | Where-Object { $_.Name -ne "SUMMARY.md" -and $_.Name -ne "README.md" }
    
    Write-Log "Summary files: $($summaryFiles.Count)"
    Write-Log "README files: $($readmeFiles.Count)"
    Write-Log "Other Markdown files: $($otherFiles.Count)"
    
    # Analyze content patterns
    $hintPatternCount = 0
    $tabPatternCount = 0
    $imagePatternCount = 0
    $linkPatternCount = 0
    
    foreach ($file in $files) {
        $content = Get-Content -Path $file.FullName -Raw
        
        # Count GitBook hint patterns
        $hintMatches = [regex]::Matches($content, '{% hint style="(info|warning|danger)" %}([\s\S]*?){% endhint %}')
        $hintPatternCount += $hintMatches.Count
        
        # Count GitBook tab patterns
        $tabMatches = [regex]::Matches($content, '{% tabs %}([\s\S]*?){% endtabs %}')
        $tabPatternCount += $tabMatches.Count
        
        # Count image references
        $imageMatches = [regex]::Matches($content, '!\[.*?\]\(.*?\)')
        $imagePatternCount += $imageMatches.Count
        
        # Count internal links
        $linkMatches = [regex]::Matches($content, '\[.*?\]\(.*?\.md.*?\)')
        $linkPatternCount += $linkMatches.Count
    }
    
    Write-Log "GitBook hint patterns found: $hintPatternCount"
    Write-Log "GitBook tab patterns found: $tabPatternCount"
    Write-Log "Image references found: $imagePatternCount"
    Write-Log "Internal links found: $linkPatternCount"
    
    # Return analysis summary
    return @{
        TotalFiles = $files.Count
        SummaryFiles = $summaryFiles.Count
        ReadmeFiles = $readmeFiles.Count
        OtherFiles = $otherFiles.Count
        HintPatterns = $hintPatternCount
        TabPatterns = $tabPatternCount
        ImageReferences = $imagePatternCount
        InternalLinks = $linkPatternCount
    }
}

function Convert-GitBookToDocFX {
    param (
        [string]$SourceFile,
        [string]$DestFile
    )
    
    Write-Log "Converting file: $SourceFile -> $DestFile"
    
    # Create destination directory if it doesn't exist
    $destDir = Split-Path -Path $DestFile -Parent
    if (-not (Test-Path -Path $destDir)) {
        New-Item -Path $destDir -ItemType Directory -Force | Out-Null
        Write-Log "Created directory: $destDir"
    }
    
    # Read source content
    $content = Get-Content -Path $SourceFile -Raw
    
    # Convert GitBook hint patterns to DocFX alerts
    $content = [regex]::Replace(
        $content,
        '{% hint style="info" %}([\s\S]*?){% endhint %}',
        {
            param($match)
            $hintContent = $match.Groups[1].Value.Trim()
            $lines = $hintContent -split "`n"
            $formattedLines = $lines | ForEach-Object { "> $_" }
            "> [!NOTE]`n" + ($formattedLines -join "`n")
        }
    )
    
    $content = [regex]::Replace(
        $content,
        '{% hint style="warning" %}([\s\S]*?){% endhint %}',
        {
            param($match)
            $hintContent = $match.Groups[1].Value.Trim()
            $lines = $hintContent -split "`n"
            $formattedLines = $lines | ForEach-Object { "> $_" }
            "> [!WARNING]`n" + ($formattedLines -join "`n")
        }
    )
    
    $content = [regex]::Replace(
        $content,
        '{% hint style="danger" %}([\s\S]*?){% endhint %}',
        {
            param($match)
            $hintContent = $match.Groups[1].Value.Trim()
            $lines = $hintContent -split "`n"
            $formattedLines = $lines | ForEach-Object { "> $_" }
            "> [!CAUTION]`n" + ($formattedLines -join "`n")
        }
    )
    
    # Convert GitBook tabs to DocFX tabs
    $content = [regex]::Replace(
        $content,
        '{% tabs %}([\s\S]*?){% endtabs %}',
        {
            param($match)
            $tabsContent = $match.Groups[1].Value
            $tabMatches = [regex]::Matches($tabsContent, '{% tab title="(.*?)" %}([\s\S]*?){% endtab %}')
            
            $result = ""
            foreach ($tabMatch in $tabMatches) {
                $tabTitle = $tabMatch.Groups[1].Value
                $tabContent = $tabMatch.Groups[2].Value.Trim()
                $tabId = $tabTitle.ToLower() -replace '\s+', '-'
                
                $result += "# [$tabTitle](#tab/$tabId)`n$tabContent`n`n"
            }
            
            $result += "***"
            return $result
        }
    )
    
    # Update image paths from GitBook assets to DocFX images
    $content = [regex]::Replace(
        $content,
        '!\[(.*?)\]\((.*?)/\.gitbook/assets/(.*?)\)',
        '![$1](../images/$3)'
    )
    
    $content = [regex]::Replace(
        $content,
        '!\[(.*?)\]\((.*?)assets/(.*?)\)',
        '![$1](../images/$3)'
    )
    
    # Update internal links
    $content = [regex]::Replace(
        $content,
        '\[(.*?)\]\((.*?)\.md(.*?)\)',
        {
            param($match)
            $linkText = $match.Groups[1].Value
            $linkPath = $match.Groups[2].Value
            $linkAnchor = $match.Groups[3].Value
            
            # Normalize path
            $normalizedPath = $linkPath -replace '\\', '/'
            
            # Return updated link
            "[$linkText]($normalizedPath.md$linkAnchor)"
        }
    )
    
    # Write converted content to destination file
    Set-Content -Path $DestFile -Value $content
    Write-Log "Converted file saved: $DestFile"
    
    # Return conversion statistics
    return @{
        SourceFile = $SourceFile
        DestFile = $DestFile
        HintConversions = ([regex]::Matches($content, '> \[!(NOTE|WARNING|CAUTION)\]')).Count
        TabConversions = ([regex]::Matches($content, '# \[(.*?)\]\(#tab/(.*?)\)')).Count
        ImagePathUpdates = ([regex]::Matches($content, '!\[(.*?)\]\(../images/(.*?)\)')).Count
        LinkUpdates = ([regex]::Matches($content, '\[(.*?)\]\((.*?)\.md(.*?)\)')).Count
    }
}

function Process-Images {
    param (
        [string]$SourceDir,
        [string]$DestDir
    )
    
    Write-Log "Processing images from $SourceDir to $DestDir"
    
    # Find all image files in GitBook assets directory
    $assetsDirs = @(
        "$SourceDir/.gitbook/assets",
        "$SourceDir/assets"
    )
    
    $imageFiles = @()
    foreach ($assetsDir in $assetsDirs) {
        if (Test-Path -Path $assetsDir) {
            $imageFiles += Get-ChildItem -Path $assetsDir -Recurse -File | Where-Object {
                $_.Extension -match '\.(png|jpg|jpeg|gif|svg)$'
            }
        }
    }
    
    Write-Log "Found $($imageFiles.Count) image files"
    
    # Process each image file
    $processedCount = 0
    foreach ($imageFile in $imageFiles) {
        # Determine destination path
        $relativePath = $imageFile.FullName.Replace("$SourceDir/.gitbook/assets\", "").Replace("$SourceDir/assets\", "")
        $destPath = Join-Path -Path $DestDir -ChildPath "images/$relativePath"
        
        # Create destination directory if it doesn't exist
        $destDir = Split-Path -Path $destPath -Parent
        if (-not (Test-Path -Path $destDir)) {
            New-Item -Path $destDir -ItemType Directory -Force | Out-Null
            Write-Log "Created directory: $destDir"
        }
        
        # Copy image file
        Copy-Item -Path $imageFile.FullName -Destination $destPath -Force
        $processedCount++
        
        Write-Log "Copied image: $($imageFile.FullName) -> $destPath"
    }
    
    Write-Log "Processed $processedCount image files"
    
    return @{
        TotalImages = $imageFiles.Count
        ProcessedImages = $processedCount
    }
}

function Convert-SummaryToToc {
    param (
        [string]$SummaryFile,
        [string]$TocFile
    )
    
    Write-Log "Converting SUMMARY.md to toc.yml: $SummaryFile -> $TocFile"
    
    # Read SUMMARY.md content
    $content = Get-Content -Path $SummaryFile -Raw
    
    # Extract links
    $links = [regex]::Matches($content, '\[(.*?)\]\((.*?)\)')
    
    # Create TOC structure
    $toc = @()
    foreach ($link in $links) {
        $name = $link.Groups[1].Value
        $url = $link.Groups[2].Value
        
        # Skip external links
        if ($url -match '^https?://') {
            continue
        }
        
        # Normalize URL
        $url = $url -replace '\.md$', ''
        
        $toc += @{
            name = $name
            href = $url
        }
    }
    
    # Convert to YAML
    $yaml = ""
    foreach ($item in $toc) {
        $yaml += "- name: $($item.name)`n"
        $yaml += "  href: $($item.href)`n"
    }
    
    # Create destination directory if it doesn't exist
    $destDir = Split-Path -Path $TocFile -Parent
    if (-not (Test-Path -Path $destDir)) {
        New-Item -Path $destDir -ItemType Directory -Force | Out-Null
        Write-Log "Created directory: $destDir"
    }
    
    # Write TOC file
    Set-Content -Path $TocFile -Value $yaml
    Write-Log "TOC file created: $TocFile"
    
    return @{
        SourceFile = $SummaryFile
        TocFile = $TocFile
        ItemCount = $toc.Count
    }
}

function Verify-Migration {
    param (
        [string]$Directory,
        [switch]$Recursive
    )
    
    Write-Log "Verifying migration in directory: $Directory"
    
    if ($Recursive) {
        $files = Get-ChildItem -Path $Directory -Recurse -File | Where-Object { $_.Extension -eq ".md" }
    }
    else {
        $files = Get-ChildItem -Path $Directory -File | Where-Object { $_.Extension -eq ".md" }
    }
    
    Write-Log "Found $($files.Count) Markdown files to verify"
    
    $issues = @()
    
    foreach ($file in $files) {
        $content = Get-Content -Path $file.FullName -Raw
        
        # Check for remaining GitBook syntax
        $gitbookSyntax = [regex]::Matches($content, '({%.*?%})')
        if ($gitbookSyntax.Count -gt 0) {
            foreach ($match in $gitbookSyntax) {
                $issues += @{
                    File = $file.FullName
                    Type = "GitBook Syntax"
                    Issue = $match.Groups[1].Value
                    Line = ($content.Substring(0, $match.Index) -split "`n").Length
                }
            }
        }
        
        # Check for broken image links
        $imageLinks = [regex]::Matches($content, '!\[.*?\]\((.*?)\)')
        foreach ($match in $imageLinks) {
            $imagePath = $match.Groups[1].Value
            
            # Skip external images
            if ($imagePath -match '^https?://') {
                continue
            }
            
            # Check if image exists
            $fullImagePath = Join-Path -Path (Split-Path -Path $file.FullName -Parent) -ChildPath $imagePath
            if (-not (Test-Path -Path $fullImagePath)) {
                $issues += @{
                    File = $file.FullName
                    Type = "Broken Image Link"
                    Issue = $imagePath
                    Line = ($content.Substring(0, $match.Index) -split "`n").Length
                }
            }
        }
        
        # Check for broken internal links
        $internalLinks = [regex]::Matches($content, '\[.*?\]\((.*?)\.md(.*?)\)')
        foreach ($match in $internalLinks) {
            $linkPath = $match.Groups[1].Value + ".md"
            
            # Skip external links
            if ($linkPath -match '^https?://') {
                continue
            }
            
            # Check if linked file exists
            $fullLinkPath = Join-Path -Path (Split-Path -Path $file.FullName -Parent) -ChildPath $linkPath
            if (-not (Test-Path -Path $fullLinkPath)) {
                $issues += @{
                    File = $file.FullName
                    Type = "Broken Internal Link"
                    Issue = $linkPath
                    Line = ($content.Substring(0, $match.Index) -split "`n").Length
                }
            }
        }
    }
    
    # Write issues to log
    if ($issues.Count -gt 0) {
        Write-Log "Found $($issues.Count) issues during verification" -Level "WARNING"
        
        foreach ($issue in $issues) {
            Write-Log "Issue in $($issue.File) (Line $($issue.Line)): [$($issue.Type)] $($issue.Issue)" -Level "WARNING"
        }
        
        # Write issues to a report file
        $reportFile = "docs-docfx/verification-issues.txt"
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Set-Content -Path $reportFile -Value "=== Verification Issues Report: $timestamp ==="
        
        foreach ($issue in $issues) {
            Add-Content -Path $reportFile -Value "[$($issue.Type)] $($issue.File) (Line $($issue.Line)): $($issue.Issue)"
        }
        
        Write-Log "Verification issues report saved to: $reportFile"
    }
    else {
        Write-Log "No issues found during verification"
    }
    
    return @{
        FilesChecked = $files.Count
        IssuesFound = $issues.Count
        Issues = $issues
    }
}

function Process-Section {
    param (
        [string]$Section
    )
    
    Write-Log "Processing section: $Section"
    
    $sourceSection = Join-Path -Path $SourceDir -ChildPath $Section
    $destSection = Join-Path -Path $DestDir -ChildPath $Section
    
    # Check if source section exists
    if (-not (Test-Path -Path $sourceSection)) {
        Write-Log "Source section not found: $sourceSection" -Level "ERROR"
        return
    }
    
    # Create destination section if it doesn't exist
    if (-not (Test-Path -Path $destSection)) {
        New-Item -Path $destSection -ItemType Directory -Force | Out-Null
        Write-Log "Created directory: $destSection"
    }
    
    # Process files in the section
    $files = Get-ChildItem -Path $sourceSection -File | Where-Object { $_.Extension -eq ".md" }
    
    foreach ($file in $files) {
        $destFile = Join-Path -Path $destSection -ChildPath $file.Name
        
        # Skip if destination file exists and -Force is not specified
        if ((Test-Path -Path $destFile) -and -not $Force) {
            Write-Log "Skipping existing file: $destFile (use -Force to overwrite)" -Level "WARNING"
            continue
        }
        
        # Convert file
        Convert-GitBookToDocFX -SourceFile $file.FullName -DestFile $destFile
    }
    
    # Process images
    Process-Images -SourceDir $sourceSection -DestDir $destSection
    
    # Process TOC if SUMMARY.md exists
    $summaryFile = Join-Path -Path $sourceSection -ChildPath "SUMMARY.md"
    if (Test-Path -Path $summaryFile) {
        $tocFile = Join-Path -Path $destSection -ChildPath "toc.yml"
        Convert-SummaryToToc -SummaryFile $summaryFile -TocFile $tocFile
    }
    
    # Process subdirectories if -Recursive is specified
    if ($Recursive) {
        $subdirs = Get-ChildItem -Path $sourceSection -Directory
        
        foreach ($subdir in $subdirs) {
            $subSection = Join-Path -Path $Section -ChildPath $subdir.Name
            Process-Section -Section $subSection
        }
    }
    
    Write-Log "Completed processing section: $Section"
}

# Main execution logic
try {
    Write-Log "Starting migration in mode: $Mode"
    
    switch ($Mode) {
        "analyze" {
            Analyze-Structure -Directory $SourceDir -Recursive:$Recursive
        }
        "convert" {
            if ($Section) {
                Process-Section -Section $Section
            }
            else {
                # Process all sections
                $sections = Get-ChildItem -Path $SourceDir -Directory
                
                foreach ($section in $sections) {
                    Process-Section -Section $section.Name
                }
                
                # Process root files
                $rootFiles = Get-ChildItem -Path $SourceDir -File | Where-Object { $_.Extension -eq ".md" }
                
                foreach ($file in $rootFiles) {
                    $destFile = Join-Path -Path $DestDir -ChildPath $file.Name
                    
                    # Skip if destination file exists and -Force is not specified
                    if ((Test-Path -Path $destFile) -and -not $Force) {
                        Write-Log "Skipping existing file: $destFile (use -Force to overwrite)" -Level "WARNING"
                        continue
                    }
                    
                    # Convert file
                    Convert-GitBookToDocFX -SourceFile $file.FullName -DestFile $destFile
                }
                
                # Process root TOC if SUMMARY.md exists
                $summaryFile = Join-Path -Path $SourceDir -ChildPath "SUMMARY.md"
                if (Test-Path -Path $summaryFile) {
                    $tocFile = Join-Path -Path $DestDir -ChildPath "toc.yml"
                    Convert-SummaryToToc -SummaryFile $summaryFile -TocFile $tocFile
                }
            }
        }
        "images" {
            if ($Section) {
                $sourceSection = Join-Path -Path $SourceDir -ChildPath $Section
                $destSection = Join-Path -Path $DestDir -ChildPath $Section
                Process-Images -SourceDir $sourceSection -DestDir $destSection
            }
            else {
                Process-Images -SourceDir $SourceDir -DestDir $DestDir
            }
        }
        "toc" {
            if ($Section) {
                $sourceSection = Join-Path -Path $SourceDir -ChildPath $Section
                $destSection = Join-Path -Path $DestDir -ChildPath $Section
                
                $summaryFile = Join-Path -Path $sourceSection -ChildPath "SUMMARY.md"
                if (Test-Path -Path $summaryFile) {
                    $tocFile = Join-Path -Path $destSection -ChildPath "toc.yml"
                    Convert-SummaryToToc -SummaryFile $summaryFile -TocFile $tocFile
                }
                else {
                    Write-Log "SUMMARY.md not found in section: $Section" -Level "WARNING"
                }
            }
            else {
                $summaryFile = Join-Path -Path $SourceDir -ChildPath "SUMMARY.md"
                if (Test-Path -Path $summaryFile) {
                    $tocFile = Join-Path -Path $DestDir -ChildPath "toc.yml"
                    Convert-SummaryToToc -SummaryFile $summaryFile -TocFile $tocFile
                }
                else {
                    Write-Log "SUMMARY.md not found in root directory" -Level "WARNING"
                }
            }
        }
        "verify" {
            if ($Section) {
                $destSection = Join-Path -Path $DestDir -ChildPath $Section
                Verify-Migration -Directory $destSection -Recursive:$Recursive
            }
            else {
                Verify-Migration -Directory $DestDir -Recursive:$Recursive
            }
        }
        default {
            Write-Log "Invalid mode: $Mode. Valid modes are: analyze, convert, images, toc, verify" -Level "ERROR"
        }
    }
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $logFile -Value "=== Migration completed at $timestamp ==="
    
    Write-Log "Migration completed successfully"
}
catch {
    Write-Log "Error during migration: $_" -Level "ERROR"
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $logFile -Value "=== Migration failed at $timestamp ==="
    Add-Content -Path $logFile -Value "ERROR: $_"
    
    throw $_
}

# Usage examples:
# 
# Analyze GitBook structure:
# .\ai-migration-helper.ps1 -Mode analyze
# 
# Convert a specific section:
# .\ai-migration-helper.ps1 -Mode convert -Section "concepts/agent"
# 
# Process images for the entire project:
# .\ai-migration-helper.ps1 -Mode images
# 
# Generate TOC files:
# .\ai-migration-helper.ps1 -Mode toc
# 
# Verify migration:
# .\ai-migration-helper.ps1 -Mode verify
