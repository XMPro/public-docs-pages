# Navigation Fix Tool

This tool helps identify and fix navigation issues in the DocFX documentation. It addresses problems that prevent proper verification of image references and other content.

## The Problem

After migrating content from GitBook to DocFX, several navigation issues can occur:

1. **Broken TOC links**: Links in table of contents (TOC) files that point to non-existent files
2. **TOC inconsistencies**: Different TOC files referencing the same content with different paths
3. **Broken internal links**: Links within markdown files that point to non-existent files

These issues prevent proper navigation through the documentation and make it difficult to verify if image references are working correctly.

## The Solution

The `fix-navigation-issues.ps1` script scans the documentation for navigation issues and automatically fixes them. It:

1. Finds and fixes broken links in TOC files
2. Identifies and resolves inconsistencies between TOC files
3. Locates and repairs broken internal links in markdown files
4. Creates placeholder files when necessary
5. Generates a summary report of issues found and fixed

## Usage

To run the navigation fix script:

```powershell
cd docs-docfx
.\fix-navigation-issues.ps1
```

The script will:
1. Scan all TOC files in the docs directory
2. Identify issues and inconsistencies
3. Fix the issues automatically
4. Generate a summary report

## How It Works

The script performs the following steps:

1. **TOC File Analysis**:
   - Finds all `toc.yml` files in the documentation
   - Parses each TOC file to extract entries and links
   - Verifies that each link points to an existing file

2. **TOC Issue Resolution**:
   - For missing files, tries to find files with different extensions (.md, .html)
   - Looks for files with similar names using a similarity algorithm
   - Creates placeholder files when no suitable alternative is found
   - Updates TOC entries to point to the correct files

3. **TOC Inconsistency Detection**:
   - Identifies entries with the same name but different href values across TOC files
   - Determines which href points to an existing file
   - Updates TOC files to use consistent href values
   - Creates placeholder files when neither href points to an existing file

4. **Broken Link Detection**:
   - Scans all markdown files for internal links
   - Verifies that each link points to an existing file
   - Identifies broken links

5. **Broken Link Resolution**:
   - Tries to find files with different extensions
   - Looks for files with similar names
   - Updates links to point to the correct files

## Verification

After running the fix script, you should verify that the navigation issues have been resolved by:

1. Running the navigation verification script:
   ```powershell
   .\verify-navigation.ps1
   ```

2. Building and serving the documentation locally:
   ```powershell
   docfx build
   docfx serve _site
   ```

3. Manually testing navigation through the documentation to ensure all links work correctly

## Summary Report

The script generates a summary report (`navigation-fix-summary.md`) that includes:

- Total number of TOC issues found and fixed
- Total number of TOC inconsistencies found and fixed
- Total number of broken links found and fixed
- Overall summary of issues found and fixed

## Next Steps

After fixing navigation issues, you can proceed with:

1. **Image Verification**: Run the image verification script to check if image references are working correctly:
   ```powershell
   .\run-image-verification-optimized.ps1 -batchSize 1 -fix
   ```

2. **Manual Review**: Review the documentation to ensure all content is accessible and displays correctly

3. **Final Deployment**: Once all issues are resolved, deploy the documentation to the production environment

## Troubleshooting

If you encounter any issues with the script:

- Check the console output for error messages
- Review the summary report for details on issues that couldn't be fixed
- Manually inspect problematic files and fix issues that the script couldn't resolve
- Run the script again after making manual fixes
