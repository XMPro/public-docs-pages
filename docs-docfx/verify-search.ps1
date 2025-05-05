# Script to verify search functionality in the DocFX documentation

Write-Host "Starting search functionality verification for DocFX documentation..." -ForegroundColor Green

# Define the base URL for the local DocFX server
$baseUrl = "http://localhost:9000"

# Function to extract search terms from content
function Get-SearchTerms {
    param (
        [string]$HtmlContent
    )
    
    $searchTerms = @()
    
    # Extract text content
    $textContent = [regex]::Replace($HtmlContent, '<[^>]+>', ' ')
    $textContent = [regex]::Replace($textContent, '\s+', ' ').Trim()
    
    # Extract words (excluding common stop words)
    $stopWords = @('a', 'an', 'the', 'and', 'or', 'but', 'is', 'are', 'was', 'were', 'be', 'been', 'being', 
                  'have', 'has', 'had', 'do', 'does', 'did', 'to', 'at', 'in', 'on', 'by', 'for', 'with', 
                  'about', 'against', 'between', 'into', 'through', 'during', 'before', 'after', 'above', 
                  'below', 'from', 'up', 'down', 'of', 'off', 'over', 'under', 'again', 'further', 'then', 
                  'once', 'here', 'there', 'when', 'where', 'why', 'how', 'all', 'any', 'both', 'each', 
                  'few', 'more', 'most', 'other', 'some', 'such', 'no', 'nor', 'not', 'only', 'own', 'same', 
                  'so', 'than', 'too', 'very', 'can', 'will', 'just', 'should', 'now')
    
    $words = $textContent -split '\W+' | Where-Object { $_ -and $_.Length -gt 3 -and $stopWords -notcontains $_.ToLower() }
    
    # Get unique words
    $uniqueWords = $words | Select-Object -Unique
    
    # Get the most frequent words
    $wordCounts = @{}
    foreach ($word in $words) {
        if (-not $wordCounts.ContainsKey($word)) {
            $wordCounts[$word] = 0
        }
        $wordCounts[$word]++
    }
    
    # Sort by frequency and take the top 10
    $topWords = $wordCounts.GetEnumerator() | Sort-Object -Property Value -Descending | Select-Object -First 10 -ExpandProperty Key
    
    # Add the top words to the search terms
    $searchTerms += $topWords
    
    # Extract headings
    $headingMatches = [regex]::Matches($HtmlContent, '<h[1-6][^>]*>(.*?)</h[1-6]>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    foreach ($match in $headingMatches) {
        $heading = [regex]::Replace($match.Groups[1].Value, '<[^>]+>', '').Trim()
        $searchTerms += $heading
    }
    
    # Extract title
    $titleMatch = [regex]::Match($HtmlContent, '<title>(.*?)</title>')
    if ($titleMatch.Success) {
        $title = $titleMatch.Groups[1].Value.Trim()
        $searchTerms += $title
    }
    
    # Return unique search terms
    return $searchTerms | Select-Object -Unique
}

