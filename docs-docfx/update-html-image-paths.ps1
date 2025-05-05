# Script to update HTML image paths in markdown files

$files = Get-ChildItem -Path "docs" -Filter "*.md" -Recurse

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    $newContent = $content -replace '<img src="../../\.gitbook/assets/', '<img src="/docs/images/'
    
    if ($content -ne $newContent) {
        Set-Content -Path $file.FullName -Value $newContent
        Write-Host "Updated HTML image paths in $($file.FullName)"
    }
}

Write-Host "HTML image path update completed."
