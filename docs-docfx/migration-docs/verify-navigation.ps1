# Script to verify navigation functionality in the DocFX documentation

Write-Host "Starting navigation verification for DocFX documentation..." -ForegroundColor Green

# Define the base URL for the local DocFX server
$baseUrl = "http://localhost:9000"

# Function to check if a URL is valid
function Test-Url {
    param (
        [string]$Url
    )
    
    try {
        $request = [System.Net.WebRequest]::Create($Url)
        $request.Method = "HEAD"
        $request.Timeout = 5000
        $response = $request.GetResponse()
        $statusCode = [int]$response.StatusCode
        $response.Close()
        
        return $statusCode -eq 200
    }
    catch {
        return $false
    }
}

# Function to extract navigation links from HTML content
function Get-NavigationLinks {
    param (
        [string]$HtmlContent,
        [string]$BaseUrl
    )
    
    $navLinks = @()
    
    # Extract the navigation menu
    $navMatch = [regex]::Match($HtmlContent, '<nav[^>]*class="[^"]*toc-filter[^"]*"[^>]*>(.*?)</nav>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    
    if ($navMatch.Success) {
        $navContent = $navMatch.Groups[1].Value
        
        # Extract links from the navigation menu
        $linkMatches = [regex]::Matches($navContent, '<a[^>]*href="([^"]+)"[^>]*>(.*?)</a>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
        
        foreach ($match in $linkMatches) {
            $href = $match.Groups[1].Value
            $text = [regex]::Replace($match.Groups[2].Value, '<[^>]+>', '').Trim()
            
            # Skip external links, anchors, and javascript links
            if ($href.StartsWith("http") -or $href.StartsWith("#") -or $href.StartsWith("javascript:") -or $href.StartsWith("mailto:")) {
                continue
            }
            
            # Normalize the path
            if (-not $href.StartsWith("/")) {
                $href = "/$href"
            }
            $href = $href -replace "//", "/"
            
            # Add to the list of navigation links
            $navLinks += [PSCustomObject]@{
                Url = "$BaseUrl$href"
                Text = $text
            }
        }
    }
    
    return $navLinks
}

# Function to extract breadcrumb links from HTML content
function Get-BreadcrumbLinks {
    param (
        [string]$HtmlContent,
        [string]$BaseUrl
    )
    
    $breadcrumbLinks = @()
    
    # Extract the breadcrumb navigation
    $breadcrumbMatch = [regex]::Match($HtmlContent, '<ul[^>]*class="[^"]*breadcrumb[^"]*"[^>]*>(.*?)</ul>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    
    if ($breadcrumbMatch.Success) {
        $breadcrumbContent = $breadcrumbMatch.Groups[1].Value
        
        # Extract links from the breadcrumb navigation
        $linkMatches = [regex]::Matches($breadcrumbContent, '<a[^>]*href="([^"]+)"[^>]*>(.*?)</a>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
        
        foreach ($match in $linkMatches) {
            $href = $match.Groups[1].Value
            $text = [regex]::Replace($match.Groups[2].Value, '<[^>]+>', '').Trim()
            
            # Skip external links, anchors, and javascript links
            if ($href.StartsWith("http") -or $href.StartsWith("#") -or $href.StartsWith("javascript:") -or $href.StartsWith("mailto:")) {
                continue
            }
            
            # Normalize the path
            if (-not $href.StartsWith("/")) {
                $href = "/$href"
            }
            $href = $href -replace "//", "/"
            
            # Add to the list of breadcrumb links
            $breadcrumbLinks += [PSCustomObject]@{
                Url = "$BaseUrl$href"
                Text = $text
            }
        }
    }
    
    return $breadcrumbLinks
}

# Function to extract TOC links from HTML content
function Get-TocLinks {
    param (
        [string]$HtmlContent,
        [string]$BaseUrl,
        [string]$CurrentPath
    )
    
    $tocLinks = @()
    
    # Extract the TOC
    $tocMatch = [regex]::Match($HtmlContent, '<div[^>]*class="[^"]*sidetoc[^"]*"[^>]*>(.*?)</div>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    
    if ($tocMatch.Success) {
        $tocContent = $tocMatch.Groups[1].Value
        
        # Extract links from the TOC
        $linkMatches = [regex]::Matches($tocContent, '<a[^>]*href="([^"]+)"[^>]*>(.*?)</a>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
        
        foreach ($match in $linkMatches) {
            $href = $match.Groups[1].Value
            $text = [regex]::Replace($match.Groups[2].Value, '<[^>]+>', '').Trim()
            
            # Skip external links, anchors, and javascript links
            if ($href.StartsWith("http") -or $href.StartsWith("#") -or $href.StartsWith("javascript:") -or $href.StartsWith("mailto:")) {
                continue
            }
            
            # Resolve relative paths
            if ($href.StartsWith("../")) {
                $parentPath = $CurrentPath -replace "/[^/]+$", ""
                $href = $href -replace "^\.\.", $parentPath
            }
            elseif ($href.StartsWith("./")) {
                $href = $href -replace "^\.", $CurrentPath
            }
            elseif (-not $href.StartsWith("/")) {
                $href = "$CurrentPath/$href"
            }
            
            # Normalize the path
            $href = $href -replace "//", "/"
            
            # Add to the list of TOC links
            $tocLinks += [PSCustomObject]@{
                Url = "$BaseUrl$href"
                Text = $text
            }
        }
    }
    
    return $tocLinks
}

# Function to crawl the site and check navigation
function Crawl-Site-For-Navigation {
    param (
        [string]$StartUrl,
        [string]$BaseUrl
    )
    
    $visitedUrls = @{}
    $urlsToVisit = @($StartUrl)
    $navigationStructure = @{}
    $brokenNavLinks = @()
    
    $totalChecked = 0
    $totalBroken = 0
    
    while ($urlsToVisit.Count -gt 0) {
        $currentUrl = $urlsToVisit[0]
        $urlsToVisit = $urlsToVisit[1..($urlsToVisit.Count - 1)]
        
        # Skip if already visited
        if ($visitedUrls.ContainsKey($currentUrl)) {
            continue
        }
        
        # Mark as visited
        $visitedUrls[$currentUrl] = $true
        
        # If it's an HTML page, extract navigation
        if ($currentUrl -match "\.(html|htm)$" -or $currentUrl -eq $StartUrl -or $currentUrl -match "/$") {
            try {
                $response = Invoke-WebRequest -Uri $currentUrl -UseBasicParsing
                $htmlContent = $response.Content
                
                # Get the current path
                $currentPath = $currentUrl.Replace($BaseUrl, "")
                $currentPath = $currentPath -replace "/[^/]+$", ""
                
                # Extract navigation links
                $navLinks = Get-NavigationLinks -HtmlContent $htmlContent -BaseUrl $BaseUrl
                
                # Extract breadcrumb links
                $breadcrumbLinks = Get-BreadcrumbLinks -HtmlContent $htmlContent -BaseUrl $BaseUrl
                
                # Extract TOC links
                $tocLinks = Get-TocLinks -HtmlContent $htmlContent -BaseUrl $BaseUrl -CurrentPath $currentPath
                
                # Combine all navigation links
                $allNavLinks = $navLinks + $breadcrumbLinks + $tocLinks | Select-Object -Unique Url, Text
                
                # Store navigation structure
                $navigationStructure[$currentUrl] = @{
                    NavLinks = $navLinks
                    BreadcrumbLinks = $breadcrumbLinks
                    TocLinks = $tocLinks
                    Title = [regex]::Match($htmlContent, '<title>(.*?)</title>').Groups[1].Value.Trim()
                }
                
                # Check each navigation link
                foreach ($link in $allNavLinks) {
                    $isValid = Test-Url -Url $link.Url
                    if (-not $isValid) {
                        $totalBroken++
                        $brokenNavLinks += [PSCustomObject]@{
                            PageUrl = $currentUrl
                            LinkUrl = $link.Url
                            LinkText = $link.Text
                        }
                        Write-Host "Broken navigation link: $($link.Url) ($($link.Text)) on page $currentUrl" -ForegroundColor Red
                    }
                    else {
                        # Add to the list of URLs to visit if not already visited
                        if (-not $visitedUrls.ContainsKey($link.Url) -and -not $urlsToVisit.Contains($link.Url)) {
                            $urlsToVisit += $link.Url
                        }
                    }
                }
                
                Write-Host "Checked navigation on page: $currentUrl - OK" -ForegroundColor Green
                $totalChecked++
            }
            catch {
                Write-Host "Error processing $currentUrl : $_" -ForegroundColor Yellow
            }
        }
        
        # Show progress
        if ($totalChecked % 10 -eq 0) {
            Write-Host "Progress: Checked navigation on $totalChecked pages, Found $totalBroken broken links, Queue size: $($urlsToVisit.Count)" -ForegroundColor Cyan
        }
    }
    
    return @{
        NavigationStructure = $navigationStructure
        BrokenNavLinks = $brokenNavLinks
    }
}

# Function to analyze navigation structure for consistency
function Analyze-NavigationStructure {
    param (
        [hashtable]$NavigationStructure
    )
    
    $inconsistencies = @()
    $sections = @{}
    
    # Group pages by section (first level of navigation)
    foreach ($page in $NavigationStructure.Keys) {
        $navLinks = $NavigationStructure[$page].NavLinks
        
        if ($navLinks.Count -gt 0) {
            $firstNavLink = $navLinks[0]
            $section = $firstNavLink.Text
            
            if (-not $sections.ContainsKey($section)) {
                $sections[$section] = @()
            }
            
            $sections[$section] += $page
        }
    }
    
    # Check for navigation consistency within each section
    foreach ($section in $sections.Keys) {
        $sectionPages = $sections[$section]
        
        if ($sectionPages.Count -gt 1) {
            $referenceNavLinks = $NavigationStructure[$sectionPages[0]].NavLinks
            
            for ($i = 1; $i -lt $sectionPages.Count; $i++) {
                $currentNavLinks = $NavigationStructure[$sectionPages[$i]].NavLinks
                
                # Compare navigation links
                if ($referenceNavLinks.Count -ne $currentNavLinks.Count) {
                    $inconsistencies += [PSCustomObject]@{
                        Section = $section
                        ReferencePage = $sectionPages[0]
                        CurrentPage = $sectionPages[$i]
                        Issue = "Different number of navigation links"
                    }
                }
                else {
                    for ($j = 0; $j -lt $referenceNavLinks.Count; $j++) {
                        if ($referenceNavLinks[$j].Text -ne $currentNavLinks[$j].Text) {
                            $inconsistencies += [PSCustomObject]@{
                                Section = $section
                                ReferencePage = $sectionPages[0]
                                CurrentPage = $sectionPages[$i]
                                Issue = "Different navigation link text: '$($referenceNavLinks[$j].Text)' vs '$($currentNavLinks[$j].Text)'"
                            }
                        }
                    }
                }
            }
        }
    }
    
    return @{
        Sections = $sections
        Inconsistencies = $inconsistencies
    }
}

# Start the crawl
Write-Host "Starting site crawl from $baseUrl..." -ForegroundColor Cyan
$results = Crawl-Site-For-Navigation -StartUrl $baseUrl -BaseUrl $baseUrl

# Analyze navigation structure
Write-Host "`nAnalyzing navigation structure..." -ForegroundColor Cyan
$analysis = Analyze-NavigationStructure -NavigationStructure $results.NavigationStructure

# Output summary
Write-Host "`nNavigation verification complete!" -ForegroundColor Green
Write-Host "Total pages checked: $($results.NavigationStructure.Count)" -ForegroundColor Cyan
Write-Host "Total sections found: $($analysis.Sections.Count)" -ForegroundColor Cyan
Write-Host "Total broken navigation links: $($results.BrokenNavLinks.Count)" -ForegroundColor $(if ($results.BrokenNavLinks.Count -eq 0) { "Green" } else { "Red" })
Write-Host "Total navigation inconsistencies: $($analysis.Inconsistencies.Count)" -ForegroundColor $(if ($analysis.Inconsistencies.Count -eq 0) { "Green" } else { "Yellow" })

if ($results.BrokenNavLinks.Count -gt 0) {
    Write-Host "`nList of broken navigation links:" -ForegroundColor Red
    $results.BrokenNavLinks | Format-Table -Property PageUrl, LinkUrl, LinkText -AutoSize
    
    # Export broken navigation links to a file
    $results.BrokenNavLinks | Export-Csv -Path "broken-nav-links.csv" -NoTypeInformation
    Write-Host "`nBroken navigation links have been exported to 'broken-nav-links.csv'" -ForegroundColor Yellow
}

if ($analysis.Inconsistencies.Count -gt 0) {
    Write-Host "`nList of navigation inconsistencies:" -ForegroundColor Yellow
    $analysis.Inconsistencies | Format-Table -Property Section, ReferencePage, CurrentPage, Issue -AutoSize
    
    # Export navigation inconsistencies to a file
    $analysis.Inconsistencies | Export-Csv -Path "nav-inconsistencies.csv" -NoTypeInformation
    Write-Host "`nNavigation inconsistencies have been exported to 'nav-inconsistencies.csv'" -ForegroundColor Yellow
}

# Generate a report of the navigation structure
$navigationReport = @()
foreach ($section in $analysis.Sections.Keys) {
    $sectionPages = $analysis.Sections[$section]
    
    foreach ($page in $sectionPages) {
        $pageInfo = $results.NavigationStructure[$page]
        
        $navigationReport += [PSCustomObject]@{
            Section = $section
            Page = $page
            Title = $pageInfo.Title
            NavLinksCount = $pageInfo.NavLinks.Count
            BreadcrumbLinksCount = $pageInfo.BreadcrumbLinks.Count
            TocLinksCount = $pageInfo.TocLinks.Count
        }
    }
}

$navigationReport | Export-Csv -Path "navigation-structure.csv" -NoTypeInformation
Write-Host "`nNavigation structure has been exported to 'navigation-structure.csv'" -ForegroundColor Green
