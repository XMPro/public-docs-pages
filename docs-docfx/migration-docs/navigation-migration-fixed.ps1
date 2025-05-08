# Navigation Migration Script
# This script implements the navigation migration plan to update the DocFX navigation structure
# to match the GitBook functionality.

# Base directories
$baseDir = "."
$docsDir = Join-Path $baseDir "."
$resourcesDir = Join-Path $docsDir "docs/resources"
$faqsDir = Join-Path $resourcesDir "faqs"
$externalContentDir = Join-Path $faqsDir "external-content"

# State tracking
$stateFile = Join-Path $baseDir "migration-docs/navigation-migration-state.json"
$logFile = Join-Path $baseDir "migration-docs/navigation-migration.log"

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

# Phase 4: Create Year-Specific TOC and Index Files
function Execute-Phase4 {
    Write-Log "Executing Phase 4: Create Year-Specific TOC and Index Files" -Level "INFO"
    
    # Create year-specific TOC and index files for blogs
    $blogYears = @("2024", "2023", "2022", "2021", "2020", "2019", "2018", "2017", "2016", "2015", "2014", "2013", "2012", "2011", "2010")
    foreach ($year in $blogYears) {
        # Create toc.yml for the year
        $yearToc = @"
- name: $year Blogs
  href: index.md
"@
        
        $yearTocPath = Join-Path $externalContentDir "blogs/$year/toc.yml"
        if (-not (Test-Path $yearTocPath)) {
            Write-Log "Creating TOC file: $yearTocPath"
            Set-Content -Path $yearTocPath -Value $yearToc
            $script:state.toc_files_created += $yearTocPath
        }
        
        # Create index.md for the year
        $yearIndex = @"
# $year Blogs

Articles from the XMPro blog published in $year.

## Articles

*Note: Content will be migrated from GitBook in a future phase.*
"@
        
        $yearIndexPath = Join-Path $externalContentDir "blogs/$year/index.md"
        if (-not (Test-Path $yearIndexPath)) {
            Write-Log "Creating index file: $yearIndexPath"
            Set-Content -Path $yearIndexPath -Value $yearIndex
            $script:state.index_files_created += $yearIndexPath
        }
        
        # Add year to completed years
        if (-not $script:state.years_completed.blogs.Contains($year)) {
            $script:state.years_completed.blogs += $year
        }
    }
    
    # Create year-specific TOC and index files for YouTube
    $youtubeYears = @("2024", "2023", "2022", "2021", "2020", "2019", "2016", "2013", "2012")
    foreach ($year in $youtubeYears) {
        # Create toc.yml for the year
        $yearToc = @"
- name: $year Videos
  href: index.md
"@
        
        $yearTocPath = Join-Path $externalContentDir "youtube/$year/toc.yml"
        if (-not (Test-Path $yearTocPath)) {
            Write-Log "Creating TOC file: $yearTocPath"
            Set-Content -Path $yearTocPath -Value $yearToc
            $script:state.toc_files_created += $yearTocPath
        }
        
        # Create index.md for the year
        $yearIndex = @"
# $year YouTube Videos

Video content from the XMPro YouTube channel published in $year.

## Videos

*Note: Content will be migrated from GitBook in a future phase.*
"@
        
        $yearIndexPath = Join-Path $externalContentDir "youtube/$year/index.md"
        if (-not (Test-Path $yearIndexPath)) {
            Write-Log "Creating index file: $yearIndexPath"
            Set-Content -Path $yearIndexPath -Value $yearIndex
            $script:state.index_files_created += $yearIndexPath
        }
        
        # Add year to completed years
        if (-not $script:state.years_completed.youtube.Contains($year)) {
            $script:state.years_completed.youtube += $year
        }
    }
    
    # Verify all year-specific TOC and index files have been created
    $allYearFilesExist = $true
    
    # Check blog years
    foreach ($year in $blogYears) {
        $yearTocPath = Join-Path $externalContentDir "blogs/$year/toc.yml"
        $yearIndexPath = Join-Path $externalContentDir "blogs/$year/index.md"
        
        if (-not (Test-Path $yearTocPath)) {
            Write-Log "TOC file not found: $yearTocPath" -Level "ERROR"
            $allYearFilesExist = $false
        }
        
        if (-not (Test-Path $yearIndexPath)) {
            Write-Log "Index file not found: $yearIndexPath" -Level "ERROR"
            $allYearFilesExist = $false
        }
    }
    
    # Check YouTube years
    foreach ($year in $youtubeYears) {
        $yearTocPath = Join-Path $externalContentDir "youtube/$year/toc.yml"
        $yearIndexPath = Join-Path $externalContentDir "youtube/$year/index.md"
        
        if (-not (Test-Path $yearTocPath)) {
            Write-Log "TOC file not found: $yearTocPath" -Level "ERROR"
            $allYearFilesExist = $false
        }
        
        if (-not (Test-Path $yearIndexPath)) {
            Write-Log "Index file not found: $yearIndexPath" -Level "ERROR"
            $allYearFilesExist = $false
        }
    }
    
    if ($allYearFilesExist) {
        Write-Log "All year-specific TOC and index files created successfully" -Level "SUCCESS"
        $script:state.phase = 4
        $script:state.completed = $true
        Save-State
        return $true
    }
    else {
        Write-Log "Some year-specific TOC and index files could not be created" -Level "ERROR"
        return $false
    }
}

