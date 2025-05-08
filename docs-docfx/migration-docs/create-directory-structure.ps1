# Create Directory Structure for Use Cases
# This script creates the necessary directory structure for the use cases migration

# Base directories
$baseDir = ".."
$resourcesDir = Join-Path $baseDir "docs/resources"
$faqsDir = Join-Path $resourcesDir "faqs"
$externalContentDir = Join-Path $faqsDir "external-content"
$useCasesDir = Join-Path $externalContentDir "use-cases"

# Create the directory structure
Write-Host "Creating directory structure for use cases..."

# Create external-content directory if it doesn't exist
if (-not (Test-Path $externalContentDir)) {
    Write-Host "Creating directory: $externalContentDir"
    New-Item -Path $externalContentDir -ItemType Directory -Force | Out-Null
}

# Create use-cases directory if it doesn't exist
if (-not (Test-Path $useCasesDir)) {
    Write-Host "Creating directory: $useCasesDir"
    New-Item -Path $useCasesDir -ItemType Directory -Force | Out-Null
}

Write-Host "Directory structure created successfully."
