# DocFX Migration Automation

This document explains the automated migration process for converting GitBook documentation to DocFX format.

## Overview

The migration process involves:
1. Copying images from GitBook assets to DocFX images directories
2. Updating image paths in markdown files
3. Converting GitBook-specific syntax to DocFX format
4. Testing the changes locally
5. Updating tracking documents
6. Committing and pushing changes

## Scripts

The following PowerShell scripts have been created to automate the migration process:

### 1. migrate-file.ps1

This script handles the migration of a single file that needs image migration only (content is already confirmed).

**Usage:**
```powershell
.\migrate-file.ps1 -GitBookPath "docs" -DocFXPath "docs-docfx/docs" -TrackingFile "tracking/concepts-tracking.md" -FileEntry "docs\concepts\application\devices.md | docs-docfx\docs\concepts\application\devices.md | ✓ | ❌ |"
```

**Parameters:**
- `GitBookPath`: The root path of the GitBook documentation
- `DocFXPath`: The root path of the DocFX documentation
- `TrackingFile`: The path to the tracking file
- `FileEntry`: The line from the tracking file that contains the file information

### 2. migrate-devices.ps1

This script is a specialized version for migrating the devices.md file as a test case.

**Usage:**
```powershell
.\migrate-devices.ps1
```

### 3. migrate-content-and-images.ps1

This script handles the migration of files that need both content and image migration.

**Usage:**
```powershell
.\migrate-content-and-images.ps1
```

### 4. run-migration.ps1

This script processes all files that need image migration only (content is already confirmed).

**Usage:**
```powershell
.\run-migration.ps1
```

### 5. master-migration.ps1

This is the main orchestration script that runs the entire migration process.

**Usage:**
```powershell
.\master-migration.ps1
```

## Migration Process

1. Start by running the `master-migration.ps1` script, which will:
   - Process files that need only image migration
   - Process files that need both content and image migration
   - Update the main migration tracking document
   - Test the DocFX server after each batch

2. The script will prompt you to verify the DocFX server is working correctly after processing batches of files.

3. If any issues are encountered, the script will pause and allow you to address them before continuing.

4. Once all files have been migrated, the script will update the main migration tracking document to indicate the migration is complete.

## Testing

After each batch of files is processed, the DocFX server will be started to verify the changes. You'll be prompted to confirm if the pages look correct.

To manually test the DocFX server:
```powershell
.\start-docfx-server.ps1
```

Then navigate to http://localhost:8080 in your browser.

## Troubleshooting

If you encounter issues during the migration process:

1. Check the console output for error messages
2. Verify the image paths in the DocFX files
3. Ensure the images exist in the GitBook assets directory
4. Check the tracking file for any inconsistencies

## Manual Steps

If a file fails to migrate automatically, you can:

1. Copy the images manually from `docs\.gitbook\assets` to the appropriate `docs-docfx\docs\...\images` directory
2. Update the image references in the DocFX file manually
3. Update the tracking file to mark the file as completed
4. Commit and push the changes

## Completion

The migration is considered complete when all files in the tracking document are marked as completed (✓) for both content and images.
