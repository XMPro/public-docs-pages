# Script to update image paths in markdown files

$files = Get-ChildItem -Path "docs" -Filter "*.md" -Recurse

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    $newContent = $content -replace '!\[(.*?)\]\(images/', '![$1](/docs/images/'
    
    if ($content -ne $newContent) {
        Set-Content -Path $file.FullName -Value $newContent
        Write-Host "Updated image paths in $($file.FullName)"
    }
}

Write-Host "Image path update completed."