# Function to perform a search
function Perform-Search {
    param (
        [string]$BaseUrl,
        [string]$SearchTerm
    )
    
    try {
        $searchUrl = "$BaseUrl/search/index.html?q=$([System.Web.HttpUtility]::UrlEncode($SearchTerm))"
        $response = Invoke-WebRequest -Uri $searchUrl -UseBasicParsing
        
        # Check if search results are present
        $hasResults = $response.Content -match '<div[^>]*class="[^"]*sr-items[^"]*"[^>]*>'
        
        # Extract search results
        $results = @()
        if ($hasResults) {
            $resultsMatch = [regex]::Match($response.Content, '<div[^>]*class="[^"]*sr-items[^"]*"[^>]*>(.*?)</div>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
            if ($resultsMatch.Success) {
                $resultsContent = $resultsMatch.Groups[1].Value
                
                # Extract individual search results
                $resultMatches = [regex]::Matches($resultsContent, '<div[^>]*class="[^"]*sr-item[^"]*"[^>]*>(.*?)</div>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
                foreach ($match in $resultMatches) {
                    $resultContent = $match.Groups[1].Value
                    
                    # Extract title
                    $titleMatch = [regex]::Match($resultContent, '<a[^>]*href="([^"]+)"[^>]*>(.*?)</a>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
                    if ($titleMatch.Success) {
                        $url = $titleMatch.Groups[1].Value
                        $title = [regex]::Replace($titleMatch.Groups[2].Value, '<[^>]+>', '').Trim()
                        
                        # Extract snippet
                        $snippetMatch = [regex]::Match($resultContent, '<p[^>]*class="[^"]*sr-snippet[^"]*"[^>]*>(.*?)</p>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
                        $snippet = if ($snippetMatch.Success) { [regex]::Replace($snippetMatch.Groups[1].Value, '<[^>]+>', '').Trim() } else { "" }
                        
                        # Add to results
                        $results += [PSCustomObject]@{
                            Title = $title
                            Url = $url
                            Snippet = $snippet
                        }
                    }
                }
            }
        }
        
        return @{
            Success = $true
            HasResults = $hasResults
            ResultsCount = $results.Count
            Results = $results
        }
    }
    catch {
        return @{
            Success = $false
            Error = $_.Exception.Message
        }
    }
}

# Function to crawl the site and test search functionality
function Test-Search-Functionality {
    param (
        [string]$StartUrl,
        [string]$BaseUrl
    )
    
    $visitedUrls = @{}
    $urlsToVisit = @($StartUrl)
    $searchTests = @()
    $searchFailures = @()
    
    $totalChecked = 0
    $totalSearched = 0
    $totalFailed = 0
    
    while ($urlsToVisit.Count -gt 0) {
        $currentUrl = $urlsToVisit[0]
        $urlsToVisit = $urlsToVisit[1..($urlsToVisit.Count - 1)]
        
        # Skip if already visited
        if ($visitedUrls.ContainsKey($currentUrl)) {
            continue
        }
        
        # Mark as visited
        $visitedUrls[$currentUrl] = $true
        
        # If it's an HTML page, extract content and test search
        if ($currentUrl -match "\.(html|htm)$" -or $currentUrl -eq $StartUrl -or $currentUrl -match "/$") {
            try {
                $response = Invoke-WebRequest -Uri $currentUrl -UseBasicParsing
                $htmlContent = $response.Content
                
                # Get the current path
                $currentPath = $currentUrl.Replace($BaseUrl, "")
                $currentPath = $currentPath -replace "/[^/]+$", ""
                
                # Extract links to continue crawling
                $hrefMatches = [regex]::Matches($htmlContent, 'href="([^"]+)"')
                foreach ($match in $hrefMatches) {
                    $href = $match.Groups[1].Value
                    
                    # Skip external links, anchors, and javascript links
                    if ($href.StartsWith("http") -or $href.StartsWith("#") -or $href.StartsWith("javascript:") -or $href.StartsWith("mailto:")) {
                        continue
                    }
                    
                    # Resolve relative paths
                    if ($href.StartsWith("../")) {
                        $parentPath = $currentPath -replace "/[^/]+$", ""
                        $href = $href -replace "^\.\.", $parentPath
                    }
                    elseif ($href.StartsWith("./")) {
                        $href = $href -replace "^\.", $currentPath
                    }
                    elseif (-not $href.StartsWith("/")) {
                        $href = "$currentPath/$href"
                    }
                    
                    # Normalize the path
                    $href = $href -replace "//", "/"
                    
                    # Add to the list of URLs to visit
                    $fullUrl = "$BaseUrl$href"
                    if (-not $visitedUrls.ContainsKey($fullUrl) -and -not $urlsToVisit.Contains($fullUrl)) {
                        $urlsToVisit += $fullUrl
                    }
                }
                
                # Extract search terms
                $searchTerms = Get-SearchTerms -HtmlContent $htmlContent
                
                # Test search functionality with a sample of search terms
                $sampleTerms = $searchTerms | Get-Random -Count ([Math]::Min(3, $searchTerms.Count))
                
                foreach ($term in $sampleTerms) {
                    $totalSearched++
                    
                    # Perform search
                    $searchResult = Perform-Search -BaseUrl $BaseUrl -SearchTerm $term
                    
                    # Record search test
                    $searchTest = [PSCustomObject]@{
                        PageUrl = $currentUrl
                        SearchTerm = $term
                        Success = $searchResult.Success
                        HasResults = if ($searchResult.Success) { $searchResult.HasResults } else { $false }
                        ResultsCount = if ($searchResult.Success) { $searchResult.ResultsCount } else { 0 }
                    }
                    
                    $searchTests += $searchTest
                    
                    # Check if search failed or returned no results
                    if (-not $searchResult.Success -or -not $searchResult.HasResults) {
                        $totalFailed++
                        $searchFailures += $searchTest
                        
                        $failureReason = if (-not $searchResult.Success) { "Search failed: $($searchResult.Error)" } else { "No results found" }
                        Write-Host "Search failure: Term '$term' on page $currentUrl - $failureReason" -ForegroundColor Red
                    }
                    else {
                        Write-Host "Search success: Term '$term' on page $currentUrl - $($searchResult.ResultsCount) results" -ForegroundColor Green
                    }
                }
                
                Write-Host "Checked page: $currentUrl - OK" -ForegroundColor Green
                $totalChecked++
            }
            catch {
                Write-Host "Error processing $currentUrl : $_" -ForegroundColor Yellow
            }
        }
        
        # Show progress
        if ($totalChecked % 10 -eq 0) {
            Write-Host "Progress: Checked $totalChecked pages, Performed $totalSearched searches, Found $totalFailed failures, Queue size: $($urlsToVisit.Count)" -ForegroundColor Cyan
        }
    }
    
    return @{
        SearchTests = $searchTests
        SearchFailures = $searchFailures
    }
}

# Start the search functionality test
Write-Host "Starting search functionality test from $baseUrl..." -ForegroundColor Cyan
$results = Test-Search-Functionality -StartUrl $baseUrl -BaseUrl $baseUrl

# Output summary
Write-Host "`nSearch functionality verification complete!" -ForegroundColor Green
Write-Host "Total searches performed: $($results.SearchTests.Count)" -ForegroundColor Cyan
Write-Host "Total search failures: $($results.SearchFailures.Count)" -ForegroundColor $(if ($results.SearchFailures.Count -eq 0) { "Green" } else { "Red" })

if ($results.SearchFailures.Count -gt 0) {
    Write-Host "`nList of search failures:" -ForegroundColor Red
    $results.SearchFailures | Format-Table -Property PageUrl, SearchTerm, Success, HasResults, ResultsCount -AutoSize
    
    # Export search failures to a file
    $results.SearchFailures | Export-Csv -Path "search-failures.csv" -NoTypeInformation
    Write-Host "`nSearch failures have been exported to 'search-failures.csv'" -ForegroundColor Yellow
}

# Generate a report of all search tests
$results.SearchTests | Export-Csv -Path "search-tests.csv" -NoTypeInformation
Write-Host "`nComplete search test results have been exported to 'search-tests.csv'" -ForegroundColor Green

# Calculate search success rate
$successRate = if ($results.SearchTests.Count -gt 0) { 
    [Math]::Round(($results.SearchTests.Count - $results.SearchFailures.Count) / $results.SearchTests.Count * 100, 2) 
} else { 
    0 
}

Write-Host "`nSearch success rate: $successRate%" -ForegroundColor $(if ($successRate -ge 90) { "Green" } elseif ($successRate -ge 75) { "Yellow" } else { "Red" })
