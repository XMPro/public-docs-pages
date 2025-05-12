# Migration Tracking Document

This document provides an overview of the migration status from 'docs' to 'docs-docfx\docs' and links to section-specific tracking files.

## Migration Status Overview

The migration has been split into logical sections to make tracking more manageable. Each section has its own tracking file with detailed status information.

## Current Focus: Resources Section Image Issues

The Resources section has several files with image issues that need to be addressed:

### Files with Missing Images (❌)
1. **whats-new-in-4.2.md** - Contains placeholders for images that are not available:
   - Fig 1. Recommendation Alerts list
   - Fig 2. Score Factor Matrix
   - Fig 3. Auto-Assigning of an Escalated Recommendation Alert
   - Fig 4. Query Optimization for AD
   - Fig 5. New Permission - Hide Users Outside of Business Roles
   - Fig 6. Agent Category Visual Indicator

2. **faqs/implementation.md** - No images are embedded, but marked as having image issues. May need to check if images should be included.

3. **faqs/configuration.md** - Contains embedded video links using DocFX video syntax that may not be rendering correctly:
   ```
   > [!VIDEO https://www.youtube.com/watch?v=3eQHzy5nAy0]
   > [!VIDEO https://www.youtube.com/watch?v=KrUothBHQVg]
   > [!VIDEO https://youtu.be/_HYBmBCug2I?si=y1l5pccS44Ap5VHk]
   ```

### Files with Image Issues (⚠️)
1. **whats-new/index.md** - Contains HTML comments indicating missing images:
   ```
   <!-- Image needed: Fig 1: The areas in focus this release. -->
   <!-- Image needed: Fig 2: Tree Map Block -->
   <!-- Image needed: Fig 3: Live Feed Block -->
   <!-- Image needed: Fig 4: A global notification appears on the landing page -->
   <!-- Image needed: Fig 5: Data Stream Designer's Agent Usage Report -->
   ```

2. **icon-library.md** - Lists many icon filenames but doesn't actually display the icons. The file mentions "The images shown below are for reference" but no images are embedded.

3. **practice-notes/unified-recommendation-alert-management.md** - Has image references with correct path format (`images/practice_note_unified_XX.png`), but the images might be missing or have issues.

4. Other "What's New" files (whats-new.md, whats-new-in-4.1.13.md, whats-new-in-4.1.md, whats-new-in-4.0.md) - Similar image issues to index.md.

## Action Plan for Resources Section

1. **For Missing Images (❌)**:
   - Locate the original images from the GitBook source
   - Create appropriate images directory structure in docs-docfx
   - Copy and rename images as needed
   - Update image references in the markdown files

2. **For Video Embeds**:
   - Verify that the DocFX video syntax is correct and supported
   - Test rendering of video embeds
   - Consider alternative embedding methods if needed

3. **For Icon Library**:
   - Create a grid or gallery layout to display the actual icons
   - Ensure icons are properly copied to the images directory
   - Update references to display the icons inline

## Section-Specific Tracking Files

- [Getting Started](tracking/getting-started-tracking.md) - Browser requirements, free trial, etc.
- [Resources](tracking/resources-tracking.md) - What's new, integrations, FAQs, practice notes, etc.
- [Concepts](tracking/concepts-tracking.md) - XMPRO AI, data streams, agents, applications, recommendations, etc.
- [How-Tos](tracking/how-tos-tracking.md) - Data streams, apps, etc.
- [Blocks Toolbox](tracking/blocks-toolbox-tracking.md) - Layout, basic, AI, device input, actions, etc.
- [Administration](tracking/administration-tracking.md) - Administrative accounts, companies, users, etc.
- [Installation](tracking/installation-tracking.md) - Deployment, etc.
- [Release Notes](tracking/release-notes-tracking.md) - Version release notes

## Migration Status Legend

- ✓ - Completed
- ⚠️ - Needs attention
- ❌ - Not started/Failed
- N/A - Not applicable

## Migration Process

1. Update image paths (../images/ not ../../.gitbook/assets/)
2. Convert GitBook syntax to DocFX
3. Test each file locally
4. Create images directory and migrate images
5. Update toc.yml files as needed

## Migration Progress Summary

To view the detailed migration status for each section, click on the corresponding section link above.
