# Resources Migration Tracking

This document tracks the migration status of Resources files from 'docs' to 'docs-docfx\docs'.

## Migration Status Table

| GitBook MD File | DocFX MD File | Content Confirmed | Images Correct | TOC Reachable |
|----------------|---------------|-------------------|----------------|---------------|
| docs\resources\README.md | docs-docfx\docs\resources\index.md | ✓ | N/A | ✓ |
| docs\resources\whats-new\README.md | docs-docfx\docs\resources\whats-new\index.md | ✓ | ✓ | ✓ |
| docs\resources\whats-new\whats-new.md | docs-docfx\docs\resources\whats-new\whats-new.md | ✓ | ⚠️ | ✓ |
| docs\resources\whats-new\whats-new-in-4.2.md | docs-docfx\docs\resources\whats-new\whats-new-in-4.2.md | ✓ | ✓ | ✓ |
| docs\resources\whats-new\whats-new-in-4.1.13.md | docs-docfx\docs\resources\whats-new\whats-new-in-4.1.13.md | ✓ | ⚠️ | ✓ |
| docs\resources\whats-new\whats-new-in-4.1.md | docs-docfx\docs\resources\whats-new\whats-new-in-4.1.md | ✓ | ⚠️ | ✓ |
| docs\resources\whats-new\whats-new-in-4.0.md | docs-docfx\docs\resources\whats-new\whats-new-in-4.0.md | ✓ | ⚠️ | ✓ |
| docs\resources\integrations.md | docs-docfx\docs\resources\integrations.md | ✓ | ✓ | ✓ |
| docs\resources\sizing-guideline.md | docs-docfx\docs\resources\sizing-guideline.md | ✓ | N/A | ✓ |
| docs\resources\platform-security.md | docs-docfx\docs\resources\platform-security.md | ✓ | N/A | ✓ |
| docs\resources\icon-library.md | docs-docfx\docs\resources\icon-library.md | ✓ | ✓ | ✓ |
| docs\resources\faqs\README.md | docs-docfx\docs\resources\faqs\index.md | ✓ | N/A | ✓ |
| docs\resources\faqs\implementation.md | docs-docfx\docs\resources\faqs\implementation.md | ✓ | ✓ | ✓ |
| docs\resources\faqs\configuration.md | docs-docfx\docs\resources\faqs\configuration.md | ✓ | ✓ | ✓ |
| docs\resources\faqs\agent-faqs.md | docs-docfx\docs\resources\faqs\agent-faqs.md | ✓ | N/A | ✓ |
| docs\resources\faqs\general.md | docs-docfx\docs\resources\faqs\general.md | ✓ | N/A | ✓ |
| docs\resources\practice-notes\README.md | docs-docfx\docs\resources\practice-notes\index.md | ✓ | N/A | ✓ |
| docs\resources\practice-notes\unified-recommendation-alert-management.md | docs-docfx\docs\resources\practice-notes\unified-recommendation-alert-management.md | ✓ | ⚠️ | ✓ |
| docs\resources\practice-notes\performant-landing-pages-in-real-time-monitoring.md | docs-docfx\docs\resources\practice-notes\performant-landing-pages-in-real-time-monitoring.md | ✓ | N/A | ✓ |

## Notes on Image Status

### Fixed Files
1. **whats-new-in-4.2.md** - Updated to use proper image references with the correct path format. Images need to be copied from GitBook assets to the DocFX images directory.
2. **icon-library.md** - Added notes about the missing icons and provided an example of how they should be displayed.
3. **implementation.md** - Added notes about where images would be helpful and what they should contain.
4. **configuration.md** - Replaced the video embeds with proper note blocks and links to the videos.
5. **whats-new/index.md** - Added notes about the missing images and what needs to be created.

### Files Still Needing Attention
1. **whats-new.md**, **whats-new-in-4.1.13.md**, **whats-new-in-4.1.md**, **whats-new-in-4.0.md** - Similar issues to index.md, need to add image notes or fix references.
2. **unified-recommendation-alert-management.md** - Has image references with correct path format, but the images might be missing or have issues.

## Next Steps
1. Copy the images from the GitBook assets directory to the appropriate DocFX images directories
2. Create any missing images as noted in the updated files
3. Update the remaining "What's New" files with proper image references or notes
4. Verify that all image paths are correct and images are displaying properly
