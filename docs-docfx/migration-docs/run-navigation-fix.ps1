# Wrapper script for running the navigation fix tool with different options

param (
    [switch]$verifyOnly = $false,
    [string]$directory = "docs",
    [switch]$skipBrokenLinks = $false,
    [switch]$skipTocIssues = $false,
    [switch]$skipTocInconsistencies = $false,
    [switch]$help = $false
)

# Display help information
function Show-Help {
    Write-Host "Navigation Fix Tool Wrapper" -ForegroundColor Cyan
    Write-Host "=========================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "This script helps run the navigation fix tool with different options."
    Write-Host ""
    Write-Host "Usage:" -ForegroundColor Yellow
    Write-Host "  .\run-navigation-fix.ps1 [options]"
    Write-Host ""
    Write-Host "Options:" -ForegroundColor Yellow
    Write-Host "  -verifyOnly              Only verify navigation issues without fixing them"
    Write-Host "  -directory <path>        Specify the directory to scan (default: docs)"
    Write-Host "  -skipBrokenLinks         Skip checking for broken links in markdown files"
    Write-Host "  -skipTocIssues           Skip checking for issues in TOC files"
    Write-Host "  -skipTocInconsistencies  Skip checking for inconsistencies between TOC files"
    Write-Host "  -help                    Display this help information"
    Write-Host ""
    Write-Host "Examples:" -ForegroundColor Yellow
    Write-Host "  .\run-navigation-fix.ps1                     # Run with default settings"
    Write-Host "  .\run-navigation-fix.ps1 -verifyOnly         # Only verify issues without fixing"
    Write-Host "  .\run-navigation-fix.ps1 -directory docs/concepts  # Check only the concepts directory"
    Write-Host "  .\run-navigation-fix.ps1 -skipBrokenLinks    # Skip checking for broken links"
    Write-Host ""
}

# Show help if requested
if ($help) {
    Show-Help
    exit 0
}

# Create a temporary script file with the modified content
$tempScriptPath = [System.IO.Path]::GetTempFileName() + ".ps1"

# Read the original script content
$originalScriptContent = Get-Content -Path "fix-navigation-issues.ps1" -Raw

# Modify the script content based on parameters
$modifiedScriptContent = $originalScriptContent

