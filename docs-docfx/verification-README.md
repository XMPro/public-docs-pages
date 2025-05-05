# DocFX Documentation Verification Scripts

This directory contains a set of PowerShell scripts for verifying the quality and integrity of the DocFX documentation. These scripts help identify issues with links, images, navigation, and search functionality.

## Prerequisites

- PowerShell 5.1 or later
- DocFX documentation built and served locally
- The DocFX server running on port 9000 (or update the `$baseUrl` variable in the scripts if using a different port)

## Available Scripts

### run-verification.ps1

This is the main script that runs all the verification scripts and generates a summary report. It:

1. Checks if the DocFX server is running
2. Creates a results directory for storing verification results
3. Runs each verification script and captures the output
4. Generates a summary report in Markdown format
5. Updates the migration plan to mark the verification step as complete

### verify-links.ps1

This script checks for broken internal links in the documentation. It:

1. Crawls the documentation site starting from the base URL
2. Extracts all internal links from each page
3. Checks if each link is valid
4. Generates a report of broken links

### verify-images.ps1

This script checks for broken image links and missing alt text. It:

1. Crawls the documentation site starting from the base URL
2. Extracts all image links from each page
3. Checks if each image link is valid
4. Checks if each image has alt text
5. Generates reports of broken images and images missing alt text

### verify-navigation.ps1

This script checks the navigation structure of the documentation. It:

1. Crawls the documentation site starting from the base URL
2. Extracts the navigation menu, breadcrumbs, and table of contents from each page
3. Checks if all navigation links are valid
4. Analyzes the navigation structure for consistency
5. Generates reports of broken navigation links and inconsistencies

### verify-search.ps1

This script tests the search functionality of the documentation. It:

1. Crawls the documentation site starting from the base URL
2. Extracts search terms from each page
3. Performs searches using these terms
4. Checks if the search returns results
5. Generates reports of search failures and overall search success rate

## How to Use

1. Make sure the DocFX server is running on port 9000:
   ```powershell
   cd docs-docfx
   docfx serve --port 9000
   ```

2. Open a new PowerShell window and run the main verification script:
   ```powershell
   cd docs-docfx
   .\run-verification.ps1
   ```

3. Review the verification results in the `verification-results` directory:
   - `verification-summary.md`: Summary of all verification results
   - `verify-links-transcript.txt`: Detailed output of the links verification
   - `verify-images-transcript.txt`: Detailed output of the images verification
   - `verify-navigation-transcript.txt`: Detailed output of the navigation verification
   - `verify-search-transcript.txt`: Detailed output of the search verification
   - Various CSV files with detailed reports of issues found

4. Fix any issues identified by the verification scripts and re-run the verification to confirm the issues have been resolved.

## Running Individual Scripts

You can also run each verification script individually:

```powershell
cd docs-docfx
.\verify-links.ps1
```

```powershell
cd docs-docfx
.\verify-images.ps1
```

```powershell
cd docs-docfx
.\verify-navigation.ps1
```

```powershell
cd docs-docfx
.\verify-search.ps1
```

## Interpreting Results

### Links Verification

- **Broken links**: These are links that return a non-200 HTTP status code or cannot be accessed. They should be fixed by updating the link to point to the correct URL or removing the link if the target no longer exists.

### Images Verification

- **Broken images**: These are image links that return a non-200 HTTP status code or cannot be accessed. They should be fixed by updating the image link to point to the correct URL or removing the image if it no longer exists.
- **Missing alt text**: These are images that do not have alt text. Alt text is important for accessibility and should be added to all images.

### Navigation Verification

- **Broken navigation links**: These are navigation links that return a non-200 HTTP status code or cannot be accessed. They should be fixed by updating the link to point to the correct URL or removing the link if the target no longer exists.
- **Navigation inconsistencies**: These are inconsistencies in the navigation structure, such as different navigation menus on different pages. They should be fixed to ensure a consistent navigation experience.

### Search Verification

- **Search failures**: These are search terms that either fail to execute a search or return no results. They may indicate issues with the search functionality or content that is not properly indexed.
- **Search success rate**: This is the percentage of searches that successfully return results. A high success rate indicates that the search functionality is working well.

## Customizing the Scripts

You can customize the scripts by modifying the following variables:

- `$baseUrl`: The base URL of the DocFX server (default: `http://localhost:9000`)
- `$resultsDir`: The directory where verification results are stored (default: `verification-results`)
- `$scripts`: The list of verification scripts to run (in `run-verification.ps1`)

## Troubleshooting

- If the scripts fail to run, make sure the DocFX server is running on the correct port.
- If the scripts take too long to run, you can modify them to limit the number of pages crawled or the number of links checked.
- If the scripts report false positives, you can modify them to ignore specific URLs or patterns.