# Phase 5: Migrate Blog Content
function Execute-Phase5 {
    Write-Log "Executing Phase 5: Migrate Blog Content" -Level "INFO"
    
    # Define the GitBook blogs directory
    $gitbookBlogsDir = Join-Path $baseDir "../docs-gitbook/docs/resources/faqs/external-content/blogs"
    
    # Check if the GitBook blogs directory exists
    if (-not (Test-Path $gitbookBlogsDir)) {
        Write-Log "GitBook blogs directory not found: $gitbookBlogsDir" -Level "ERROR"
        return $false
    }
    
    # Get all blog years
    $blogYears = @("2024", "2023", "2022", "2021", "2020", "2019", "2018", "2017", "2016", "2015", "2014", "2013", "2012", "2011", "2010")
    
    # Initialize a counter for migrated blogs
    $migratedBlogsCount = 0
    $totalBlogsCount = 0
    
    # Process each year
    foreach ($year in $blogYears) {
        Write-Log "Processing blog year: $year" -Level "INFO"
        
        # Define the GitBook year directory
        $gitbookYearDir = Join-Path $gitbookBlogsDir $year
        
        # Check if the GitBook year directory exists
        if (-not (Test-Path $gitbookYearDir)) {
            Write-Log "GitBook year directory not found: $gitbookYearDir" -Level "WARNING"
            continue
        }
        
        # Define the DocFX year directory
        $docfxYearDir = Join-Path $externalContentDir "blogs/$year"
        
        # Get all markdown files in the GitBook year directory
        $blogFiles = Get-ChildItem -Path $gitbookYearDir -Filter "*.md" -Recurse | Where-Object { $_.Name -ne "README.md" }
        
        # Update total blogs count
        $totalBlogsCount += $blogFiles.Count
        
        # Initialize or get the year's blog list in the state
        if (-not $script:state.blogs_migrated) {
            $script:state.blogs_migrated = @{}
        }
        
        if (-not $script:state.blogs_migrated.ContainsKey) {
            # Convert PSCustomObject to hashtable
            $newBlogsMigrated = @{}
            foreach ($prop in $script:state.blogs_migrated.PSObject.Properties) {
                $newBlogsMigrated[$prop.Name] = $prop.Value
            }
            $script:state.blogs_migrated = $newBlogsMigrated
        }
        
        if (-not $script:state.blogs_migrated.ContainsKey($year)) {
            $script:state.blogs_migrated[$year] = @()
        }
        
        # Initialize the TOC content for this year
        $yearTocContent = @"
- name: $year Blogs
  href: index.md
"@
        
        # Process each blog file
        foreach ($blogFile in $blogFiles) {
            # Skip if already migrated
            if ($script:state.blogs_migrated[$year] -contains $blogFile.Name) {
                Write-Log "Blog already migrated: $($blogFile.Name)" -Level "INFO"
                continue
            }
            
            Write-Log "Migrating blog: $($blogFile.Name)" -Level "INFO"
            
            # Read the blog content
            $blogContent = Get-Content -Path $blogFile.FullName -Raw
            
            # Extract the title from the first line (assuming it's a markdown heading)
            $titleMatch = [regex]::Match($blogContent, "^#\s+(.+)$", [System.Text.RegularExpressions.RegexOptions]::Multiline)
            $blogTitle = if ($titleMatch.Success) { $titleMatch.Groups[1].Value } else { [System.IO.Path]::GetFileNameWithoutExtension($blogFile.Name) }
            
            # Create a sanitized filename
            $sanitizedFileName = [System.IO.Path]::GetFileNameWithoutExtension($blogFile.Name) + ".md"
            
            # Define the DocFX blog file path
            $docfxBlogPath = Join-Path $docfxYearDir $sanitizedFileName
            
            # Write the blog content to the DocFX file
            Set-Content -Path $docfxBlogPath -Value $blogContent
            
            # Add to the TOC content
            $yearTocContent += @"

- name: $blogTitle
  href: $sanitizedFileName
"@
            
            # Add to the migrated blogs list
            $script:state.blogs_migrated[$year] += $blogFile.Name
            $migratedBlogsCount++
            
            # Save state after each blog to ensure progress is not lost
            Save-State
        }
        
        # Update the year's TOC file
        $yearTocPath = Join-Path $docfxYearDir "toc.yml"
        Set-Content -Path $yearTocPath -Value $yearTocContent
        
        # Update the year's index file to include links to the blogs
        $yearIndexPath = Join-Path $docfxYearDir "index.md"
        $yearIndexContent = @"
# $year Blogs

Articles from the XMPro blog published in $year.

## Articles

"@
        
        # Add links to each blog
        foreach ($blogFile in $blogFiles) {
            $sanitizedFileName = [System.IO.Path]::GetFileNameWithoutExtension($blogFile.Name) + ".md"
            $blogContent = Get-Content -Path $blogFile.FullName -Raw
            $titleMatch = [regex]::Match($blogContent, "^#\s+(.+)$", [System.Text.RegularExpressions.RegexOptions]::Multiline)
            $blogTitle = if ($titleMatch.Success) { $titleMatch.Groups[1].Value } else { [System.IO.Path]::GetFileNameWithoutExtension($blogFile.Name) }
            
            $yearIndexContent += @"

- [$blogTitle]($sanitizedFileName)
"@
        }
        
        # Write the updated index file
        Set-Content -Path $yearIndexPath -Value $yearIndexContent
    }
    
    # Log the migration results
    Write-Log "Blog migration completed: $migratedBlogsCount of $totalBlogsCount blogs migrated" -Level "SUCCESS"
    
    # Check if all blogs were migrated
    $allBlogsMigrated = $migratedBlogsCount -eq $totalBlogsCount
    
    if ($allBlogsMigrated) {
        Write-Log "All blogs migrated successfully" -Level "SUCCESS"
        $script:state.phase = 5
        $script:state.completed = $true
        Save-State
        return $true
    }
    else {
        Write-Log "Some blogs could not be migrated" -Level "WARNING"
        return $false
    }
}

