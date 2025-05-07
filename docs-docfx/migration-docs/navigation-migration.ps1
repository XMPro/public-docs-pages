# Navigation Migration Script
# This script implements the navigation migration plan to update the DocFX navigation structure
# to match the GitBook functionality.

# Base directories
$baseDir = "."
$docsDir = Join-Path $baseDir "docs-docfx"
$resourcesDir = Join-Path $docsDir "docs/resources"
$faqsDir = Join-Path $resourcesDir "faqs"
$externalContentDir = Join-Path $faqsDir "external-content"

# State tracking
$stateFile = Join-Path $docsDir "migration-docs/navigation-migration-state.json"
$logFile = Join-Path $docsDir "migration-docs/navigation-migration.log"

# Initialize logging
function Write-Log {
    param (
        [string]$Message,
        [string]$Level = "INFO"
    )
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "[$timestamp] [$Level] $Message"
    
    # Write to console
    switch ($Level) {
        "ERROR" { Write-Host $logMessage -ForegroundColor Red }
        "WARNING" { Write-Host $logMessage -ForegroundColor Yellow }
        "SUCCESS" { Write-Host $logMessage -ForegroundColor Green }
        default { Write-Host $logMessage }
    }
    
    # Write to log file
    Add-Content -Path $logFile -Value $logMessage
}

# Initialize state tracking
function Initialize-State {
    if (Test-Path $stateFile) {
        Write-Log "State file found. Loading existing state."
        $script:state = Get-Content $stateFile | ConvertFrom-Json
    }
    else {
        Write-Log "No state file found. Initializing new state."
        $script:state = @{
            phase = 0
            completed = $false
            directories_created = @()
            toc_files_created = @()
            index_files_created = @()
            years_completed = @{
                blogs = @()
                youtube = @()
            }
            blogs_migrated = @{}
            use_cases_migrated = @()
            youtube_migrated = @{}
            resources_toc_updated = $false
            testing_completed = $false
            issues_found = @()
            last_updated = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
        }
        Save-State
    }
}

# Save state function
function Save-State {
    $script:state.last_updated = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $script:state | ConvertTo-Json -Depth 10 | Set-Content $stateFile
    Write-Log "State saved to $stateFile"
}

# Phase 1: Create Base Directory Structure
function Execute-Phase1 {
    Write-Log "Executing Phase 1: Create Base Directory Structure" -Level "INFO"
    
    # Create external content directory if it doesn't exist
    if (-not (Test-Path $externalContentDir)) {
        Write-Log "Creating directory: $externalContentDir"
        New-Item -Path $externalContentDir -ItemType Directory -Force | Out-Null
        $script:state.directories_created += $externalContentDir
    }
    
    # Create blogs directory
    $blogsDir = Join-Path $externalContentDir "blogs"
    if (-not (Test-Path $blogsDir)) {
        Write-Log "Creating directory: $blogsDir"
        New-Item -Path $blogsDir -ItemType Directory -Force | Out-Null
        $script:state.directories_created += $blogsDir
    }
    
    # Create blog year directories
    $blogYears = @("2024", "2023", "2022", "2021", "2020", "2019", "2018", "2017", "2016", "2015", "2014", "2013", "2012", "2011", "2010")
    foreach ($year in $blogYears) {
        $yearDir = Join-Path $blogsDir $year
        if (-not (Test-Path $yearDir)) {
            Write-Log "Creating directory: $yearDir"
            New-Item -Path $yearDir -ItemType Directory -Force | Out-Null
            $script:state.directories_created += $yearDir
        }
    }
    
    # Create use cases directory
    $useCasesDir = Join-Path $externalContentDir "use-cases"
    if (-not (Test-Path $useCasesDir)) {
        Write-Log "Creating directory: $useCasesDir"
        New-Item -Path $useCasesDir -ItemType Directory -Force | Out-Null
        $script:state.directories_created += $useCasesDir
    }
    
    # Create YouTube directory
    $youtubeDir = Join-Path $externalContentDir "youtube"
    if (-not (Test-Path $youtubeDir)) {
        Write-Log "Creating directory: $youtubeDir"
        New-Item -Path $youtubeDir -ItemType Directory -Force | Out-Null
        $script:state.directories_created += $youtubeDir
    }
    
    # Create YouTube year directories
    $youtubeYears = @("2024", "2023", "2022", "2021", "2020", "2019", "2016", "2013", "2012")
    foreach ($year in $youtubeYears) {
        $yearDir = Join-Path $youtubeDir $year
        if (-not (Test-Path $yearDir)) {
            Write-Log "Creating directory: $yearDir"
            New-Item -Path $yearDir -ItemType Directory -Force | Out-Null
            $script:state.directories_created += $yearDir
        }
    }
    
    # Verify all directories have been created
    $allDirectoriesExist = $true
    foreach ($dir in $script:state.directories_created) {
        if (-not (Test-Path $dir)) {
            Write-Log "Directory not found: $dir" -Level "ERROR"
            $allDirectoriesExist = $false
        }
    }
    
    if ($allDirectoriesExist) {
        Write-Log "All directories created successfully" -Level "SUCCESS"
        $script:state.phase = 1
        $script:state.completed = $true
        Save-State
        return $true
    }
    else {
        Write-Log "Some directories could not be created" -Level "ERROR"
        return $false
    }
}

