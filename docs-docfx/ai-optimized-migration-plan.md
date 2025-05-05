# AI-Optimized DocFX Migration Plan

This document provides a streamlined migration plan optimized for AI-assisted migration from GitBook to DocFX.

## Migration Status Overview

| Section | Status | Progress |
|---------|--------|----------|
| Project Structure | ✅ Complete | 100% |
| Navigation | ✅ Complete | 100% |
| Introduction & Getting Started | ✅ Complete | 100% |
| Concepts | ✅ Complete | 100% |
| How-Tos | ✅ Complete | 100% |
| Blocks-Toolbox | ✅ Complete | 100% |
| Administration | ✅ Complete | 100% |
| Installation | ✅ Complete | 100% |
| Release Notes | ✅ Complete | 100% |
| Resources | ✅ Complete | 100% |
| Styling & Customization | 🔄 In Progress | 50% |
| Link Verification | ✅ Complete | 100% |
| Final Review & Deployment | ⏳ Not Started | 0% |

## AI-Friendly Migration Process

### 1. File Structure Analysis

```
# Command to analyze GitBook structure
list_files docs-gitbook/docs --recursive

# Command to analyze DocFX structure
list_files docs-docfx/docs --recursive
```

### 2. Content Migration Workflow

For each file to migrate:

1. **Read source content**:
   ```
   read_file docs-gitbook/docs/path/to/file.md
   ```

2. **Transform content** using these patterns:
   - Convert GitBook syntax to DocFX syntax
   - Update image paths from `../assets/` to `../images/`
   - Update internal links to use correct relative paths
   - Preserve metadata and front matter

3. **Write transformed content**:
   ```
   write_to_file docs-docfx/docs/path/to/file.md
   ```

4. **Verify file**:
   ```
   read_file docs-docfx/docs/path/to/file.md
   ```

### 3. Image Migration

```
# Command to identify images in GitBook
search_files docs-gitbook/docs/assets "\\.(png|jpg|jpeg|gif|svg)$"

# Command to create images directory if needed
execute_command mkdir -p docs-docfx/docs/path/to/images

# Copy and rename images
execute_command copy docs-gitbook/docs/assets/image.png docs-docfx/docs/path/to/images/
```

### 4. Navigation Structure

```
# Read GitBook navigation
read_file docs-gitbook/docs/SUMMARY.md

# Create/update DocFX TOC files
write_to_file docs-docfx/docs/toc.yml
```

## Content Transformation Patterns

### Markdown Conversion Table

| GitBook Syntax | DocFX Syntax | Notes |
|----------------|--------------|-------|
| `{% hint style="info" %}` <br> Content <br> `{% endhint %}` | `> [!NOTE]` <br> `> Content` | Convert hints to DocFX alerts |
| `{% tabs %}` <br> `{% tab title="Tab 1" %}` <br> Content <br> `{% endtab %}` <br> `{% endtabs %}` | `# [Tab 1](#tab/tab1)` <br> Content <br> <br> `***` | Convert tabs to DocFX tabs |
| `![Alt text](../assets/image.png)` | `![Alt text](../images/image.png)` | Update image paths |
| `[Link text](../path/to/page.md)` | `[Link text](../path/to/page.md)` | Verify relative paths |

### Common Patterns to Identify

1. **Image References**: 
   - Regex: `!\[.*?\]\(.*?assets.*?\)`
   - Replace with: `![same-alt-text](../images/image-name.png)`

2. **Internal Links**:
   - Regex: `\[.*?\]\(.*?\.md.*?\)`
   - Verify and update paths

3. **GitBook Hints/Callouts**:
   - Regex: `{% hint style="(info|warning|danger)" %}([\s\S]*?){% endhint %}`
   - Replace with: `> [!NOTE|WARNING|CAUTION]\n> $2`

4. **GitBook Tabs**:
   - Regex: `{% tabs %}([\s\S]*?){% endtabs %}`
   - Process tab content with: `{% tab title="(.*?)" %}([\s\S]*?){% endtab %}`

5. **Code Blocks**:
   - Verify language specification is preserved

## Verification Process

For each migrated file:

1. **Build check**:
   ```
   execute_command cd docs-docfx && docfx build
   ```

2. **Link verification**:
   ```
   execute_command cd docs-docfx && ./verify-links.ps1
   ```

3. **Image verification**:
   ```
   execute_command cd docs-docfx && ./verify-images.ps1
   ```

4. **Navigation verification**:
   ```
   execute_command cd docs-docfx && ./verify-navigation.ps1
   ```

## AI-Specific Migration Tips

1. **Process in logical batches**:
   - Process files by section/category
   - Handle related files together (e.g., index.md and toc.yml)

2. **Maintain context awareness**:
   - Track parent-child relationships in navigation
   - Preserve cross-references between documents

3. **Handle complex transformations**:
   - Break down complex GitBook components into steps
   - Process tables, code blocks, and special formatting separately

4. **Validation approach**:
   - Validate syntax before content (structure first)
   - Check for common migration errors (broken links, missing images)

5. **Error handling**:
   - Log issues for human review
   - Provide clear error descriptions and locations

## Common Migration Challenges

1. **Nested directory structures**:
   - Map GitBook nested paths to DocFX structure
   - Update relative links accordingly

2. **Special GitBook components**:
   - Identify custom GitBook plugins/components
   - Find DocFX equivalents or HTML alternatives

3. **Image path consistency**:
   - Standardize on `../images/` pattern
   - Handle special characters in filenames

4. **Metadata preservation**:
   - Preserve front matter
   - Convert GitBook-specific metadata to DocFX format

5. **Code sample formatting**:
   - Preserve language specifications
   - Maintain indentation and formatting

## Testing Locally

```
# Build the DocFX site
execute_command cd docs-docfx && docfx build

# Serve the site locally
execute_command cd docs-docfx && ./start-docfx-server.ps1
```

## Deployment

```
# Commit changes
execute_command git add .
execute_command git commit -m "Migrate section: [section name]"
execute_command git push origin main
```

## Syntax Conversion Reference

### Alerts/Notes

GitBook:
```
{% hint style="info" %}
This is important information.
{% endhint %}
```

DocFX:
```
> [!NOTE]
> This is important information.
```

### Tabs

GitBook:
```
{% tabs %}
{% tab title="Windows" %}
Windows instructions here.
{% endtab %}
{% tab title="Linux" %}
Linux instructions here.
{% endtab %}
{% endtabs %}
```

DocFX:
```
# [Windows](#tab/windows)
Windows instructions here.

# [Linux](#tab/linux)
Linux instructions here.

***
```

### Images

GitBook:
```
![Description](../../.gitbook/assets/image.png)
```

DocFX:
```
![Description](../images/image.png)
```

### Links

GitBook:
```
[Link text](../other-section/page.md)
```

DocFX:
```
[Link text](../other-section/page.md)
```

## Conclusion

This AI-optimized migration plan provides a structured approach for efficiently migrating content from GitBook to DocFX. By following these patterns and processes, the migration can be completed systematically while maintaining content integrity and structure.
