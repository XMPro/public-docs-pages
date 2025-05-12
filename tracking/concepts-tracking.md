# Concepts Migration Tracking

This document tracks the migration status of Concepts files from 'docs' to 'docs-docfx\docs'.

## Migration Status Table

| GitBook MD File | DocFX MD File | Content Confirmed | Images Correct | TOC Reachable |
|----------------|---------------|-------------------|----------------|---------------|
| docs\concepts\xmpro-ai\README.md | docs-docfx\docs\concepts\xmpro-ai\index.md | ✓ | ✓ | ✓ |
| docs\concepts\xmpro-ai\xmpro-notebook.md | docs-docfx\docs\concepts\xmpro-ai\xmpro-notebook.md | ✓ | ✓ | ✓ |
| docs\concepts\data-stream\README.md | docs-docfx\docs\concepts\data-stream\index.md | ✓ | ✓ | ✓ |
| docs\concepts\data-stream\stream-object-configuration.md | docs-docfx\docs\concepts\data-stream\stream-object-configuration.md | ✓ | ✓ | ✓ |
| docs\concepts\data-stream\verifying-stream-integrity.md | docs-docfx\docs\concepts\data-stream\verifying-stream-integrity.md | ✓ | ✓ | ✓ |
| docs\concepts\data-stream\running-data-streams.md | docs-docfx\docs\concepts\data-stream\running-data-streams.md | ✓ | ✓ | ✓ |
| docs\concepts\data-stream\timeline.md | docs-docfx\docs\concepts\data-stream\timeline.md | ✓ | ✓ | ✓ |
| docs\concepts\collection.md | docs-docfx\docs\concepts\collection.md | ✓ | ❌ | ✓ |
| docs\concepts\agent\README.md | docs-docfx\docs\concepts\agent\index.md | ✓ | ❌ | ✓ |
| docs\concepts\agent\virtual-vs-non-virtual-agents.md | docs-docfx\docs\concepts\agent\virtual-vs-non-virtual-agents.md | ✓ | ❌ | ✓ |
| docs\concepts\application\README.md | docs-docfx\docs\concepts\application\index.md | ✓ | ✓ | ✓ |
| docs\concepts\application\template.md | docs-docfx\docs\concepts\application\template.md | ✓ | ✓ | ✓ |
| docs\concepts\application\page.md | docs-docfx\docs\concepts\application\page.md | ✓ | ✓ | ✓ |
| docs\concepts\application\block.md | docs-docfx\docs\concepts\application\block.md | ❌ | ❌ | ✓ |
| docs\concepts\application\canvas.md | docs-docfx\docs\concepts\application\canvas.md | ✓ | ✓ | ✓ |
| docs\concepts\application\page-layers.md | docs-docfx\docs\concepts\application\page-layers.md | ✓ | ✓ | ✓ |
| docs\concepts\application\block-styling.md | docs-docfx\docs\concepts\application\block-styling.md | ❌ | ❌ | ✓ |
| docs\\concepts\\application\\devices.md | docs-docfx\\docs\\concepts\\application\\devices.md | ✓ | ✓ | ✓ |
| docs\concepts\application\flex.md | docs-docfx\docs\concepts\application\flex.md | ✓ | ❌ | ✓ |
| docs\concepts\application\block-properties.md | docs-docfx\docs\concepts\application\block-properties.md | ❌ | ❌ | ✓ |
| docs\concepts\application\data-integration.md | docs-docfx\docs\concepts\application\data-integration.md | ❌ | ❌ | ✓ |
| docs\concepts\application\navigation-and-parameters.md | docs-docfx\docs\concepts\application\navigation-and-parameters.md | ✓ | ❌ | ✓ |
| docs\concepts\application\variables-and-expressions.md | docs-docfx\docs\concepts\application\variables-and-expressions.md | ✓ | ❌ | ✓ |
| docs\concepts\application\app-files.md | docs-docfx\docs\concepts\application\app-files.md | ✓ | ❌ | ✓ |
| docs\concepts\application\metablocks.md | docs-docfx\docs\concepts\application\metablocks.md | ✓ | N/A | ✓ |
| docs\concepts\recommendation\README.md | docs-docfx\docs\concepts\recommendation\index.md | ❌ | ❌ | ✓ |
| docs\concepts\recommendation\rule.md | docs-docfx\docs\concepts\recommendation\rule.md | ✓ | ❌ | ✓ |
| docs\concepts\recommendation\execution-order.md | docs-docfx\docs\concepts\recommendation\execution-order.md | ✓ | ❌ | ✓ |
| docs\concepts\recommendation\auto-escalate.md | docs-docfx\docs\concepts\recommendation\auto-escalate.md | ✓ | ❌ | ✓ |
| docs\concepts\recommendation\form.md | docs-docfx\docs\concepts\recommendation\form.md | ❌ | ❌ | ✓ |
| docs\concepts\recommendation\action-requests.md | docs-docfx\docs\concepts\recommendation\action-requests.md | ❌ | ❌ | ✓ |
| docs\concepts\recommendation\notification.md | docs-docfx\docs\concepts\recommendation\notification.md | ❌ | ❌ | ✓ |
| docs\concepts\recommendation\recommendation-alert.md | docs-docfx\docs\concepts\recommendation\recommendation-alert.md | ✓ | ❌ | ✓ |
| docs\concepts\recommendation\deleted-items.md | docs-docfx\docs\concepts\recommendation\deleted-items.md | ❌ | ❌ | ✓ |
| docs\concepts\recommendation\recommendation-scoring.md | docs-docfx\docs\concepts\recommendation\recommendation-scoring.md | ❌ | ❌ | ✓ |
| docs\concepts\connector.md | docs-docfx\docs\concepts\connector.md | ✓ | ❌ | ✓ |
| docs\concepts\landing-pages.md | docs-docfx\docs\concepts\landing-pages.md | ✓ | ❌ | ✓ |
| docs\concepts\version.md | docs-docfx\docs\concepts\version.md | ✓ | ❌ | ✓ |
| docs\concepts\manage-access.md | docs-docfx\docs\concepts\manage-access.md | ✓ | ❌ | ✓ |
| docs\concepts\category.md | docs-docfx\docs\concepts\category.md | ✓ | ❌ | ✓ |
| docs\concepts\variable.md | docs-docfx\docs\concepts\variable.md | ✓ | ❌ | ✓ |
| docs\concepts\insights\README.md | docs-docfx\docs\concepts\insights\index.md | ✓ | N/A | ✓ |
| docs\concepts\insights\data-delivery-insights.md | docs-docfx\docs\concepts\insights\data-delivery-insights.md | ❌ | N/A | ✓ |

## Notes on Image Status

### Fixed Files
1. **data-stream/index.md** - Images have been copied from GitBook assets to the DocFX images directory:
   - DS-Search-Data-Streams.png
   - ds.newvisualindicator.concepts.data-stream.canvas.1.png
   - ds.newvisualindicator.concepts.data-stream.canvas.2.png
   - ds.newvisualindicator.concepts.data-stream.canvas.3.png

### Files Still Needing Attention
5. **Application files** - Images need to be copied and references updated (index.md, template.md, page.md, canvas.md, page-layers.md completed)
6. **All recommendation files** - Images need to be copied and references updated
7. **Other concept files** - Images need to be copied and references updated

## Next Steps
1. Move on to the application files
2. Update image references in the DocFX files
3. Move on to the application files
4. Address the recommendation files
5. Update content for files marked as not confirmed