# Phase 2: Create TOC Files for Main Sections
function Execute-Phase2 {
    Write-Log "Executing Phase 2: Create TOC Files for Main Sections" -Level "INFO"
    
    # Create toc.yml for external-content directory
    $externalContentToc = @"
- name: External Content
  href: index.md
- name: Blogs
  href: blogs/
  items:
  - name: 2024
    href: blogs/2024/
  - name: 2023
    href: blogs/2023/
  - name: 2022
    href: blogs/2022/
  - name: 2021
    href: blogs/2021/
  - name: 2020
    href: blogs/2020/
  - name: 2019
    href: blogs/2019/
  - name: 2018
    href: blogs/2018/
  - name: 2017
    href: blogs/2017/
  - name: 2016
    href: blogs/2016/
  - name: 2015
    href: blogs/2015/
  - name: 2014
    href: blogs/2014/
  - name: 2013
    href: blogs/2013/
  - name: 2012
    href: blogs/2012/
  - name: 2011
    href: blogs/2011/
  - name: 2010
    href: blogs/2010/
- name: Use Cases
  href: use-cases/
- name: YouTube
  href: youtube/
  items:
  - name: 2024
    href: youtube/2024/
  - name: 2023
    href: youtube/2023/
  - name: 2022
    href: youtube/2022/
  - name: 2021
    href: youtube/2021/
  - name: 2020
    href: youtube/2020/
  - name: 2019
    href: youtube/2019/
  - name: 2016
    href: youtube/2016/
  - name: 2013
    href: youtube/2013/
  - name: 2012
    href: youtube/2012/
"@
    
    $externalContentTocPath = Join-Path $externalContentDir "toc.yml"
    if (-not (Test-Path $externalContentTocPath)) {
        Write-Log "Creating TOC file: $externalContentTocPath"
        Set-Content -Path $externalContentTocPath -Value $externalContentToc
        $script:state.toc_files_created += $externalContentTocPath
    }
    
    # Create toc.yml for blogs directory
    $blogsToc = @"
- name: Blogs
  href: index.md
- name: 2024
  href: 2024/
- name: 2023
  href: 2023/
- name: 2022
  href: 2022/
- name: 2021
  href: 2021/
- name: 2020
  href: 2020/
- name: 2019
  href: 2019/
- name: 2018
  href: 2018/
- name: 2017
  href: 2017/
- name: 2016
  href: 2016/
- name: 2015
  href: 2015/
- name: 2014
  href: 2014/
- name: 2013
  href: 2013/
- name: 2012
  href: 2012/
- name: 2011
  href: 2011/
- name: 2010
  href: 2010/
"@
    
    $blogsTocPath = Join-Path $externalContentDir "blogs/toc.yml"
    if (-not (Test-Path $blogsTocPath)) {
        Write-Log "Creating TOC file: $blogsTocPath"
        Set-Content -Path $blogsTocPath -Value $blogsToc
        $script:state.toc_files_created += $blogsTocPath
    }
    
    # Create toc.yml for use cases directory
    $useCasesToc = @"
- name: Use Cases
  href: index.md
"@
    
    $useCasesTocPath = Join-Path $externalContentDir "use-cases/toc.yml"
    if (-not (Test-Path $useCasesTocPath)) {
        Write-Log "Creating TOC file: $useCasesTocPath"
        Set-Content -Path $useCasesTocPath -Value $useCasesToc
        $script:state.toc_files_created += $useCasesTocPath
    }
    
    # Create toc.yml for YouTube directory
    $youtubeToc = @"
- name: YouTube
  href: index.md
- name: 2024
  href: 2024/
- name: 2023
  href: 2023/
- name: 2022
  href: 2022/
- name: 2021
  href: 2021/
- name: 2020
  href: 2020/
- name: 2019
  href: 2019/
- name: 2016
  href: 2016/
- name: 2013
  href: 2013/
- name: 2012
  href: 2012/
"@
    
    $youtubeTocPath = Join-Path $externalContentDir "youtube/toc.yml"
    if (-not (Test-Path $youtubeTocPath)) {
        Write-Log "Creating TOC file: $youtubeTocPath"
        Set-Content -Path $youtubeTocPath -Value $youtubeToc
        $script:state.toc_files_created += $youtubeTocPath
    }
    
    # Verify all TOC files have been created
    $allTocFilesExist = $true
    foreach ($file in $script:state.toc_files_created) {
        if (-not (Test-Path $file)) {
            Write-Log "TOC file not found: $file" -Level "ERROR"
            $allTocFilesExist = $false
        }
    }
    
    if ($allTocFilesExist) {
        Write-Log "All TOC files created successfully" -Level "SUCCESS"
        $script:state.phase = 2
        $script:state.completed = $true
        Save-State
        return $true
    }
    else {
        Write-Log "Some TOC files could not be created" -Level "ERROR"
        return $false
    }
}

