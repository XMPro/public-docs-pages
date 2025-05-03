# Working with Metadata in DocFX

Metadata in DocFX allows you to control various aspects of your documentation, from page titles to global site settings. This guide explains how to use metadata effectively.

## Types of Metadata

DocFX supports several types of metadata:

1. **Global Metadata**: Applied to the entire documentation site
2. **File Metadata**: Applied to specific files or groups of files
3. **YAML Header Metadata**: Defined at the top of individual markdown files

## Global Metadata

Global metadata is defined in your `docfx.json` file under the `globalMetadata` section:

```json
"build": {
  "globalMetadata": {
    "_appTitle": "My Documentation",
    "_enableSearch": true,
    "_disableNavbar": false,
    "_appFooter": "© 2025 My Company",
    "_gitContribute": {
      "repo": "https://github.com/username/repo",
      "branch": "main"
    }
  }
}
```

Common global metadata properties include:

| Property | Description |
|----------|-------------|
| `_appTitle` | The title of your documentation site |
| `_appName` | The name of your application |
| `_enableSearch` | Whether to enable search functionality |
| `_disableNavbar` | Whether to disable the top navigation bar |
| `_appFooter` | HTML content for the footer |
| `_gitContribute` | Configuration for GitHub contribution links |

## File Metadata

File metadata is applied to specific files or file patterns:

```json
"build": {
  "fileMetadata": {
    "_layout": {
      "api/**.yml": "apiLayout",
      "docs/**.md": "conceptual"
    },
    "_monikerRange": {
      "api/v1/**.yml": "v1",
      "api/v2/**.yml": "v2"
    }
  }
}
```

This allows you to apply different settings to different parts of your documentation.

## YAML Header Metadata

You can add metadata to individual markdown files using a YAML header at the top of the file:

```markdown
---
title: My Custom Title
description: A detailed description of this page
author: John Doe
ms.date: 04/28/2025
---

# Content starts here
```

## Commonly Used Metadata Properties

| Property | Description |
|----------|-------------|
| `title` | The title of the page (shown in browser tab) |
| `description` | Description for SEO purposes |
| `author` | Author of the content |
| `ms.date` | Last updated date |
| `_layout` | The layout template to use |
| `uid` | Unique identifier for cross-referencing |
| `tags` | Tags for categorization |

## Example: Using Metadata for Versioning

You can use metadata to implement versioning in your documentation:

1. Define version monikers in your `docfx.json`:

```json
"build": {
  "globalMetadata": {
    "_defineVersions": ["v1", "v2", "v3"]
  }
}
```

2. Apply version monikers to files:

```json
"build": {
  "fileMetadata": {
    "_monikerRange": {
      "docs/v1/**.md": "v1",
      "docs/v2/**.md": "v2",
      "docs/v3/**.md": "v3"
    }
  }
}
```

3. Add version selectors to your template

## Best Practices

- **Be consistent**: Use consistent naming conventions for metadata properties
- **Document your metadata**: Keep a record of custom metadata properties you define
- **Don't overuse**: Only add metadata that serves a specific purpose
- **Validate**: Regularly check that your metadata is correctly applied
