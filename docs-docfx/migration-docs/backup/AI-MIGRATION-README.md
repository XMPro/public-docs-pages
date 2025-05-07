# AI-Assisted DocFX Migration Guide

This guide explains how to use the AI-optimized migration plan and helper script to efficiently migrate documentation from GitBook to DocFX with the assistance of generative AI tools.

## Overview

The migration process has been optimized for AI assistance, with clear patterns and processes that can be efficiently executed by AI tools. This repository includes:

1. **AI-Optimized Migration Plan** (`ai-optimized-migration-plan.md`): A streamlined plan designed specifically for AI-assisted migration
2. **AI Migration Helper Script** (`ai-migration-helper.ps1`): A PowerShell script that automates common migration tasks

## Prerequisites

- PowerShell 5.1 or higher
- DocFX installed and configured
- Source GitBook documentation in `docs-gitbook/docs`
- Target DocFX project in `docs-docfx`

## Using the AI Migration Helper Script

The `ai-migration-helper.ps1` script provides several modes to assist with different aspects of the migration process.

### Analyzing the GitBook Structure

Before starting the migration, analyze the GitBook structure to understand the content patterns:

```powershell
.\ai-migration-helper.ps1 -Mode analyze
```

This will scan the GitBook content and report on:
- Number of Markdown files
- GitBook-specific syntax patterns (hints, tabs)
- Image references
- Internal links

### Converting Content

To convert content from GitBook to DocFX:

```powershell
# Convert a specific section
.\ai-migration-helper.ps1 -Mode convert -Section "concepts/agent"

# Convert all content
.\ai-migration-helper.ps1 -Mode convert

# Force overwrite of existing files
.\ai-migration-helper.ps1 -Mode convert -Force
```

The conversion process handles:
- GitBook hint patterns → DocFX alerts
- GitBook tabs → DocFX tabs
- Image path updates
- Internal link updates

### Processing Images

To migrate images from GitBook assets to DocFX images:

```powershell
# Process images for a specific section
.\ai-migration-helper.ps1 -Mode images -Section "concepts/agent"

# Process all images
.\ai-migration-helper.ps1 -Mode images
```

### Generating TOC Files

To convert GitBook SUMMARY.md files to DocFX toc.yml files:

```powershell
# Generate TOC for a specific section
.\ai-migration-helper.ps1 -Mode toc -Section "concepts/agent"

# Generate all TOC files
.\ai-migration-helper.ps1 -Mode toc
```

### Verifying Migration

To verify the migration and check for issues:

```powershell
# Verify a specific section
.\ai-migration-helper.ps1 -Mode verify -Section "concepts/agent"

# Verify all content
.\ai-migration-helper.ps1 -Mode verify
```

The verification checks for:
- Remaining GitBook syntax
- Broken image links
- Broken internal links

## AI-Assisted Migration Workflow

For the most efficient migration with AI assistance, follow this workflow:

1. **Analyze the content structure**
   ```powershell
   .\ai-migration-helper.ps1 -Mode analyze
   ```

2. **Process section by section**
   For each major section of the documentation:
   
   a. Convert the content
   ```powershell
   .\ai-migration-helper.ps1 -Mode convert -Section "section-name"
   ```
   
   b. Process images
   ```powershell
   .\ai-migration-helper.ps1 -Mode images -Section "section-name"
   ```
   
   c. Generate TOC
   ```powershell
   .\ai-migration-helper.ps1 -Mode toc -Section "section-name"
   ```
   
   d. Verify the section
   ```powershell
   .\ai-migration-helper.ps1 -Mode verify -Section "section-name"
   ```

3. **Review and fix issues**
   - Check the verification report (`docs-docfx/verification-issues.txt`)
   - Manually fix any issues that couldn't be automatically resolved

4. **Build and test the DocFX site**
   ```powershell
   cd docs-docfx
   docfx build
   .\start-docfx-server.ps1
   ```

5. **Commit the changes**
   ```powershell
   git add .
   git commit -m "Migrate section: [section name]"
   git push origin main
   ```

## Using AI to Assist with Migration

When using generative AI tools to assist with the migration, provide the following context:

1. Share the `ai-optimized-migration-plan.md` file with the AI
2. Provide specific files that need to be migrated
3. Ask the AI to:
   - Convert GitBook syntax to DocFX syntax
   - Update image paths
   - Fix internal links
   - Generate appropriate toc.yml files

### Example AI Prompts

#### For Content Conversion

```
Please convert this GitBook markdown file to DocFX format following the patterns in the AI-optimized migration plan:

[paste GitBook markdown content here]
```

#### For TOC Generation

```
Please convert this GitBook SUMMARY.md file to a DocFX toc.yml file:

[paste SUMMARY.md content here]
```

#### For Troubleshooting

```
I'm seeing the following issue in my DocFX migration. Can you help me fix it?

[paste error or issue details]
```

## Common Migration Challenges

### Handling GitBook-Specific Components

Some GitBook components don't have direct equivalents in DocFX. The migration helper script handles common patterns, but you may need to manually address:

- Custom GitBook plugins
- Complex nested tabs
- Interactive components

### Fixing Broken Links

After migration, you may need to update:

- Cross-references between pages
- Links to assets and resources
- External links that were relative to the GitBook structure

### Image Path Consistency

Ensure consistent image paths by:

- Using relative paths (`../images/`)
- Maintaining the same directory structure
- Checking image references after migration

## Conclusion

By combining the AI-optimized migration plan, the migration helper script, and generative AI assistance, you can efficiently migrate your documentation from GitBook to DocFX while maintaining content integrity and structure.

For detailed information on the migration process, refer to the full migration plan in `docs-docfx/migration-plan.md`.
