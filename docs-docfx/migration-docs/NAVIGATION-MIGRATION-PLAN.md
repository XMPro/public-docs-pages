# DocFX Navigation Migration Plan

This document outlines the detailed plan for migrating the navigation structure from GitBook to DocFX, ensuring that the DocFX site has like-for-like functionality with the GitBook site.

## Current State Analysis

### GitBook Navigation Structure
- Uses a single SUMMARY.md file with indentation to show hierarchy
- Has extensive external content (blogs, use cases, YouTube videos) organized by year
- Contains hundreds of individual entries, especially in the blogs section
- Deep hierarchical structure with multiple levels of nesting

### DocFX Navigation Structure
- Uses multiple toc.yml files distributed across directories
- Has references to external content sections but the actual directories and content are missing
- Structure is flatter and missing many of the deeper levels
- Missing most of the external content that exists in GitBook

## Implementation Plan

The implementation is divided into distinct phases with checkpoints to allow for resumption if the task is interrupted.

### Phase 1: Create Base Directory Structure

**Objective:** Create the basic directory structure needed for the external content.

**Steps:**
1. Create a state tracking file to record progress
2. Create directories for blogs organized by year (2010-2024)
3. Create directories for use cases
4. Create directories for YouTube content organized by year (2012-2024)
5. Update state tracking file after each major step

**Checkpoint:** Verify all directories have been created successfully.

**State Tracking:**
```json
{
  "phase": 1,
  "completed": true,
  "directories_created": [
    "blogs",
    "blogs/2024",
    "blogs/2023",
    // ... other directories
  ]
}
```

### Phase 2: Create TOC Files for Main Sections

**Objective:** Create the main toc.yml files for the external content sections.

**Steps:**
1. Create toc.yml for external-content directory
2. Create toc.yml for blogs directory with links to year subdirectories
3. Create toc.yml for use cases directory
4. Create toc.yml for YouTube directory with links to year subdirectories
5. Update state tracking file after each toc.yml creation

**Checkpoint:** Verify all main toc.yml files have been created successfully.

**State Tracking:**
```json
{
  "phase": 2,
  "completed": true,
  "toc_files_created": [
    "external-content/toc.yml",
    "external-content/blogs/toc.yml",
    // ... other toc files
  ]
}
```

### Phase 3: Create Index Files for Main Sections

**Objective:** Create index.md files for each main directory to provide content and navigation.

**Steps:**
1. Create index.md for external-content directory
2. Create index.md for blogs directory with links to year subdirectories
3. Create index.md for use cases directory
4. Create index.md for YouTube directory with links to year subdirectories
5. Update state tracking file after each index.md creation

**Checkpoint:** Verify all main index.md files have been created successfully.

**State Tracking:**
```json
{
  "phase": 3,
  "completed": true,
  "index_files_created": [
    "external-content/index.md",
    "external-content/blogs/index.md",
    // ... other index files
  ]
}
```

### Phase 4: Create Year-Specific TOC and Index Files

**Objective:** Create toc.yml and index.md files for each year directory.

**Steps:**
1. For each year in blogs:
   a. Create toc.yml with entries for all blog posts in that year
   b. Create index.md with links to all blog posts in that year
2. For each year in YouTube:
   a. Create toc.yml with entries for all videos in that year
   b. Create index.md with links to all videos in that year
3. Update state tracking file after each year is completed

**Checkpoint:** Verify all year-specific toc.yml and index.md files have been created successfully.

**State Tracking:**
```json
{
  "phase": 4,
  "completed": true,
  "years_completed": {
    "blogs": ["2024", "2023", "2022", "..."],
    "youtube": ["2024", "2023", "2022", "..."]
  }
}
```

### Phase 5: Migrate Blog Content

**Objective:** Migrate all blog content from GitBook to DocFX.

**Steps:**
1. For each year in blogs:
   a. For each blog post in that year:
      i. Create markdown file with content from GitBook
      ii. Update state tracking file after each blog post is migrated
2. Update state tracking file after each year is completed

**Checkpoint:** Verify all blog content has been migrated successfully.

**State Tracking:**
```json
{
  "phase": 5,
  "completed": true,
  "blogs_migrated": {
    "2024": ["blog1.md", "blog2.md", "..."],
    "2023": ["blog1.md", "blog2.md", "..."],
    // ... other years
  }
}
```

### Phase 6: Migrate Use Cases Content

**Objective:** Migrate all use cases content from GitBook to DocFX.

**Steps:**
1. For each use case:
   a. Create markdown file with content from GitBook
   b. Update state tracking file after each use case is migrated

**Checkpoint:** Verify all use cases content has been migrated successfully.

**State Tracking:**
```json
{
  "phase": 6,
  "completed": true,
  "use_cases_migrated": [
    "use-case1.md",
    "use-case2.md",
    // ... other use cases
  ]
}
```

