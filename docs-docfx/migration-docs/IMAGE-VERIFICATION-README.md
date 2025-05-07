# Image Reference Verification

This tool helps verify and fix image references in markdown files, ensuring that all image links correctly match the actual image filenames. It's particularly useful after migrations where image filenames may have been updated (e.g., replacing spaces with underscores) but the markdown references weren't updated.

## The Problem

During migration processes, image filenames often change to follow consistent naming conventions (e.g., replacing spaces with underscores), but the markdown files that reference these images aren't always updated to match. This results in broken image links.

For example, a markdown file might reference:
```markdown
![Alt text](images/XMPro%20Notebook License.png)
```

But the actual image file is named:
```
XMPro_Notebook_License.png
```

## The Solution

The `incremental-verify-image-references.ps1` script scans markdown files for image references, checks if the referenced images exist, and attempts to find alternatives if they don't. It can automatically fix the references to point to the correct files.

Key features:
- Processes files in batches to avoid token limit issues
- Saves progress between runs, allowing you to resume interrupted verification
- Prioritizes Title_Snake_Case_Convention for image filenames
- Provides detailed reporting on issues found and fixed
- Exports results to CSV for further analysis

## Usage

### Basic Usage

To check for image reference issues without making changes:

```powershell
.\incremental-verify-image-references.ps1
```

To automatically fix image references:

```powershell
.\incremental-verify-image-references.ps1 -fix
```

### Advanced Options

The script supports several command-line options:

| Option | Description |
|--------|-------------|
| `-fix` | Fix issues automatically (default: check only) |
| `-dir <path>` | Specify the root directory to scan (default: current directory) |
| `-prefer-snake-case` | Prefer Title_Snake_Case_Convention for filenames (default) |
| `-prefer-kebab-case` | Prefer kebab-case for filenames |
| `-batch-size <number>` | Number of files to process in each batch (default: 10) |
| `-progress-file <path>` | Path to the progress file (default: image-verification-progress.json) |
| `-csv-report <path>` | Path to the CSV report file (default: image-verification-report.csv) |
| `-continue` | Continue from the last run using the progress file |
| `-no-csv` | Disable CSV report generation |

### Examples

Process files in batches of 20 and fix issues:
```powershell
.\incremental-verify-image-references.ps1 -fix -batch-size 20
```

Continue a previous run:
```powershell
.\incremental-verify-image-references.ps1 -continue
```

Scan a specific directory:
```powershell
.\incremental-verify-image-references.ps1 -dir docs-docfx/docs
```

## How It Works

1. The script scans markdown files for image references (both `![alt](path)` and `<img src="path">` formats)
2. For each reference, it checks if the image exists at the specified path
3. If the image doesn't exist, it tries to find alternatives by:
   - Checking multiple directories (same directory, images subdirectory, parent's images directory, etc.)
   - Trying different filename formats (spaces, underscores, hyphens)
   - URL decoding the filename
4. If an alternative is found, it can automatically update the reference in the markdown file
5. Progress is saved after each batch, allowing you to resume interrupted verification

## Reporting

The script generates two types of reports:

1. **Console output**: Detailed information about issues found and fixed
2. **CSV report**: A file containing all issues, which can be opened in Excel or other tools for further analysis

## Avoiding Token Limits

When running the script with AI assistance, you might encounter token limits that prevent the script from completing. To address this issue, we've created wrapper scripts that run the verification with optimized settings.

### Standard Wrapper Script

```powershell
.\run-image-verification.ps1 -fix
```

This wrapper script has the following benefits:
- Uses a default batch size of 3 (configurable)
- Handles the fix and continue parameters
- Helps avoid token limit issues

#### Options for run-image-verification.ps1

| Option | Description |
|--------|-------------|
| `-fix` | Fix issues automatically (default: check only) |
| `-batchSize <number>` | Number of files to process in each batch (default: 3) |
| `-continue` | Continue from the last run using the progress file |
| `-resetProgress` | Reset the progress file before starting (useful when encountering token limits) |

#### Examples

Run with default settings (batch size 3, check only):
```powershell
.\run-image-verification.ps1
```

Run with fix mode enabled:
```powershell
.\run-image-verification.ps1 -fix
```

Continue a previous run with a custom batch size:
```powershell
.\run-image-verification.ps1 -continue -batchSize 5
```

### Optimized Scripts for Severe Token Limit Issues

If you still encounter token limit issues with the standard wrapper script, we've created optimized versions that use minimal memory:

```powershell
.\run-image-verification-optimized.ps1 -fix
```

The optimized scripts include:

1. **incremental-verify-image-references-optimized.ps1**: An enhanced version of the original script with:
   - Minimal memory usage option that stores only essential data in memory
   - Immediate CSV export of issues to reduce memory footprint
   - More frequent progress saves
   - Improved progress tracking with issue counts
   - Better handling of large datasets

2. **run-image-verification-optimized.ps1**: A wrapper for the optimized script that:
   - Enables minimal memory usage by default
   - Provides options for custom progress and report files
   - Includes enhanced guidance for handling token limits

#### Options for run-image-verification-optimized.ps1

| Option | Description |
|--------|-------------|
| `-fix` | Fix issues automatically (default: check only) |
| `-batchSize <number>` | Number of files to process in each batch (default: 3) |
| `-continue` | Continue from the last run using the progress file |
| `-resetProgress` | Reset the progress file before starting |
| `-progressFile <path>` | Custom path for the progress file |
| `-csvReport <path>` | Custom path for the CSV report |

#### Examples

Run with minimal memory usage:
```powershell
.\run-image-verification-optimized.ps1
```

Continue a previous run with minimal memory usage:
```powershell
.\run-image-verification-optimized.ps1 -continue
```

Use custom progress and report files:
```powershell
.\run-image-verification-optimized.ps1 -progressFile "progress-part1.json" -csvReport "report-part1.csv"
```

### Handling Token Limit Issues

If you encounter token limit errors when running the script with AI assistance, try these approaches:

1. **Use the optimized script with minimal memory usage**:
   ```powershell
   .\run-image-verification-optimized.ps1 -batchSize 1
   ```

2. **Use custom progress files for different sections**:
   ```powershell
   # First run:
   .\run-image-verification-optimized.ps1 -progressFile "progress-part1.json" -csvReport "report-part1.csv"
   
   # Second run (different section):
   .\run-image-verification-optimized.ps1 -progressFile "progress-part2.json" -csvReport "report-part2.csv" -dir "docs/another-section"
   ```

3. **Reset progress and start with a small batch**:
   ```powershell
   .\run-image-verification-optimized.ps1 -batchSize 1 -resetProgress
   ```

4. **Run in multiple sessions**:
   - Run with a small batch size until you hit a token limit
   - Close the AI session to clear the token context
   - Start a new session and continue with the `-continue` flag

## Troubleshooting

If you encounter any issues:

- Check the progress file to see which files have been processed
- Try running with a smaller batch size if you're hitting token limits
- Use the `-continue` option to resume from where you left off
- Check the CSV report for details on specific issues
- If the progress file becomes too large, use the `-resetProgress` option to start fresh
- Switch to the optimized scripts if you're consistently hitting token limits
- Use separate progress files for different parts of the verification process
