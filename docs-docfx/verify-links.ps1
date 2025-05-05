# Script to verify links and functionality in the DocFX documentation
param(
    [Parameter(Mandatory=$false)]
    [int]$Port = 7000,
    
    [Parameter(Mandatory=$false)]
    [switch]$UseStaticFiles,
    
    [Parameter(Mandatory=$false)]
    [string]$SitePath = "_site",
    
    [Parameter(Mandatory=$false)]
    [int]$MaxLinksToCheck = 100,
    
    [Parameter(Mandatory=$false)]
    [int]$TimeoutSeconds = 60
)

Write-Host "Starting link verification for DocFX documentation..." -ForegroundColor Green

# Define the base URL based on parameters
$baseUrl = if ($UseStaticFiles) {
    # Use file:// protocol for static files
    "file:///$((Get-Item $SitePath).FullName)"
} else {
    # Use HTTP protocol for server
    "http://localhost:$Port"
}

Write-Host "Using base URL: $baseUrl" -ForegroundColor Cyan

# Function to check if a URL is valid
function Test-Url {
    param (
        [string]$Url
    )
    
    try {
        # Handle file:// URLs differently than http:// URLs
        if ($Url.StartsWith("file://")) {
            $filePath = $Url.Replace("file:///", "").Replace("/", "\")
            return (Test-Path $filePath)
        } else {
            $request = [System.Net.WebRequest]::Create($Url)
            $request.Method = "HEAD"
            $request.Timeout = 5000
            $response = $request.GetResponse()
            $statusCode = [int]$response.StatusCode
            $response.Close()
            
            return $statusCode -eq 200
        }
    }
    catch {
        Write-Host "Error testing URL $Url : $_" -ForegroundColor Yellow
        return $false
    }
}

# Function to extract links from HTML content
function Get-LinksFromHtml {
    param (
        [string]$HtmlContent,
        [string]$BaseUrl,
        [string]$CurrentPath
    )
    
    $links = @()
    
    # Match href attributes in anchor tags
    $hrefMatches = [regex]::Matches($HtmlContent, 'href="([^"]+)"')
    foreach ($match in $hrefMatches) {
        $href = $match.Groups[1].Value
        
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
        
        # Add to the list of links
        $links += "$BaseUrl$href"
    }
    
    # Match src attributes in img tags
    $srcMatches = [regex]::Matches($HtmlContent, 'src="([^"]+)"')
    foreach ($match in $srcMatches) {
        $src = $match.Groups[1].Value
        
        # Skip external images
        if ($src.StartsWith("http")) {
            continue
        }
        
        # Resolve relative paths
        if ($src.StartsWith("../")) {
            $parentPath = $CurrentPath -replace "/[^/]+$", ""
            $src = $src -replace "^\.\.", $parentPath
        }
        elseif ($src.StartsWith("./")) {
            $src = $src -replace "^\.", $CurrentPath
        }
        elseif (-not $src.StartsWith("/")) {
            $src = "$CurrentPath/$src"
        }
        
        # Normalize the path
        $src = $src -replace "//", "/"
        
        # Add to the list of links
        $links += "$BaseUrl$src"
    }
    
    return $links
}

# Function to crawl the site and check links
function Crawl-Site {
    param (
        [string]$StartUrl,
        [string]$BaseUrl,
        [int]$MaxLinks,
        [int]$Timeout
    )
    
    $visitedUrls = @{}
    $urlsToVisit = @($StartUrl)
    $brokenLinks = @()
    
    $totalChecked = 0
    $totalBroken = 0
    
    # Set a timeout for the crawl
    $startTime = Get-Date
    $timeoutTime = $startTime.AddSeconds($Timeout)
    
    while ($urlsToVisit.Count -gt 0 -and $totalChecked -lt $MaxLinks -and (Get-Date) -lt $timeoutTime) {
        $currentUrl = $urlsToVisit[0]
        $urlsToVisit = $urlsToVisit[1..($urlsToVisit.Count - 1)]
        
        # Skip if already visited
        if ($visitedUrls.ContainsKey($currentUrl)) {
            continue
        }
        
        # Mark as visited
        $visitedUrls[$currentUrl] = $true
        
        # Check the URL
        $isValid = Test-Url -Url $currentUrl
        $totalChecked++
        
        if (-not $isValid) {
            $totalBroken++
            $brokenLinks += $currentUrl
            Write-Host "Broken link: $currentUrl" -ForegroundColor Red
            continue
        }
        
        # If it's an HTML page, extract links and add to the queue
        if ($currentUrl -match "\.(html|htm)$" -or $currentUrl -eq $StartUrl -or $currentUrl -match "/$") {
            try {
                # Handle file:// URLs differently than http:// URLs
                if ($currentUrl.StartsWith("file://")) {
                    $filePath = $currentUrl.Replace("file:///", "").Replace("/", "\")
                    $htmlContent = Get-Content -Path $filePath -Raw -ErrorAction Stop
                } else {
                    $response = Invoke-WebRequest -Uri $currentUrl -UseBasicParsing -ErrorAction Stop
                    $htmlContent = $response.Content
                }
                
                # Get the current path
                $currentPath = $currentUrl.Replace($BaseUrl, "")
                $currentPath = $currentPath -replace "/[^/]+$", ""
                
                # Extract links
                $links = Get-LinksFromHtml -HtmlContent $htmlContent -BaseUrl $BaseUrl -CurrentPath $currentPath
                
                foreach ($link in $links) {
                    if (-not $visitedUrls.ContainsKey($link) -and -not $urlsToVisit.Contains($link)) {
                        $urlsToVisit += $link
                    }
                }
                
                Write-Host "Checked: $currentUrl - OK" -ForegroundColor Green
            }
            catch {
                Write-Host "Error processing $currentUrl : $_" -ForegroundColor Yellow
            }
        }
        else {
            Write-Host "Checked: $currentUrl - OK" -ForegroundColor Green
        }
        
        # Show progress
        if ($totalChecked % 10 -eq 0) {
            Write-Host "Progress: Checked $totalChecked URLs, Found $totalBroken broken links, Queue size: $($urlsToVisit.Count)" -ForegroundColor Cyan
        }
    }
    
    return $brokenLinks
}

# Verify the site is accessible if using HTTP
if (-not $UseStaticFiles) {
    try {
        $testRequest = [System.Net.WebRequest]::Create($baseUrl)
        $testRequest.Method = "HEAD"
        $testRequest.Timeout = 5000
        $testResponse = $testRequest.GetResponse()
        $testResponse.Close()
    }
    catch {
        Write-Host "Error: Cannot connect to DocFX server at $baseUrl" -ForegroundColor Red
        Write-Host "Make sure the DocFX server is running with: docfx serve _site --port $Port" -ForegroundColor Yellow
        Write-Host "Or use -UseStaticFiles switch to check static files without a server" -ForegroundColor Yellow
        exit 1
    }
}

# Start the crawl
Write-Host "Starting site crawl from $baseUrl..." -ForegroundColor Cyan
Write-Host "Maximum links to check: $MaxLinksToCheck, Timeout: $TimeoutSeconds seconds" -ForegroundColor Cyan
$brokenLinks = Crawl-Site -StartUrl $baseUrl -BaseUrl $baseUrl -MaxLinks $MaxLinksToCheck -Timeout $TimeoutSeconds

# Output summary
Write-Host "`nLink verification complete!" -ForegroundColor Green
Write-Host "Total broken links found: $($brokenLinks.Count)" -ForegroundColor $(if ($brokenLinks.Count -eq 0) { "Green" } else { "Red" })

if ($brokenLinks.Count -gt 0) {
    Write-Host "`nList of broken links:" -ForegroundColor Red
    foreach ($link in $brokenLinks) {
        Write-Host $link -ForegroundColor Red
    }
    
    # Export broken links to a file
    $brokenLinks | Out-File -FilePath "verification-results/broken-links.txt" -Force
    Write-Host "`nBroken links have been exported to 'verification-results/broken-links.txt'" -ForegroundColor Yellow
    
    # Create the verification-results directory if it doesn't exist
    if (-not (Test-Path "verification-results")) {
        New-Item -ItemType Directory -Path "verification-results" | Out-Null
    }
}

# Return exit code based on success/failure
exit $brokenLinks.Count