# Replace the base directory if specified
if ($directory -ne "docs") {
    $modifiedScriptContent = $modifiedScriptContent -replace '\$docsDir = Join-Path \$baseDir "docs"', "`$docsDir = Join-Path `$baseDir `"$directory`""
}

# Add verification-only mode if requested
if ($verifyOnly) {
    # Add a function to verify without fixing
    $verifyOnlyFunction = @"

# Function to verify without fixing
function Verify-Only {
    param (
        [array]`$Issues,
        [string]`$IssueType
    )
    
    Write-Host "Found `$(`$Issues.Count) `$IssueType" -ForegroundColor `$(if (`$Issues.Count -eq 0) { "Green" } else { "Yellow" })
    
    if (`$Issues.Count -gt 0) {
        Write-Host "Issues found:" -ForegroundColor Yellow
        foreach (`$issue in `$Issues) {
            Write-Host "  - `$(`$issue | ConvertTo-Json -Compress)" -ForegroundColor Yellow
        }
    }
}

"@
    
    # Insert the function before the main script execution
    $insertPoint = $modifiedScriptContent.IndexOf("# Main script execution")
    $modifiedScriptContent = $modifiedScriptContent.Insert($insertPoint, $verifyOnlyFunction)
    
    # Replace the fix functions with verify-only calls
    $modifiedScriptContent = $modifiedScriptContent -replace "# Fix TOC issues\s+if \(\$tocIssues\.Count -gt 0\) \{\s+Write-Host.*?\s+\$fixedTocIssues = Fix-TocIssues -Issues \$tocIssues\s+Write-Host.*?\s+\}", "# Verify TOC issues only`nif (`$tocIssues.Count -gt 0) {`n    Verify-Only -Issues `$tocIssues -IssueType 'TOC issues'`n    `$fixedTocIssues = @()`n}"
    
    $modifiedScriptContent = $modifiedScriptContent -replace "# Fix TOC inconsistencies\s+if \(\$tocInconsistencies\.Count -gt 0\) \{\s+Write-Host.*?\s+\$fixedTocInconsistencies = Fix-TocInconsistencies -Inconsistencies \$tocInconsistencies\s+Write-Host.*?\s+\}", "# Verify TOC inconsistencies only`nif (`$tocInconsistencies.Count -gt 0) {`n    Verify-Only -Issues `$tocInconsistencies -IssueType 'TOC inconsistencies'`n    `$fixedTocInconsistencies = @()`n}"
    
    $modifiedScriptContent = $modifiedScriptContent -replace "# Fix broken links\s+if \(\$brokenLinks\.Count -gt 0\) \{\s+Write-Host.*?\s+\$fixedBrokenLinks = Fix-BrokenLinks -BrokenLinks \$brokenLinks\s+Write-Host.*?\s+\}", "# Verify broken links only`nif (`$brokenLinks.Count -gt 0) {`n    Verify-Only -Issues `$brokenLinks -IssueType 'broken links'`n    `$fixedBrokenLinks = @()`n}"
}

# Skip broken links check if requested
if ($skipBrokenLinks) {
    $modifiedScriptContent = $modifiedScriptContent -replace "# Find broken links in markdown files.*?# Fix broken links.*?}", "# Skipping broken links check`n`$brokenLinks = @()`n`$fixedBrokenLinks = @()"
}

# Skip TOC issues check if requested
if ($skipTocIssues) {
    $modifiedScriptContent = $modifiedScriptContent -replace "# Verify TOC files.*?# Fix TOC issues.*?}", "# Skipping TOC issues check`n`$tocIssues = @()`n`$fixedTocIssues = @()"
}

# Skip TOC inconsistencies check if requested
if ($skipTocInconsistencies) {
    $modifiedScriptContent = $modifiedScriptContent -replace "# Find TOC inconsistencies.*?# Fix TOC inconsistencies.*?}", "# Skipping TOC inconsistencies check`n`$tocInconsistencies = @()`n`$fixedTocInconsistencies = @()"
}

# Save the modified script to a temporary file
Set-Content -Path $tempScriptPath -Value $modifiedScriptContent

# Display the options being used
Write-Host "Running navigation fix with the following options:" -ForegroundColor Cyan
Write-Host "  Directory: $directory" -ForegroundColor Cyan
Write-Host "  Verify only: $verifyOnly" -ForegroundColor Cyan
Write-Host "  Skip broken links: $skipBrokenLinks" -ForegroundColor Cyan
Write-Host "  Skip TOC issues: $skipTocIssues" -ForegroundColor Cyan
Write-Host "  Skip TOC inconsistencies: $skipTocInconsistencies" -ForegroundColor Cyan
Write-Host ""

# Run the modified script
try {
    & $tempScriptPath
}
catch {
    Write-Host "Error running the navigation fix script: $_" -ForegroundColor Red
}
finally {
    # Clean up the temporary script file
    Remove-Item -Path $tempScriptPath -Force
}

# Provide next steps
Write-Host "`nNext steps:" -ForegroundColor Cyan
if ($verifyOnly) {
    Write-Host "1. Run the script without -verifyOnly to fix the identified issues:" -ForegroundColor Yellow
    Write-Host "   .\run-navigation-fix.ps1" -ForegroundColor Yellow
}
else {
    Write-Host "1. Verify that the navigation issues have been fixed:" -ForegroundColor Yellow
    Write-Host "   .\verify-navigation.ps1" -ForegroundColor Yellow
    Write-Host "2. Run the image verification script to check image references:" -ForegroundColor Yellow
    Write-Host "   .\run-image-verification-optimized.ps1 -batchSize 1 -fix" -ForegroundColor Yellow
}