# Phase 6: Migrate Use Cases Content
function Execute-Phase6 {
    Write-Log "Executing Phase 6: Migrate Use Cases Content" -Level "INFO"
    
    # Define the GitBook use cases directory
    $gitbookUseCasesDir = Join-Path $baseDir "../docs-gitbook/docs/resources/faqs/external-content/use-cases"
    
    # Check if the GitBook use cases directory exists
    if (-not (Test-Path $gitbookUseCasesDir)) {
        Write-Log "GitBook use cases directory not found: $gitbookUseCasesDir" -Level "ERROR"
        return $false
    }
    
    # Define the DocFX use cases directory
    $docfxUseCasesDir = Join-Path $externalContentDir "use-cases"
    
    # Get all markdown files in the GitBook use cases directory
    $useCaseFiles = Get-ChildItem -Path $gitbookUseCasesDir -Filter "*.md" -Recurse | Where-Object { $_.Name -ne "README.md" }
    
    # Initialize a counter for migrated use cases
    $migratedUseCasesCount = 0
    $totalUseCasesCount = $useCaseFiles.Count
    
    # Initialize the TOC content for use cases
    $useCasesTocContent = @"
- name: Use Cases
  href: index.md
"@
    
    # Process each use case file
    foreach ($useCaseFile in $useCaseFiles) {
        # Skip if already migrated
        if ($script:state.use_cases_migrated -contains $useCaseFile.Name) {
            Write-Log "Use case already migrated: $($useCaseFile.Name)" -Level "INFO"
            continue
        }
        
        Write-Log "Migrating
# Phase 6: Migrate Use Cases Content
function Execute-Phase6 {
    Write-Log "Executing Phase 6: Migrate Use Cases Content" -Level "INFO"
    
    # Define the GitBook use cases directory
    $gitbookUseCasesDir = Join-Path $baseDir "../docs-gitbook/docs/resources/faqs/external-content/use-cases"
    
    # Check if the GitBook use cases directory exists
    if (-not (Test-Path $gitbookUseCasesDir)) {
        Write-Log "GitBook use cases directory not found: $gitbookUseCasesDir" -Level "ERROR"
        return $false
    }
    
    # Define the DocFX use cases directory
    $docfxUseCasesDir = Join-Path $externalContentDir "use-cases"
    
    # Get all markdown files in the GitBook use cases directory
    $useCaseFiles = Get-ChildItem -Path $gitbookUseCasesDir -Filter "*.md" -Recurse | Where-Object { $_.Name -ne "README.md" }
    
    # Initialize a counter for migrated use cases
    $migratedUseCasesCount = 0
    $totalUseCasesCount = $useCaseFiles.Count
    
    # Initialize the TOC content for use cases
    $useCasesTocContent = @"
- name: Use Cases
  href: index.md
"@
    
    # Process each use case file
    foreach ($useCaseFile in $useCaseFiles) {
        # Skip if already migrated
        if ($script:state.use_cases_migrated -contains $useCaseFile.Name) {
            Write-Log "Use case already migrated: $($useCaseFile.Name)" -Level "INFO"
            continue
        }
        
        Write-Log "Migrating use case: $($useCaseFile.Name)" -Level "INFO"
        
        # Read the use case content
        $useCaseContent = Get-Content -Path $useCaseFile.FullName -Raw
        
        # Extract the title from the first line (assuming it's a markdown heading)
        $titleMatch = [regex]::Match($useCaseContent, "^#\s+(.+)$", [System.Text.RegularExpressions.RegexOptions]::Multiline)
        $useCaseTitle = if ($titleMatch.Success) { $titleMatch.Groups[1].Value } else { [System.IO.Path]::GetFileNameWithoutExtension($useCaseFile.Name) }
        
        # Create a sanitized filename
        $sanitizedFileName = [System.IO.Path]::GetFileNameWithoutExtension($useCaseFile.Name) + ".md"
        
        # Define the DocFX use case file path
        $docfxUseCasePath = Join-Path $docfxUseCasesDir $sanitizedFileName
        
        # Write the use case content to the DocFX file
        Set-Content -Path $docfxUseCasePath -Value $useCaseContent
        
        # Add to the TOC content
        $useCasesTocContent += @"

- name: $useCaseTitle
  href: $sanitizedFileName
"@
        
        # Add to the migrated use cases list
        $script:state.use_cases_migrated += $useCaseFile.Name
        $migratedUseCasesCount++
        
        # Save state after each use case to ensure progress is not lost
        Save-State
    }
    
    # Update the use cases TOC file
    $useCasesTocPath = Join-Path $docfxUseCasesDir "toc.yml"
    Set-Content -Path $useCasesTocPath -Value $useCasesTocContent
    
    # Update the use cases index file to include links to the use cases
    $useCasesIndexPath = Join-Path $docfxUseCasesDir "index.md"
    $useCasesIndexContent = @"
# Use Cases

Real-world use cases demonstrating how XMPro is used in various industries.

## Use Cases

"@
    
    # Add links to each use case
    foreach ($useCaseFile in $useCaseFiles) {
        $sanitizedFileName = [System.IO.Path]::GetFileNameWithoutExtension($useCaseFile.Name) + ".md"
        $useCaseContent = Get-Content -Path $useCaseFile.FullName -Raw
        $titleMatch = [regex]::Match($useCaseContent, "^#\s+(.+)$", [System.Text.RegularExpressions.RegexOptions]::Multiline)
        $useCaseTitle = if ($titleMatch.Success) { $titleMatch.Groups[1].Value } else { [System.IO.Path]::GetFileNameWithoutExtension($useCaseFile.Name) }
        
        $useCasesIndexContent += @"

- [$useCaseTitle]($sanitizedFileName)
"@
    }
    
    # Write the updated index file
    Set-Content -Path $useCasesIndexPath -Value $useCasesIndexContent
    
    # Log the migration results
    Write-Log "Use cases migration completed: $migratedUseCasesCount of $totalUseCasesCount use cases migrated" -Level "SUCCESS"
    
    # Check if all use cases were migrated
    $allUseCasesMigrated = $migratedUseCasesCount -eq $totalUseCasesCount
    
    if ($allUseCasesMigrated) {
        Write-Log "All use cases migrated successfully" -Level "SUCCESS"
        $script:state.phase = 6
        $script:state.completed = $true
        Save-State
        return $true
    }
    else {
        Write-Log "Some use cases could not be migrated" -Level "WARNING"
        return $false
    }
}

# Update the main execution function to include Phase 6
function Update-MainExecution {
    # Add Phase 6 to the switch statement
    switch ($script:state.phase) {
        5 {
            if (-not $script:state.completed) {
                Write-Log "Resuming Phase 5: Migrate Blog Content..." -Level "INFO"
                if (Execute-Phase5) {
                    Write-Log "Phase 5 completed successfully. Moving to Phase 6." -Level "SUCCESS"
                    $script:state.phase = 6
                    $script:state.completed = $false
                    Save-State
                    if (Execute-Phase6) {
                        Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                        Write-Log "Use cases content migration complete." -Level "SUCCESS"
                        Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                    }
                }
            }
            else {
                Write-Log "Phase 5 already completed. Moving to Phase 6..." -Level "INFO"
                $script:state.phase = 6
                $script:state.completed = $false
                Save-State
                if (Execute-Phase6) {
                    Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                    Write-Log "Use cases content migration complete." -Level "SUCCESS"
                    Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                }
            }
        }
        6 {
            if (-not $script:state.completed) {
                Write-Log "Resuming Phase 6: Migrate Use Cases Content..." -Level "INFO"
                if (Execute-Phase6) {
                    Write-Log "Phase 6 completed successfully." -Level "SUCCESS"
                    Write-Log "Use cases content migration complete." -Level "SUCCESS"
                    Write-Log "To continue with the next phases, run this script again." -Level "INFO"
                }
            }
            else {
                Write-Log "Phase 6 already completed." -Level "INFO"
                Write-Log "Use cases content migration complete." -Level "SUCCESS"
                Write-Log "To continue with the next phases, run this script again." -Level "INFO"
            }
        }
        default {
            Write-Log "Phases 1-6 already completed. Future phases will be implemented in subsequent scripts." -Level "INFO"
            Write-Log "Current phase: $($script:state.phase)" -Level "INFO"
        }
    }
}

> function Execute-Phase6 {
      Write-Log "Executing Phase 6: Migrate Use Cases Content" -Level "INFO"
      
      # Define the GitBook use cases directory
      $gitbookUseCasesDir = Join-Path $baseDir "../docs-gitbook/docs/resources/faqs/external-content/use-cases"
      
      # Check if the GitBook use cases directory exists
      if (-not (Test-Path $gitbookUseCasesDir)) {
          Write-Log "GitBook use cases directory not found: $gitbookUseCasesDir" -Level "ERROR"
          return $false
      }
      
      # Define the DocFX use cases directory
      $docfxUseCasesDir = Join-Path $externalContentDir "use-cases"
      
      # Get all markdown files in the GitBook use cases directory
      $useCaseFiles = Get-ChildItem -Path $gitbookUseCasesDir -Filter "*.md" -Recurse | Where-Object { $_.Name -ne "README.md" }
      
      # Initialize a counter for migrated use cases
      $migratedUseCasesCount = 0
      $totalUseCasesCount = $useCaseFiles.Count
      
      # Initialize the TOC content for use cases
      $useCasesTocContent = @"
  - name: Use Cases
    href: index.md
  "@
      
      # Process each use case file
      foreach ($useCaseFile in $useCaseFiles) {
          # Skip if already migrated
          if ($script:state.use_cases_migrated -contains $useCaseFile.Name) {
              Write-Log "Use case already migrated: $($useCaseFile.Name)" -Level "INFO"
              continue
          }
          
          Write-Log "Migrating use case: $($useCaseFile.Name)" -Level "INFO"
          
          # Read the use case content
          $useCaseContent = Get-Content -Path $useCaseFile.FullName -Raw
          
          # Extract the title from the first line (assuming it's a markdown heading)
          $titleMatch = [regex]::Match($useCaseContent, "^#\s+(.+)$", [System.Text.RegularExpressions.RegexOptions]::Multiline)
          $useCaseTitle = if ($titleMatch.Success) { $titleMatch.Groups[1].Value } else { [System.IO.Path]::GetFileNameWithoutExtension($useCaseFile.Name) }
          
          # Create a sanitized filename
          $sanitizedFileName = [System.IO.Path]::GetFileNameWithoutExtension($useCaseFile.Name) + ".md"
          
          # Define the DocFX use case file path
          $docfxUseCasePath = Join-Path $docfxUseCasesDir $sanitizedFileName
          

