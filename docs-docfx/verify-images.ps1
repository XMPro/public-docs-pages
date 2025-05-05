# Script to verify images in the DocFX documentation

Write-Host "Starting image verification for DocFX documentation..." -ForegroundColor Green

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

# Function to extract image links from HTML content
function Get-ImagesFromHtml {
    param (
        [string]$HtmlContent,
        [string]$BaseUrl,
        [string]$CurrentPath,
        [string]$PageUrl
    )
    
    $images = @()
    
    # Match src attributes in img tags
    $srcMatches = [regex]::Matches($HtmlContent, '<img[^>]*src="([^"]+)"[^>]*>')
    foreach ($match in $srcMatches) {
        $src = $match.Groups[1].Value
        $altMatch = [regex]::Match($match.Value, 'alt="([^"]*)"')
        $alt = if ($altMatch.Success) { $altMatch.Groups[1].Value } else { "" }
        
        # Skip data URIs
        if ($src.StartsWith("data:")) {
            continue
        }
        
        # Handle external images
        if ($src.StartsWith("http")) {
            $images += [PSCustomObject]@{
                PageUrl = $PageUrl
                ImageUrl = $src
                Alt = $alt
                IsExternal = $true
            }
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
        
        # Add to the list of images
        $images += [PSCustomObject]@{
            PageUrl = $PageUrl
            ImageUrl = "$BaseUrl$src"
            Alt = $alt
            IsExternal = $false
        }
    }
    
    return $images
}

# Function to crawl the site and check images
function Crawl-Site-For-Images {
    param (
        [string]$StartUrl,
        [string]$BaseUrl
    )
    
    $visitedUrls = @{}
    $urlsToVisit = @($StartUrl)
    $allImages = @()
    $brokenImages = @()
    $missingAltText = @()
    
    $totalChecked = 0
    $totalBroken = 0
    $totalMissingAlt = 0
    
    while ($urlsToVisit.Count -gt 0) {
        $currentUrl = $urlsToVisit[0]
        $urlsToVisit = $urlsToVisit[1..($urlsToVisit.Count - 1)]
        
        # Skip if already visited
        if ($visitedUrls.ContainsKey($currentUrl)) {
            continue
        }
        
        # Mark as visited
        $visitedUrls[$currentUrl] = $true
        
        # If it's an HTML page, extract links and images
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
                
                # Extract images
                $images = Get-ImagesFromHtml -HtmlContent $htmlContent -BaseUrl $BaseUrl -CurrentPath $currentPath -PageUrl $currentUrl
                $allImages += $images
                
                # Check each image
                foreach ($image in $images) {
                    if (-not $image.IsExternal) {
                        $isValid = Test-Url -Url $image.ImageUrl
                        if (-not $isValid) {
                            $totalBroken++
                            $brokenImages += $image
                            Write-Host "Broken image: $($image.ImageUrl) on page $($image.PageUrl)" -ForegroundColor Red
                        }
                    }
                    
                    if ([string]::IsNullOrWhiteSpace($image.Alt)) {
                        $totalMissingAlt++
                        $missingAltText += $image
                        Write-Host "Missing alt text: $($image.ImageUrl) on page $($image.PageUrl)" -ForegroundColor Yellow
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
            Write-Host "Progress: Checked $totalChecked pages, Found $totalBroken broken images, $totalMissingAlt missing alt text, Queue size: $($urlsToVisit.Count)" -ForegroundColor Cyan
        }
    }
    
    return @{
        AllImages = $allImages
        BrokenImages = $brokenImages
        MissingAltText = $missingAltText
    }
}

# Start the crawl
Write-Host "Starting site crawl from $baseUrl..." -ForegroundColor Cyan
$results = Crawl-Site-For-Images -StartUrl $baseUrl -BaseUrl $baseUrl

# Output summary
Write-Host "`nImage verification complete!" -ForegroundColor Green
Write-Host "Total images found: $($results.AllImages.Count)" -ForegroundColor Cyan
Write-Host "Total broken images: $($results.BrokenImages.Count)" -ForegroundColor $(if ($results.BrokenImages.Count -eq 0) { "Green" } else { "Red" })
Write-Host "Total images missing alt text: $($results.MissingAltText.Count)" -ForegroundColor $(if ($results.MissingAltText.Count -eq 0) { "Green" } else { "Yellow" })

if ($results.BrokenImages.Count -gt 0) {
    Write-Host "`nList of broken images:" -ForegroundColor Red
    $results.BrokenImages | Format-Table -Property PageUrl, ImageUrl -AutoSize
    
    # Export broken images to a file
    $results.BrokenImages | Select-Object PageUrl, ImageUrl | Export-Csv -Path "broken-images.csv" -NoTypeInformation
    Write-Host "`nBroken images have been exported to 'broken-images.csv'" -ForegroundColor Yellow
}

if ($results.MissingAltText.Count -gt 0) {
    Write-Host "`nList of images missing alt text:" -ForegroundColor Yellow
    $results.MissingAltText | Format-Table -Property PageUrl, ImageUrl -AutoSize
    
    # Export images missing alt text to a file
    $results.MissingAltText | Select-Object PageUrl, ImageUrl | Export-Csv -Path "missing-alt-text.csv" -NoTypeInformation
    Write-Host "`nImages missing alt text have been exported to 'missing-alt-text.csv'" -ForegroundColor Yellow
}

# Generate a report of all images
$results.AllImages | Select-Object PageUrl, ImageUrl, Alt, IsExternal | Export-Csv -Path "all-images.csv" -NoTypeInformation
Write-Host "`nComplete image inventory has been exported to 'all-images.csv'" -ForegroundColor Green
