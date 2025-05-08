# Fix TOC Files
# This script fixes the TOC files that have invalid YAML syntax due to unquoted colons in the title names

# Base directories
$baseDir = ".."
$resourcesDir = Join-Path $baseDir "docs/resources"
$faqsDir = Join-Path $resourcesDir "faqs"
$externalContentDir = Join-Path $faqsDir "external-content"
$blogsDir = Join-Path $externalContentDir "blogs"

# Get all blog year directories
$blogYears = @("2024", "2023", "2022", "2021", "2020", "2019", "2018", "2017", "2016", "2015", "2014", "2013", "2012", "2011", "2010")

# Process each year
foreach ($year in $blogYears) {
    $yearDir = Join-Path $blogsDir $year
    $tocFile = Join-Path $yearDir "toc.yml"
    
    # Check if the TOC file exists
    if (Test-Path $tocFile) {
        Write-Host "Processing TOC file: $tocFile"
        
        # Read the TOC file
        $content = Get-Content -Path $tocFile -Raw
        
        # Fix the first line (name: 2024 Blogs)
        $content = $content -replace "^- name: (\d{4}) Blogs", '- name: "$1 Blogs"'
        
        # Fix lines with colons in the title
        $content = $content -replace "- name: ([^`"'\r\n]*:[^`"'\r\n]*)", '- name: "$1"'
        
        # Write the fixed content back to the file
        Set-Content -Path $tocFile -Value $content
        
        Write-Host "Fixed TOC file: $tocFile"
    }
}

Write-Host "All TOC files have been fixed."
