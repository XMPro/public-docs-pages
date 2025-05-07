# Image Verification and Navigation Fix Tools

This folder contains the essential tools needed to complete the image verification process and fix navigation issues in the XMPro documentation. Unnecessary migration files have been moved to the backup folder to keep this directory focused on the current tasks.

## Current Issues

The original image verification script was causing token limit issues when run with AI assistance, even with a small batch size of 2. The optimized scripts in this folder address this issue by using minimal memory and storing only essential information.

## Contents

### Navigation Fix Tools

- **fix-navigation-issues.ps1**: Script to identify and fix navigation issues
- **run-navigation-fix.ps1**: Wrapper script for running the navigation fix tool
- **NAVIGATION-FIX-README.md**: Documentation for the navigation fix tools
- **verify-navigation.ps1**: Script to verify navigation functionality

### Image Verification Tools

- **incremental-verify-image-references-optimized.ps1**: Optimized version with minimal memory usage
- **run-image-verification-optimized.ps1**: Wrapper script for the optimized verification
- **IMAGE-VERIFICATION-README.md**: Documentation for image verification tools
- **image-verification-progress.json**: Progress file for incremental verification
- **image-verification-report.csv**: Report of image verification results

## Usage

### Running Navigation Fix

The navigation fix tools help identify and fix navigation issues that prevent proper verification of image references:

```powershell
cd docs-docfx
./migration-docs/run-navigation-fix.ps1
```

### Running Image Verification

The optimized image verification script can be run with:

```powershell
cd docs-docfx
./migration-docs/run-image-verification-optimized.ps1 -batchSize 1 -fix
```

If you still encounter token limits, you can use different progress files for different sections:

```powershell
cd docs-docfx
./migration-docs/run-image-verification-optimized.ps1 -progressFile "progress-part1.json" -csvReport "report-part1.csv"
```

## Backup

Other migration-related files that are no longer needed have been moved to the `backup` folder for reference. These include:

- Original and enhanced image verification scripts
- Migration plans and documentation
- Helper scripts and example files
- Verification results and reports

## Note

The actual documentation content is in the `docs` folder. These tools are specifically for addressing the image reference issues and navigation problems.
