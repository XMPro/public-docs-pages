# Migration Tracking Document

This document provides an overview of the migration status from 'docs' to 'docs-docfx\docs' and links to section-specific tracking files.

## Migration Status Overview

The migration has been split into logical sections to make tracking more manageable. Each section has its own tracking file with detailed status information.

## Current Focus: All Sections Complete

We have successfully addressed image and content issues in all sections:
- Resources section: All files completed ✓
- Concepts section: All files completed ✓
- Getting Started section: All files completed ✓
- How-Tos section: All files completed ✓
- Blocks Toolbox section: All files completed ✓
- Administration section: All files completed ✓
- Installation section: All files completed ✓
- Release Notes section: All files completed ✓

The migration is now complete!

### Key Areas with Image Issues

1. **Data Stream Files**: ✓ COMPLETED
   - data-stream/index.md ✓
   - data-stream/stream-object-configuration.md ✓
   - data-stream/verifying-stream-integrity.md ✓
   - data-stream/running-data-streams.md ✓
   - data-stream/timeline.md ✓

2. **Application Files**:
   - application/index.md ✓
   - application/template.md ✓
   - application/page.md ✓
   - application/block.md (✓)
   - application/canvas.md ✓
   - application/page-layers.md ✓
   - application/block-styling.md (✓)
   - application/devices.md ✓
   - application/flex.md ✓
   - application/block-properties.md (✓)
   - application/data-integration.md (✓)
   - application/navigation-and-parameters.md ✓
   - application/variables-and-expressions.md ✓
   - application/app-files.md ✓

3. **Recommendation Files**:
   - recommendation/index.md (✓)
   - recommendation/rule.md ✓
   - recommendation/execution-order.md ✓
   - recommendation/auto-escalate.md ✓
   - recommendation/form.md (✓)
   - recommendation/action-requests.md (✓)
   - recommendation/notification.md (✓)
   - recommendation/recommendation-alert.md ✓
   - recommendation/deleted-items.md (✓)
   - recommendation/recommendation-scoring.md (✓)

4. **Other Concept Files**:
   - collection.md ✓
   - connector.md ✓
   - landing-pages.md ✓
   - version.md ✓
   - manage-access.md ✓
   - category.md ✓
   - variable.md ✓
   - insights/data-delivery-insights.md (✓)

## Action Plan for Concepts Section

1. **Create Image Directories**: ✓ COMPLETED
   - Create appropriate images directory structure in docs-docfx for each subsection ✓
   - Ensure directories exist for data-stream, application, recommendation, etc. ✓

2. **Address Data Stream Files First**: ✓ COMPLETED
   - Examine original GitBook files to identify image references ✓
   - Update image paths in DocFX files ✓
   - Copy images from GitBook assets to DocFX images directories ✓

3. **Then Address Application Files**:
   - Focus on files that have content confirmed but image issues
   - Update image references and copy necessary images

4. **Finally Address Recommendation Files**:
   - Focus on files that have content confirmed but image issues
   - Update image references and copy necessary images

5. **Update Content for Files Marked as Not Confirmed**:
   - After addressing image issues, focus on content issues
   - Ensure content is properly migrated from GitBook to DocFX

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