# Phase 3: Create Index Files for Main Sections
function Execute-Phase3 {
    Write-Log "Executing Phase 3: Create Index Files for Main Sections" -Level "INFO"
    
    # Create index.md for external-content directory
    $externalContentIndex = @"
# External Content

This section contains external content related to XMPro, including blogs, use cases, and YouTube videos.

## Blogs

Articles from the XMPro blog covering various topics related to digital twins, IoT, and industrial applications.

[View Blogs](blogs/)

## Use Cases

Real-world use cases demonstrating how XMPro is used in various industries.

[View Use Cases](use-cases/)

## YouTube

Video content from the XMPro YouTube channel, including tutorials, webinars, and product demonstrations.

[View YouTube Content](youtube/)
"@
    
    $externalContentIndexPath = Join-Path $externalContentDir "index.md"
    if (-not (Test-Path $externalContentIndexPath)) {
        Write-Log "Creating index file: $externalContentIndexPath"
        Set-Content -Path $externalContentIndexPath -Value $externalContentIndex
        $script:state.index_files_created += $externalContentIndexPath
    }
    
    # Create index.md for blogs directory
    $blogsIndex = @"
# Blogs

Articles from the XMPro blog covering various topics related to digital twins, IoT, and industrial applications.

## By Year

- [2024](2024/)
- [2023](2023/)
- [2022](2022/)
- [2021](2021/)
- [2020](2020/)
- [2019](2019/)
- [2018](2018/)
- [2017](2017/)
- [2016](2016/)
- [2015](2015/)
- [2014](2014/)
- [2013](2013/)
- [2012](2012/)
- [2011](2011/)
- [2010](2010/)
"@
    
    $blogsIndexPath = Join-Path $externalContentDir "blogs/index.md"
    if (-not (Test-Path $blogsIndexPath)) {
        Write-Log "Creating index file: $blogsIndexPath"
        Set-Content -Path $blogsIndexPath -Value $blogsIndex
        $script:state.index_files_created += $blogsIndexPath
    }
    
    # Create index.md for use cases directory
    $useCasesIndex = @"
# Use Cases

Real-world use cases demonstrating how XMPro is used in various industries.
"@
    
    $useCasesIndexPath = Join-Path $externalContentDir "use-cases/index.md"
    if (-not (Test-Path $useCasesIndexPath)) {
        Write-Log "Creating index file: $useCasesIndexPath"
        Set-Content -Path $useCasesIndexPath -Value $useCasesIndex
        $script:state.index_files_created += $useCasesIndexPath
    }
    
    # Create index.md for YouTube directory
    $youtubeIndex = @"
# YouTube

Video content from the XMPro YouTube channel, including tutorials, webinars, and product demonstrations.

## By Year

- [2024](2024/)
- [2023](2023/)
- [2022](2022/)
- [2021](2021/)
- [2020](2020/)
- [2019](2019/)
- [2016](2016/)
- [2013](2013/)
- [2012](2012/)
"@
    
    $youtubeIndexPath = Join-Path $externalContentDir "youtube/index.md"
    if (-not (Test-Path $youtubeIndexPath)) {
        Write-Log "Creating index file: $youtubeIndexPath"
        Set-Content -Path $youtubeIndexPath -Value $youtubeIndex
        $script:state.index_files_created += $youtubeIndexPath
    }
    
    # Verify all index files have been created
    $allIndexFilesExist = $true
    foreach ($file in $script:state.index_files_created) {
        if (-not (Test-Path $file)) {
            Write-Log "Index file not found: $file" -Level "ERROR"
            $allIndexFilesExist = $false
        }
    }
    
    if ($allIndexFilesExist) {
        Write-Log "All index files created successfully" -Level "SUCCESS"
        $script:state.phase = 3
        $script:state.completed = $true
        Save-State
        return $true
    }
    else {
        Write-Log "Some index files could not be created" -Level "ERROR"
        return $false
    }
}