### Phase 7: Migrate YouTube Content

**Objective:** Migrate all YouTube content from GitBook to DocFX.

**Steps:**
1. For each year in YouTube:
   a. For each video in that year:
      i. Create markdown file with content from GitBook
      ii. Update state tracking file after each video is migrated
2. Update state tracking file after each year is completed

**Checkpoint:** Verify all YouTube content has been migrated successfully.

**State Tracking:**
```json
{
  "phase": 7,
  "completed": true,
  "youtube_migrated": {
    "2024": ["video1.md", "video2.md", "..."],
    "2023": ["video1.md", "video2.md", "..."],
    // ... other years
  }
}
```

### Phase 8: Update Main Resources TOC

**Objective:** Update the main resources toc.yml to ensure the external content is properly linked.

**Steps:**
1. Update the FAQs section in resources/toc.yml to properly link to external content
2. Update state tracking file after the toc.yml is updated

**Checkpoint:** Verify the main resources toc.yml has been updated successfully.

**State Tracking:**
```json
{
  "phase": 8,
  "completed": true,
  "resources_toc_updated": true
}
```

### Phase 9: Test Navigation Structure

**Objective:** Thoroughly test the navigation structure to ensure it works correctly.

**Steps:**
1. Verify all links work correctly
2. Ensure the hierarchy matches the GitBook structure
3. Test navigation on different devices
4. Verify search functionality works with the new content
5. Update state tracking file after testing is completed

**Checkpoint:** Verify all navigation functionality works correctly.

**State Tracking:**
```json
{
  "phase": 9,
  "completed": true,
  "testing_completed": true,
  "issues_found": [
    // List any issues found during testing
  ]
}
```

## Implementation Script

To implement this plan, we'll create a PowerShell script that:

1. Reads the state tracking file to determine the current state
2. Executes the appropriate phase based on the current state
3. Updates the state tracking file after each step
4. Provides detailed logging for troubleshooting

The script will be designed to be idempotent, so it can be run multiple times without causing issues. If it's interrupted, it can be resumed from the last completed step.

### Script Structure

```powershell
# Navigation Migration Script

# Initialize state tracking
$stateFile = "navigation-migration-state.json"
$state = $null

# Check if state file exists
if (Test-Path $stateFile) {
    $state = Get-Content $stateFile | ConvertFrom-Json
} else {
    # Initialize new state
    $state = @{
        phase = 0
        completed = $false
        directories_created = @()
        toc_files_created = @()
        index_files_created = @()
        years_completed = @{
            blogs = @()
            youtube = @()
        }
        blogs_migrated = @{}
        use_cases_migrated = @()
        youtube_migrated = @{}
        resources_toc_updated = $false
        testing_completed = $false
        issues_found = @()
    }
}

# Save state function
function Save-State {
    $state | ConvertTo-Json -Depth 10 | Set-Content $stateFile
}

# Phase 1: Create Base Directory Structure
function Execute-Phase1 {
    # Implementation details...
}

# Phase 2: Create TOC Files for Main Sections
function Execute-Phase2 {
    # Implementation details...
}

# Additional phase functions...

# Main execution
switch ($state.phase) {
    0 { 
        Write-Host "Starting migration from the beginning..."
        $state.phase = 1
        Save-State
        Execute-Phase1
    }
    1 {
        if (-not $state.completed) {
            Write-Host "Resuming Phase 1: Create Base Directory Structure..."
            Execute-Phase1
        } else {
            Write-Host "Phase 1 already completed. Moving to Phase 2..."
            $state.phase = 2
            Save-State
            Execute-Phase2
        }
    }
    # Additional cases for other phases...
}
```

## Resumption Strategy

If the migration task is interrupted or fails, it can be resumed by:

1. Examining the state tracking file to determine the current state
2. Running the migration script again, which will automatically resume from the last completed step
3. Manually fixing any issues that caused the failure before resuming

This approach ensures that the migration can be completed across multiple sessions if necessary, without losing progress or duplicating work.

## Verification and Rollback

After each phase, the script will verify that the expected files and directories have been created successfully. If verification fails, the script will:

1. Log the failure details
2. Update the state tracking file to indicate the failure
3. Provide instructions for manual intervention

If necessary, each phase can be rolled back by:

1. Deleting the files and directories created in that phase
2. Updating the state tracking file to indicate that the phase needs to be re-executed

## Conclusion

This detailed implementation plan provides a structured approach to migrating the navigation structure from GitBook to DocFX. By breaking the migration into distinct phases with checkpoints and state tracking, we ensure that the process can be resumed if interrupted, and that each step can be verified before moving on to the next.

The end result will be a DocFX site with a navigation structure that matches the GitBook site, providing like-for-like functionality for users.
