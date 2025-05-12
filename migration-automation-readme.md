# DocFX Migration Automation

This document provides an overview of the automated migration process from GitBook to DocFX format.

## Migration Scripts

The following scripts have been created to automate the migration process:

### Master Migration Script

- **master-migration.ps1**: The main script that can process multiple files or entire sections at once.
  - Usage: `.\master-migration.ps1 -SectionName "section-name"` or `.\master-migration.ps1 -AllSections`
  - Parameters:
    - `-SectionName`: The name of the section to migrate (e.g., "resources", "concepts", etc.)
    - `-AllSections`: Process all sections
    - `-UpdateTrackingOnly`: Only update tracking files, don't modify content
    - `-CommitChanges`: Whether to commit and push changes (default: true)

### Section-Specific Scripts

These scripts are specialized for migrating specific types of files:

#### Concepts Section
- **migrate-app-index.ps1**: Migrates the application index file
- **migrate-app-template.ps1**: Migrates the application template file
- **migrate-app-page.ps1**: Migrates the application page file
- **migrate-app-canvas.ps1**: Migrates the application canvas file
- **migrate-app-page-layers.ps1**: Migrates the application page layers file
- **migrate-rule.ps1**: Migrates the recommendation rule file
- **migrate-execution-order.ps1**: Migrates the execution order file
- **migrate-auto-escalate.ps1**: Migrates the auto escalate file
- **migrate-recommendation-alert.ps1**: Migrates the recommendation alert file
- **migrate-collection.ps1**: Migrates the collection file
- **migrate-connector.ps1**: Migrates the connector file
- **migrate-landing-pages.ps1**: Migrates the landing pages file
- **migrate-version.ps1**: Migrates the version file
- **migrate-manage-access.ps1**: Migrates the manage access file
- **migrate-category.ps1**: Migrates the category file
- **migrate-variable.ps1**: Migrates the variable file

#### Getting Started Section
- **migrate-end-to-end-use-case.ps1**: Migrates the end-to-end use case file

#### How-Tos Section
- **migrate-run-integrity-check.ps1**: Migrates the run integrity check file
- **migrate-create-maintain-notes.ps1**: Migrates the create and maintain notes file

#### Blocks Toolbox Section
- **migrate-accordion.ps1**: Migrates the accordion file

#### Administration Section
- **migrate-register-company.ps1**: Migrates the register company file

#### Installation Section
- **migrate-deployment-index.ps1**: Migrates the deployment index file

#### Release Notes Section
- **migrate-release-notes.ps1**: Migrates all release notes files

### Utility Scripts

- **copy-page-images.ps1**: Copies images for the page file
- **copy-canvas-images.ps1**: Copies images for the canvas file
- **copy-page-layers-images.ps1**: Copies images for the page layers file
- **migrate-content-and-images.ps1**: Generic script to migrate both content and images

## Migration Process

The migration process follows these steps:

1. **Identify Files to Migrate**: The scripts read the tracking files to identify which files need migration (marked with ⚠️).
2. **Extract Image References**: The scripts analyze the GitBook files to identify image references.
3. **Copy Images**: Images are copied from the GitBook assets directory to the DocFX images directory.
4. **Convert Content**: GitBook syntax is converted to DocFX syntax:
   - GitBook hint syntax (`{% hint style="warning" %}`) to DocFX note syntax (`> [!WARNING]`)
   - GitBook content-ref syntax to DocFX links
   - GitBook figure syntax to DocFX image syntax
   - HTML color markup to DocFX syntax
5. **Update Image References**: Image references are updated to point to the new location.
6. **Update Tracking Files**: The tracking files are updated to reflect the migration status.
7. **Commit Changes**: Changes are committed and pushed to the repository.

## Tracking System

The migration progress is tracked using a set of markdown files:

- **migration-tracking.md**: The main tracking file that provides an overview of the migration status.
- **tracking/resources-tracking.md**: Tracks the migration of resources files.
- **tracking/concepts-tracking.md**: Tracks the migration of concepts files.
- **tracking/getting-started-tracking.md**: Tracks the migration of getting started files.
- **tracking/how-tos-tracking.md**: Tracks the migration of how-tos files.
- **tracking/blocks-toolbox-tracking.md**: Tracks the migration of blocks toolbox files.
- **tracking/administration-tracking.md**: Tracks the migration of administration files.
- **tracking/installation-tracking.md**: Tracks the migration of installation files.
- **tracking/release-notes-tracking.md**: Tracks the migration of release notes files.

Each tracking file uses the following status indicators:
- ✓ - Completed
- ⚠️ - Needs attention
- ❌ - Not started/Failed
- N/A - Not applicable

## Running the Migration

To run the migration for a specific section:

```powershell
.\master-migration.ps1 -SectionName "section-name"
```

To run the migration for all sections:

```powershell
.\master-migration.ps1 -AllSections
```

## Migration Status

As of the last update, all sections have been successfully migrated:

- Resources section: All files completed ✓
- Concepts section: All files completed ✓
- Getting Started section: All files completed ✓
- How-Tos section: All files completed ✓
- Blocks Toolbox section: All files completed ✓
- Administration section: All files completed ✓
- Installation section: All files completed ✓
- Release Notes section: All files completed ✓

The migration is now complete!