# Main execution
function Start-Migration {
    Write-Log "Starting navigation migration script" -Level "INFO"
    
    # Initialize state
    Initialize-State
    
    # Execute phases based on current state
    switch ($script:state.phase) {
        0 {
            Write-Log "Starting migration from the beginning..." -Level "INFO"
            $script:state.phase = 1
            $script:state.completed = $false
            Save-State
            if (Execute-Phase1) {
                Write-Log "Phase 1 completed successfully. Moving to Phase 2." -Level "SUCCESS"
                $script:state.phase = 2
                $script:state.completed = $false
                Save-State
                if (Execute-Phase2) {
                    Write-Log "Phase 2 completed successfully. Moving to Phase 3." -Level "SUCCESS"
                    $script:state.phase = 3
                    $script:state.completed = $false
                    Save-State
                    if (Execute-Phase3) {
                        Write-Log "Phase 3 completed successfully." -Level "SUCCESS"
                        Write-Log "Initial navigation structure setup complete." -Level "SUCCESS"
                        Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                    }
                }
            }
        }
        1 {
            if (-not $script:state.completed) {
                Write-Log "Resuming Phase 1: Create Base Directory Structure..." -Level "INFO"
                if (Execute-Phase1) {
                    Write-Log "Phase 1 completed successfully. Moving to Phase 2." -Level "SUCCESS"
                    $script:state.phase = 2
                    $script:state.completed = $false
                    Save-State
                    if (Execute-Phase2) {
                        Write-Log "Phase 2 completed successfully. Moving to Phase 3." -Level "SUCCESS"
                        $script:state.phase = 3
                        $script:state.completed = $false
                        Save-State
                        if (Execute-Phase3) {
                            Write-Log "Phase 3 completed successfully." -Level "SUCCESS"
                            Write-Log "Initial navigation structure setup complete." -Level "SUCCESS"
                            Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                        }
                    }
                }
            }
            else {
                Write-Log "Phase 1 already completed. Moving to Phase 2..." -Level "INFO"
                $script:state.phase = 2
                $script:state.completed = $false
                Save-State
                if (Execute-Phase2) {
                    Write-Log "Phase 2 completed successfully. Moving to Phase 3." -Level "SUCCESS"
                    $script:state.phase = 3
                    $script:state.completed = $false
                    Save-State
                    if (Execute-Phase3) {
                        Write-Log "Phase 3 completed successfully." -Level "SUCCESS"
                        Write-Log "Initial navigation structure setup complete." -Level "SUCCESS"
                        Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                    }
                }
            }
        }
        2 {
            if (-not $script:state.completed) {
                Write-Log "Resuming Phase 2: Create TOC Files for Main Sections..." -Level "INFO"
                if (Execute-Phase2) {
                    Write-Log "Phase 2 completed successfully. Moving to Phase 3." -Level "SUCCESS"
                    $script:state.phase = 3
                    $script:state.completed = $false
                    Save-State
                    if (Execute-Phase3) {
                        Write-Log "Phase 3 completed successfully." -Level "SUCCESS"
                        Write-Log "Initial navigation structure setup complete." -Level "SUCCESS"
                        Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                    }
                }
            }
            else {
                Write-Log "Phase 2 already completed. Moving to Phase 3..." -Level "INFO"
                $script:state.phase = 3
                $script:state.completed = $false
                Save-State
                if (Execute-Phase3) {
                    Write-Log "Phase 3 completed successfully." -Level "SUCCESS"
                    Write-Log "Initial navigation structure setup complete." -Level "SUCCESS"
                    Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                }
            }
        }
        3 {
            if (-not $script:state.completed) {
                Write-Log "Resuming Phase 3: Create Index Files for Main Sections..." -Level "INFO"
                if (Execute-Phase3) {
                    Write-Log "Phase 3 completed successfully." -Level "SUCCESS"
                    Write-Log "Initial navigation structure setup complete." -Level "SUCCESS"
                    Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                }
            }
            else {
                Write-Log "Phase 3 already completed." -Level "INFO"
                Write-Log "Initial navigation structure setup complete." -Level "SUCCESS"
                Write-Log "To continue with the next phases, run this script again." -Level "INFO"
            }
        }
        default {
            Write-Log "Phases 1-3 already completed. Future phases will be implemented in subsequent scripts." -Level "INFO"
            Write-Log "Current phase: $($script:state.phase)" -Level "INFO"
        }
    }
}

# Start the migration
Start-Migration
